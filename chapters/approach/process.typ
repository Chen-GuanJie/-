#import "@preview/modern-sjtu-thesis:0.5.1": *
#import "../../define.typ": *

== 流程不一致性检测<app:process>

#imagex(
  image(
    "../../figures/process/buy/buy_copy.pdf",
    width: 80%,
  ),
  caption: [证券买入流程，取自某工业级交易应用的设计原型。该状态转移以抽象形式描述为 ``Buy 100 shares``。],
  caption-en: [The process of buying stocks, taken from the design mock-up of an industrial trading application. The state transition is abstractly described as "Buy 100 shares".],
  label-name: "process-eg",
)
对于设计稿中的每一个状态转移（由源界面 $bf(screen)_src$、目标界面 $bf(screen)_tar$ 及其转移描 $d e s c$ 组成，见 @img:process-eg）
，以及对应的应用中观测到的起始界面 $bf(screen)^*_src$，流程验证包含两个核心环节：

1) 将抽象转移描述映射为可执行动作序列。该映射首先对 $bf(screen)_src$ 与 $d e s c$ 进行语义解析，生成若干候选动作序列（action candidates）。解析过程中结合自然语言提示、界面上可交互控件的检测结果以及上下文约束，利用视觉-语言模型（VLM）对歧义进行消解并输出格式化的动作序列。为提高可靠性，系统对候选序列进行排序与打分，打分项包括与界面元素的匹配置信度、动作的可执行性估计和历史回放成功率。

2) 在真实设备上回放并验证。选定高置信度的动作序列后，使用自动化执行工具（如 uiautomator @uiautomator2）在应用上逐步回放这些动作，并在每一步采集屏幕截图、UI 层次信息与执行日志。若动作导致界面跳转，则对跳转后的界面与设计稿中的目标界面 $bf(screen)_tar$ 进行相似度比较，见@eq:screen-similarity。相似度不足以判定一致时，将触发补偿策略：

- 候选回放重试：尝试该动作序列的同类替代（例如对相同语义但不同控件 ID 的候选进行替换）；
- 回溯与替代选择：若局部动作失败导致后续步骤不可达，则回溯至最近的稳定状态并尝试下一个高置信度候选序列；
- 人工校验触发：当自动补救多次失败或不确定性超过阈值时，记录详尽的证据并将该用例提交人工复核。

为保证流程检测的鲁棒性与可复现性，回放模块还对以下要素进行控制与记录：动作执行的超时阈值、单步最大重试次数、每次交互后的静止等待时间以及完整的执行轨迹。所有执行证据（屏幕截图、UI 树、动作序列与相似度评分）被持久化，以便生成最终报告与支持事后分析。

#imagex(
  image(
    "../../figures/process_inconsistency.pdf",
    width: 100%,
  ),
  caption: [流程执行工作流。],
  caption-en: [The workflow of process execution.],
  label-name: "process-inconsistency",
)

鉴于设计稿的文本描述通常具有歧义且为多模态（文本+图像）形式，VLM 在此承担从模糊描述到标准化动作的桥接作用。例如，对于“trigger the submit button”之类的模糊指令，VLM 会结合带有组件 ID 的当前界面，识别最可能对应的交互控件并返回可执行的原子操作（如 click(widget_1)）。

该过程面临两类主要挑战：界面噪声（大量非目标元素可能干扰匹配）以及 VLM 输出的可解析性（自然语言式回答需被约束为可执行格式）。为此，视觉提示（visual prompt）与组件高亮标注被用于限定 VLM 的关注范围，并将输出限制为预定义的操作集合，从而保证动作可直接被自动化工具解析与回放。

回放成功且判定为与目标界面一致时，若该流程仍包含后续操作，则将当前界面视为新的起始界面继续执行；若不一致且补救无效，则记录为一次流程不一致并在最终报告中列出相应证据与可能的根因。
=== 视觉提示设计 <app:visual-prompt>

#tablex(
  columns: (2cm, 1fr),
  align: (left + top, left + top),
  caption: [动作补全流程不一致检测的视觉提示],
  caption-en: [Visual prompt for process inconsistency checking with action completion. The components in blue are mutable and vary according to the current screen content.],
  label-name: "vlm-prompt",

  table.cell(colspan: 2)[*系统提示（不可覆盖）*],

  [*任务目标*],
  [给定当前的 GUI 屏幕，你需要返回一系列操作以跳转到下一个屏幕。],

  [*输入/输出描述*],
  [
    输入是带有控件边界框标注（可操作控件）的*当前 GUI 屏幕截图*。

    输出应该是一个*操作列表*。
    操作可以是以下之一：
    + *click*(`widget_id`): 包括激活输入框、切换开关、选中复选框等。
    + *long_press*(`widget_id`)
    + *send_keys*(`value`): 选中控件后，可以设置其值。
    + *scroll*(`widget_id`, direction, distance): 向左、向右、向上或向下滚动一定像素距离。如果未指定 `widget_id`，默认操作是滚动整个屏幕。
    + *swipe*(`widget_id`, direction)
    + *drag_and_drop*(`widget_id1`, `widget_id2`): 将 `widget_1` 拖动到 `widget_2` 的中心。
    + *go_back*(): 这将返回到上一个屏幕。
  ],

  [*样本示例*],
  [
    例如，如果我们当前的 GUI 屏幕有两个控件：

    `widget_1` 是一个文本为“confirm”的按钮，`widget_2` 是一个占位符文本为“please input the password”的输入框。

    在我针对当前 GUI 屏幕执行 *click*(`widget_1`) 操作后，
    屏幕没有变化，这表明 `widget_2` 未填写。

    因此，修正后的操作链应为
    *click*(`widget_2`),
    *send_keys*("my_password"),
    *click*(`widget_1`).
  ],

  table.cell(colspan: 2)[*用户提示（可修改）*],

  image("../../figures/gui_screen_annotated.pdf", width: 160%),
  [
    给定当前屏幕和描述，
    请提供下一个立即执行的正确操作。

    *动作输入*

    {自然语言的动作描述。例如：“买入100股并继续”}

    *GUI 截图输入*

    {左侧显示的当前 GUI 截图。}

    *(可选) 反馈*

    你之前的回答不正确，
    你确定引用了正确的控件吗，
    或者该动作是否存在于动作空间中？
  ],
  breakable: false,
  header: (),
)

为将模糊的设计描述稳定地映射为设备可执行的动作，引入了一个受控的 VLM 管道。输入包括带有组件 ID 注释的当前界面截图与自然语言转移描述，VLM 被要求输出结构化动作序列（例如模板化的 click(widget_id)、send_keys(widget_id, value) 或 JSON 列表），以便解析器能进行确定性解析与后续回放。

为减少噪声与幻觉带来的误判，系统在提示和后处理两端施加约束：

- 提示端：通过视觉提示将检测到的可交互控件高亮并附加索引，在 system prompt 中限定允许的动作集合与返回格式，并使用少量示例（in‑context examples）演示期望输出，从而引导模型聚焦并生成可解析的候选序列；
- 后处理端：对模型输出进行结构化解析，验证所引用的组件 ID 与参数的有效性，并计算综合置信度（结合模型得分、控件匹配置信度与语义一致性）。当置信度低于阈值时，触发候选重试、格式化重询或人工复核流程。

同时引入若干工程手段以提升鲁棒性：对候选序列按置信度排序并逐一回放，回放前进行可执行性检查（如控件可见性与可交互性），对失败结果将执行迭代反馈：把执行时的截图、UI 树与错误信息作为上下文再次询问 VLM 以修正动作序列。输出采用模板化或小型 DSL，使解析器能够做确定性映射并降低歧义。

该管道的目标是在尽可能减少人工干预的同时，确保从多模态设计稿到设备级动作的映射高效、可审计且易于故障追踪。
/*todo
在这里帮我写一个纯文本提示词的方法，视觉提示词是用在支持图片理解的多模态模型上的，在图片上进行标注。而对于一些部署场景只有纯文本的大模型，也提供了一套文本描述界面的方法。根据前面递归布局分解控件，我们可以得到所有控件在设计稿中的层级关系和位置关系，我们可以将这些信息转化为文本描述的形式，用回车和空格来移动控件到其分组所在的区域，换行相当于新的一行控件，作为输入提示词的一部分。比如：
----------------------------------------
|返回                搜索
|-------------------|-------------------|
|                                       |
|   输入框1        输入框2        确认    |
|
|
|
|
|
|                   买入                 |
|                   卖出                 |
----------------------------------------
上面即为一个设计稿的文本描述，第一行是两个控件，第二行是三个控件，第三行是两个控件。每个控件之间用空格分隔，每行之间用换行符分隔。对于每个控件，我们可以在文本中标注它的类型、位置、层级关系等信息，例如：
*/
=== 界面匹配 <app:screen-matching>

界面导航完成后，需要判定跳转结果是否在语义与视觉上与设计稿目标界面相匹配。为此，采用基于组件匹配的定量度量：首先使用@algo:widget-matching 进行控件匹配，并根据@eq:screen-similarity 度量两个界面的相似度。

该度量不仅能反映匹配对的总体质量，还天然对目标界面中组件的覆盖程度给出惩罚（即未匹配的目标组件会降低归一化后的得分）。在实际应用中，可根据任务需求设定识别阈值：较高阈值用于严格一致性检验（关注像素级与语义级一致），较低阈值用于容忍实现细微差异的近似匹配场景。若得分低于设定阈值，系统将标记为界面不一致并记录相应的匹配证据与差异项，便于后续定位与修复。

$
  "sim"(bf(screen), bf(screen)^tar) = (sum_(bf(widget)_i in bf(widgetset), bf(widget)_j in bf(widgetset)^tar) A_(i,j) dot bf(1)(bf(widget)_i in bf(widgetset), bf(widget)_j in bf(widgetset)^tar "匹配")) / (|bf(widgetset)^tar|)
$ <eq:screen-similarity>

=== 不一致性报告生成 <app:process-inconsistency-report>

系统基于形式化定义对流程一致性进行自动化判定与报告生成。记设计稿中的期望流程为 $bf(process)^tar = (bf(screenset)^tar, bf(actionchainset)^tar)$，而在实现端实际执行得到的流程为 $bf(process) = (bf(screenset), bf(actionchainset)^tar_(c o m p l e t e))$。流程不一致的判定准则是：存在某一时间步 $t$，使得执行界面 $bf(screen)_t$ 与原型对应界面 $bf(screen)^tar_t$ 的相似度低于阈值 $epsilon_(s c r e e n)$，即满足：

$exists screen_t in screenset; screen^tar_t in screenset^tar; s i m(bf(screen)_t, bf(screen)^tar_t) < epsilon_(s c r e e n)$

针对上述判定出的流程差异以及 @sec:ps 中定义的其他细粒度不一致性，系统将自动生成一份包含完整证据链的结构化审计报告。报告以条目化形式详述每一项违规，涵盖唯一标识符（ID）、时间戳、违规类型、多媒体证据（如对比截图与差异标注）、执行轨迹（动作序列与 UI 树）、相似度评分及根因分析建议。具体的报告内容包括：

- 缺失控件（Missing widget）：列出设计稿中被识别但在实现中未匹配到的控件信息（例如 $bf(widget)^(tar)_i$），并附带该控件在设计稿中的截图、预期位置与类型说明，以及在实现端未检测到或检测失败的证据（若存在则包含候选相似控件与其相似度评分）。

- 多余控件（Extraneous widget）：在实现界面的截图上高亮显示未在设计稿中出现的控件，提供其边界框、类型猜测与在实现中出现位置的上下文截图，供开发者复核是否为允许的实现扩展或误加的元素。

- 语义变化（Semantic variation）：对已匹配的组件对，列出发生变化的属性（如类型变更、文案修改、图像/图标替换、颜色与样式变化等），并给出各类属性的定量差异（例如文本相似度得分、颜色直方图距离、IoU 或尺寸比差异），以便评估变更的严重程度。

- 流程不一致（Process-level inconsistency）：对未能按预期完成的状态转移，报告实现图中缺失或不匹配的边（例如 $(bf(screen)_t, bf(action)_t, bf(screen)_(t+1)$），并附带导致失败的步骤序列、回放日志与最终界面差异摘要。

此外，报告将对每一项违规给出：

- 严重度评分（Critical / Major / Minor），基于相似度阈值、功能影响范围与可达性影响评估；
- 优先级与修复建议，例如替换实现中的控件类型、修正文本资源、调整控件位置或修改事件绑定；
- 可追踪的修复项（Issue）格式，支持导出为 JSON 或 HTML 报表，并能与缺陷跟踪系统集成以便后续跟进；
- 聚合统计视图，展示在一次测试或一组测试中发现的不一致性数量、各类违规的分布、自动回放成功率及长期趋势。

所有报告条目都附带可回放的证据包（包含截图、UI 树、动作序列与相似度矩阵的快照），以便在后续的人工复核或回归验证时重现问题场景。此类结构化与可导出的报告能够加速问题定位、量化实现偏差并为设计与实现之间的协同修复提供直接依据。

