#import "@preview/modern-sjtu-thesis:0.5.1": *
#let bf(x) = math.bold(math.upright(x))

== 流程不一致性检测<app:process>

#imagex(
  image(
    "../../figures/process/buy/buy_copy.pdf",
    width: 80%,
  ),
  caption: [证券买入流程，取自某工业级交易应用的设计原型。该状态转移以抽象形式描述为 ``Buy 100 shares''。],
  caption-en: [The process of buying stocks, taken from the design mock-up of an industrial trading application. The state transition is abstractly described as "Buy 100 shares".],
  label-name: "process-eg",
)
对于设计原型中的每一个状态转移（由源界面 $bf(s)_("src")$、目标界面 $bf(s)_("tar")$ 及其转移描述 $"desc"$ 组成）
（如 @img:process-eg 所示）
以及应用中的源界面 $bf(s)^*_("src")$，我们
（1）将 $bf(s)_("src")$ 和 $"desc"$ 翻译为在 $bf(s)^*_("src")$ 上可执行的一系列具体操作；
（2）比较应用中得到的结果界面，判断其是否与期望界面 $bf(s)_("tar")$ 等价。

#imagex(
  image(
    "../../figures/process_inconsistency.pdf",
    width: 100%,
  ),
  caption: [流程执行工作流。],
  caption-en: [The workflow of process execution.],
  label-name: "process-inconsistency",
)
鉴于如 @img:process-eg 所示的文本描述存在歧义且设计为多模态形式（即同时包含文本与图像），
我们采用视觉-语言模型（VLM）来推导具体的操作序列，如 @img:process-inconsistency 所示，
并通过 $"uiautomator"$ 工具 @uiautomator2 执行这些操作。
如果发生了界面跳转，我们将验证更新后的界面是否与原型中的目标界面一致。
当二者不匹配时，即报告一次流程不一致性。
如果更新后的界面正确，且流程仍包含后续操作，则该更新后的界面将作为新的起始界面。
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

  [*少样本示例*],
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

  image("../../figures/gui_screen_annotated.pdf", width: 100%),
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

我们使用 VLM 将 ``模糊的设计描述`` 转换为 ``标准化的操作``。
例如，对于一个模糊的转移描述 ``trigger the submit button``，
VLM 可以结合带有组件 ID 的 GUI 界面，
识别出与提交按钮对应的组件 ID（如 widget 1），
并最终返回一个可执行的操作，格式为 ``click(widget\_1)``。
该过程主要面临以下两个挑战：

+ 界面中的噪声信息：一个界面可能包含大量元素，既包括可交互组件，也包括不可交互组件，以及与应用功能无关的图标。这些无关图标会对操作补全任务造成干扰，因此需要被忽略。
+ VLM 输出的可解析性与灵活性：VLM 往往以高度灵活的自然语言形式生成响应，这使得其结果难以直接解析为可在移动应用上执行的程序化操作。

为此，我们提出了一种视觉提示（visual prompt）设计，使 VLM 能够专注于关键组件，
并将其输出限制在一种可解析的格式中。
@tbl:vlm-prompt 给出了我们使用的视觉提示，
其由一个在所有样本中共享的系统提示（system prompt）
以及一个基于当前 GUI 界面定制的用户提示（user prompt）组成。
一方面，我们利用组件检测模型（见@app:widget-detection）
仅对可交互组件进行高亮标注，并附加组件索引。
通过这种方式，VLM 能够更明确地聚焦于相关区域，并生成可被引用的响应。
另一方面，我们限定了 LLM 的操作空间，
覆盖主要的组件交互类型，包括点击（click）、长按（long press）、输入文本（send keys）、滚动（scroll）、滑动（swipe）和拖拽（drag）。
需要注意的是，我们主要考虑应用内部相关的交互，
而不涉及诸如切换 WiFi、蓝牙等系统级操作。
为进一步控制随机性，我们采用了上下文学习（in-context learning）方法，
即提供少量示例来展示期望的输出格式。
为节省 token 消耗，这些示例以纯文本形式给出。

在用户提示中，查询同时包含文本与图像两种模态。
自然语言形式的操作描述被输入给 LLM，
而查询截图则标注了可交互组件及其 ID，
从而引导 VLM 重点关注这些被高亮的组件。
VLM 的查询过程可以迭代进行，直到发生界面跳转或达到交互次数上限。
如果界面未发生变化，我们会向 VLM 提供反馈，
并要求其对之前的回答进行反思和修正。

=== 界面匹配 <app:screen-matching>

在完成界面导航后，我们需要验证跳转后的界面是否与原型中的目标界面一致。
我们的界面匹配度量基于算法 @algo:widget-matching 中的组件匹配结果。
给定更新后的界面和目标界面，
我们计算所有匹配组件对的相似度之和，
并以目标界面中的组件总数进行归一化（见 @eq:screen-similarity）。
通过对 $"sim"(bf(s), bf(s)^"tar")$ 应用一个阈值，
即可判断更新后的界面是否与目标界面足够接近。

$
  "sim"(bf(s), bf(s)^"tar") = (sum_(bf(w)_i in bf(W), bf(w)_j in bf(W)^"tar") A_(i,j) dot bf(1)(bf(w)_i in bf(W), bf(w)_j in bf(W)^"tar" "匹配")) / (|bf(W)^"tar"|)
$ <eq:screen-similarity>

=== 不一致性报告生成 <app:process-inconsistency-report>

基于 @sec:ps 中提到的不一致性定义，我们将生成一份详细的报告，列出实现中发现的所有违规行为，并附带相关的错误屏幕截图、实现图 $bf(p)$、违规类型及描述。
具体而言：
+ 对于缺失控件，我们报告设计稿中的控件信息 $bf(w)^"tar"_i$。
+ 对于多余控件，我们在实现屏幕的截图中高亮显示它们。
+ 对于语义变化，我们报告具体的变更属性。
+ 对于流程不一致，我们报告实现图中缺失的边 $(bf(s)_t, bf(A)_t, bf(s)_(t+1))$。

