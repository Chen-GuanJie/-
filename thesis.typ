#import "@preview/modern-sjtu-thesis:0.5.1": *

#let (
  doctype,
  date,
  twoside,
  anonymous,
  info,
  doc,
  preface,
  mainmatter,
  appendix,
  cover,
  cover-en,
  declare,
  abstract,
  abstract-en,
  outline,
  image-outline,
  table-outline,
  algorithm-outline,
  nomenclature,
  bib,
  acknowledgement,
  achievement,
  summary-en,
) = documentclass(
  doctype: "master", // 文档类型: "master" | "doctor" | "bachelor"
  date: datetime.today(), // 日期
  twoside: false, // 双面模式
  print: false, // 打印模式, 设置为 true 时，根据奇偶页调整页边距
  anonymous: false, // 盲审模式
  info: (
    student_id: "123033910155",
    name: "陈贯劼",
    name_en: "Chen Guan Jie",
    degree: "工学硕士",
    supervisor: "林云",
    supervisor_en: "Prof. Lin Yun",
    title: "上海交通大学学位论文格式模板",
    title_en: "DISSERTATION TEMPLATE FOR MASTER DEGREE OF ENGINEERING IN SHANGHAI JIAO TONG UNIVERSITY",
    school: "计算机学院",
    school_en: "School of Computer Science",
    major: "计算机专业",
  ),
)

#show: doc

#cover()

#cover-en()

#declare(
  confidentialty-level: "internal", // 保密级别: "public" | "internal" | "secret" | "confidential"
  confidentialty-year: 2, // 保密年份数，请根据保密级别的要求填写
  date: datetime.today(),
  original-statement-sign: place(dx: 13cm, dy: -1.3cm, image("figures/student-sign.png", height: 2em)), // 请根据签名图片的大小，自行调整图片的高度和位置
  authorization-author-sign: place(dx: 5cm, dy: -1.3cm, image("figures/student-sign.png", height: 2em)),
  supervisor-sign: place(dx: 4cm, dy: -1.2cm, image("figures/supervisor-sign.png", height: 2em)),
) // 不需要显示日期和签名，可直接注释

#show: preface

#abstract(keywords: (
  "学位论文",
  "论文格式",
  "规范化",
  "模板",
))[
  图形用户界面（GUI）测试对于保障移动应用程序的可靠性至关重要。当前主流的GUI测试方法在探索更多应用场景和发现通用缺陷（如应用程序崩溃）方面表现出色。然而，工业级GUI测试还需要检测应用特定缺陷，例如屏幕布局、控件位置或GUI跳转与应用设计师所创建的GUI设计原型之间的偏差。这些设计原型明确规定了预期的屏幕界面、控件及其相应的交互行为。验证GUI设计与实际实现之间的一致性是一项耗时费力的工作，但这一验证环节在工业级GUI测试中具有重要意义。
  本研究提出了GUIPilot方法，用于检测移动端设计原型与其实现之间的不一致性。移动端设计通常由设计原型组成，这些原型规定了：（1）预期的屏幕外观（如控件布局、颜色和形状）；（2）预期的屏幕行为，即屏幕之间的跳转方式（如带有文本描述标签的控件）。给定设计原型及其对应的应用实现，GUIPilot能够同时报告屏幕不一致性和流程不一致性。
  在屏幕不一致性检测方面，GUIPilot将每个屏幕抽象为控件容器，其中每个控件由其位置、宽度、高度和类型表示。通过定义控件的偏序关系以及屏幕中控件替换、插入和删除的代价，本文将屏幕匹配问题转化为可估计的控件对齐问题。在流程不一致性检测方面，本文将规定的GUI跳转转换为移动屏幕上的逐步操作（如点击、长按、在某些控件上输入文本）。为此，本文提出了一种面向视觉-语言模型的视觉提示方法，以推断屏幕上针对特定控件的操作。通过这种方式，可以验证实现中预期跳转的存在与否。
  本文在80个移动应用程序和160个设计原型上进行了大量实验，结果表明：（1）GUIPilot在屏幕不一致性检测方面可达到99.8\%的精确率和98.6\%的召回率，分别比当前最先进的方法GVT高出66.2\%和56.6\%；（2）GUIPilot在流程不一致性检测方面实现了零错误率。此外，本文在某交易类移动应用上开展的工业案例研究表明，GUIPilot检测出了9个应用缺陷，且所有缺陷均得到了原应用专家的确认。本文代码已开源，地址为：https://github.com/code-philia/GUIPilot。
]

#abstract-en(keywords: ("dissertation", "dissertation format", "standardization", "template"))[
  GUI testing is crucial for ensuring the reliability of mobile applications. State-of-the-art GUI testing approaches are successful in exploring more application scenarios and discovering general bugs such as application crashes. However, industrial GUI testing also needs to investigate application-specific bugs such as deviations in screen layout, widget position, or GUI transition from the GUI design mock-ups created by the application designers. These mock-ups specify the expected screens, widgets, and their respective behaviors. Validating the consistency between the GUI design and the implementation is labor-intensive and time-consuming, yet, this validation step plays an important role in industrial GUI testing.
  In this work, we propose GUIPilot, an approach for detecting inconsistencies between the mobile design and their implementations. The mobile design usually consists of design mock-ups that specify (1) the expected screen appearances (e.g., widget layouts, colors, and shapes) and (2) the expected screen behaviors, regarding how one screen can transition into another (e.g., labeled widgets with textual description). Given a design mock-up and the implementation of its application, GUIPilot reports both their screen inconsistencies as well as process inconsistencies. On the one hand, GUIPilot detects the screen inconsistencies by abstracting every screen into a widget container where each widget is represented by its position, width, height, and type. By defining the partial order of widgets and the costs of replacing, inserting, and deleting widgets in a screen, we convert the screen-matching problem into an estimizable widget alignment problem. On the other hand, we translate the specified GUI transition into stepwise actions on the mobile screen (e.g., click, long-press, input text on some widgets). To this end, we propose a visual prompt for the vision-language model to infer widget-specific actions on the screen. By this means, we can validate the presence or absence of expected transitions in the implementation. Our extensive experiments on 80 mobile applications and 160 design mock-ups show that (1) GUIPilot can achieve $99.8\%$ precision and $98.6\%$ recall in detecting screen inconsistencies, outperforming the state-of-the-art approach, such as GVT, by $66.2\%$ and $56.6\%$ respectively, and (2) GUIPilot reports zero errors in detecting process inconsistencies. Furthermore, our industrial case study on applying GUIPilot on a trading mobile application shows that GUIPilot has detected nine application bugs, and all the bugs were confirmed by the original application experts. Our code is available at https://github.com/code-philia/GUIPilot.
]

#outline()

#image-outline() // 插图目录，按需设置

#table-outline() // 表格目录，按需设置

#algorithm-outline() // 算法目录，按需设置

#nomenclature(
  width: 50%,
  columns: (1fr, 1.5fr),
)[
  / $epsilon$: 介电常数
  / $mu$: 磁导率
  / $epsilon$: 介电常数
  / $mu$: 磁导率
  / $epsilon$: 介电常数
  / $mu$: 磁导率
]

#show: mainmatter
// #show: mainmatter.with(enable-avoid-orphan-headings: true) // 避免孤行标题，此为实验性功能，会对页面顶部距离造成影响
#show: word-count-cjk // 正文字数统计

= 绪论 <chp:intro>

== 研究背景

近年来，全球移动应用市场迅速增长，2023 年市场规模达到 2,289.8 亿美元，预计从 2024 年到 2030 年将以 14.3% 的年增长率持续扩张 @mobile-app-market。对于交易、银行和政府服务等关键移动应用而言，严格的图形用户界面（GUI）测试对于确保其可靠性至关重要 @gui-testing-market。

典型的工业级应用开发生命周期包含以下阶段 @gui-development-cycle：

+ *设计阶段（设计原型创建）：* 87% 的应用设计师使用原型工具来简化设计流程 @mockup-commonality。他们使用 Sketch @sketch-app、Axure @axure-app 和 Balsamiq @balsamiq-app 等流行工具生成高保真*原型（Mock-ups）*。这些原型不仅可视化了界面布局和设计（详细说明了控件、按钮、图标、排版的外观），还通过文本描述说明了屏幕之间如何跳转，作为*应用程序规范*。
+ *开发阶段：* 开发人员根据原型指定的规范实现 GUI 和控件的底层功能。
+ *测试阶段（设计原型验证）：* 最后，应用测试人员通过编写 GUI 测试用例和脚本，验证设计原型与实现之间的一致性。发现的不一致将被作为缺陷（Bug）报告并修复。

然而，针对设计原型测试移动应用并非易事。首先，一个屏幕可能包含数十个控件，人工比对（一个来自应用程序，另一个来自设计原型）相当容易出错。其次，虽然设计原型提供了文本描述，但屏幕跳转往往需要足够的领域知识才能完成所有触发动作。例如，某些按钮只有在输入密码并勾选协议后才可用，未能完成这些步骤将无法触发功能。第三，移动应用更新频繁，应用中的更新可能需要用户反复进行屏幕比对和跳转验证。

== 研究现状与挑战

现有的 GUI 测试解决方案通常旨在探索更多未见场景并发现通用缺陷，如应用程序崩溃 @7515457 @liu2024testing @huang2024crashtranslator @wang2022detecting @su2021fully @zhao2022recdroid @zhao2020seenomaly @liu2022nighthawk @su2017guided。虽然这些方法在检测通用缺陷方面行之有效，但在针对设计原型的应用测试方面工作较少。最相关的工作是 Moran 等人提出的 GVT 技术 @moran2018automated，该技术检测应用程序屏幕与模拟屏幕之间的不一致。然而，该工作仍面临以下挑战：

- *缺乏跳转自动化*：GVT 方法不考虑测试屏幕跳转，而这是设计原型规范中的关键部分。
- *屏幕匹配准确性*：从技术上讲，GVT 通过屏幕中的*相对*位置匹配控件，这可能会遗漏重要的布局语义。由于匹配的控件在屏幕上具有相似的相对位置，这导致了误报和漏报。

== 本文研究主要内容

本文提出了 GUIPilot，一种用于检测移动应用设计与其实现之间不一致性的方法，能够同时报告屏幕和流程（即跳转）的不一致。

为了检测屏幕不一致，GUIPilot 将每个屏幕抽象为一个控件容器，其中每个控件由其位置、宽度、高度和类型表示。然后，通过定义控件的偏序关系以及在屏幕中替换、插入和删除控件的代价，我们将屏幕匹配问题转化为可优化的控件对齐问题。通过这种方式，我们可以缓解 GVT 中的局部匹配问题，并基于全局布局语义比对两个屏幕。

为了检测流程不一致，我们利用最先进的视觉-语言模型（VLM），将设计原型中指定的 GUI 跳转转换为移动屏幕上的逐步操作（例如，点击、长按、在某些控件上输入文本）。为了减轻 VLM 潜在的幻觉问题，我们提出了针对 VLM 的*视觉提示（Visual Prompt）*技术，强制模型仅从具有有限操作选项的相关控件中推断动作。通过这种方式，我们可以根据设计原型导航到下一个屏幕，并验证实现中是否发生了预期的跳转或是否存在遗漏。

本文在 80 个移动应用程序上进行了评估，涵盖 4 种应用类型和 160 个设计原型。结果表明：（1）GUIPilot 在检测屏幕不一致性方面达到了 94.5% 的精确率和 99.6% 的召回率，分别优于 GVT 等最先进方法 66.2% 和 56.6%；（2）GUIPilot 在检测流程不一致性方面报告零错误；（3）GUIPilot 效率高，屏幕匹配算法平均耗时 0.001 秒，跳转平均耗时 0.19 秒。此外，我们与工业界合作者在一个拥有 3200 万用户的交易应用程序上进行了案例研究，GUIPilot 检测到了 9 个应用不一致缺陷，所有缺陷均得到了应用专家的确认。

== 本文主要贡献

本文的主要贡献总结如下：

- 我们提出了 GUIPilot，这是一种系统地检测设计原型与移动应用实现之间不一致性的解决方案。据我们所知，GUIPilot 是首个专为工业界广泛采用的设计原型量身定制的端到端 GUI 测试解决方案。
- 我们在技术上解决了针对屏幕一致性的全局布局语义屏幕匹配问题，以及针对流程一致性的从设计到动作（Design-to-Action）的问题。实验表明，我们在两个问题上都实现了高精度。
- 我们将 GUIPilot 作为 Web 应用程序发布，并开源了代码，以便研究社区和工业界进行进一步的研究和应用。
- 我们在多种类型的移动应用程序上进行了实验，展示了 GUIPilot 的有效性。此外，我们展示了 GUIPilot 能够在一个工业级交易应用程序上检测到实际的设计违规。

= 背景介绍
== gui测试



== 目标检测
我们采用基于视觉的目标检测流水线来识别设计原型和实现界面中的 UI 控件。下文详细描述该子系统的任务定义、数据与标注、模型选择与训练、推理与后处理、评价指标、常见失败模式及缓解措施，便于非计算机背景读者理解。

任务定义  
- 目标：在一张移动界面截图中定位并分类预定义的控件类别（例如 TextButton、IconButton、CombinedButton、InputBox、TextView、ImageView、Chart 等），输出形式为带类别标签的边界框（bounding box）。  
- 原因：将界面表示为若干结构化控件是后续控件对齐、语义比较与自动化操作的基础。

数据与标注  
- 数据来源：真实应用截图与设计原型图。为保证泛化能力，数据集应覆盖不同分辨率、主题（深色/浅色）、语言和布局风格。  
- 标注规范：为每个控件标注矩形边界框（x, y, w, h，常归一化到图像宽高），并指定控件类别和可选文本内容（用于基于文本的控件）。标注时应统一约定合并复合控件的边界策略（例如图标+文本的组合按钮应标为 CombinedButton）。  
- 划分与扩增：按训练/验证/测试（如 7:1.5:1.5）划分；采用数据增广（随机缩放、裁剪、色彩抖动、旋转小角度、模糊、压缩噪声）以模拟设备差异与渲染噪声。

模型选择与训练（概览）  
- 目标检测器类型：采用一阶段实时检测器（如 YOLO 系列）或两阶段检测器（如 Faster R-CNN）作为备选。我们在实现中使用 YOLO-v8 middle，因其在精度、延迟与工程易用性之间取得良好折衷。  
- 输入与输出：模型输入为 RGB 截图（可调整大小保持长宽比或中心裁剪）；输出为 N 个预测框，每个框带有类别概率和置信度分数。  
- 损失与超参：多任务损失包含边界框回归损失、类别交叉熵与置信度损失。关键超参数包括学习率、批次大小、训练轮次（epochs）、锚框/尺度设置等，通常通过在验证集上的 mAP 指标调优。  
- 训练技巧：使用迁移学习（在 COCO 或通用 UI 数据集上预训练再微调），类别重采样或加权损失解决类别不平衡；使用混合精度训练与学习率调度以加速收敛。

推理与后处理（工程细节）  
- 置信度过滤：将置信度低于阈值（例如 0.25） 的预测过滤，减少噪声。阈值可依据精度/召回的权衡调整。  
- 非极大值抑制（NMS）：对重叠预测框按置信度执行 NMS（IoU 阈值例如 0.45），合并重复检测。对于复合控件或重叠合法情况，可采用 Soft-NMS 或类别感知 NMS。  
- 多尺度推理：为提高小目标检测率，可对图像做多尺度滑窗或金字塔推理并合并结果，但会增加延迟。  
- OCR 集成：对包含文本的控件（TextButton、CombinedButton、TextView、InputBox）调用 OCR（例如 Tesseract、CRAFT+CRNN 等）提取文字内容，文字与 bounding box 通过 IoU/中心点匹配绑定，用于后续语义比较与操作匹配。

评价指标（便于非专业读者理解）  
- IoU（Intersection over Union）：预测框与真实框重叠比例，IoU ≥ 0.5 常视为匹配成功。  
- mAP\@IoU=0.5（平均精度）：对所有类别在不同召回阈值下的平均精度，反映检测器在精度/召回平衡上的整体表现。  
- mAR（平均召回）：在指定检测数量或 IoU 阈值下的平均召回率，反映漏检率。  
- 延迟（每图推理时间）与模型参数量：工程上需要在检测精度与实时性之间权衡。

常见失败模式与缓解策略  
- 小目标与稀有控件漏检：通过数据增广放大小目标样本、使用更高分辨率输入或多尺度推理缓解；训练时对小对象加权。  
- 类型混淆（如 InputBox 与 TextButton）：改进标注精细度（明确视觉与交互语义）、使用上下文特征（周围图标/标签）和文本信息（OCR）辅助判别；训练时增加混淆样本。  
- 布局/主题域差异（训练集与目标应用视觉差异大）：采用域适配或在目标域少量标注上微调；增加风格/主题多样性的数据增广。  
- 重叠/遮挡导致错误框：使用更鲁棒的 NMS（Soft-NMS）或后处理的布局规则（例如互斥或层级关系约束）。  
- OCR 错误影响后续语义判断：对 OCR 结果做置信度校验与后处理（语言模型拼写修正、正则匹配）。

工程实践与部署考虑  
- 资源与延迟：在研发阶段可用更大模型以追求更高 mAP；部署时选择 lighter model（YOLOv8 small/middle）或知识蒸馏以满足实时性需求。  
- 可解释性：保存检测置信度、类别概率和中间特征图，便于故障排查与人工复核。  
- 持续学习：在 CI 流水线中定期收集未识别或错误分类的截图进行增量标注与模型再训练，减小模型随时间退化的风险。

小结（以便整合到论文）  
控件检测是将视觉界面转换为结构化表示的关键步骤。一个成熟的目标检测流水线需考虑数据标注规范、模型选择与训练技巧、稳健的推理后处理、OCR

= 问题陈述 <sec:ps>

在本节中，我们给出形式化定义和问题陈述。
#let bf(x) = math.bold(math.upright(x))

#imagex(
  image(
    "figures/introduction_example.pdf",
    width: 80%,
  ),
  caption: [内热源沿径向的分布],
  caption-en: [A design mock-up on the login process of a trading mobile application, consisting of five screens and four transitions.],
  label-name: "mockup-example",
)


*屏幕（Screen）。* 我们将屏幕 $bf(s)$ 定义为单个GUI界面，其中包含多个控件，包括图像、按钮、文本等。每个控件 $bf(w)$ 以 $chevron.l x, y, w, h, t chevron.r$ 的格式表示。具体而言，$x, y$ 是控件在屏幕上的左上角坐标，以截图的左上角为原点。$w, h$ 是控件相对于完整截图尺寸的宽度和高度。$t$ 是控件的类型。我们定义了7种主要的控件类型，详见(tudo img:widget-class)。一个屏幕包含一组控件，即 $bf(W) = {bf(w)_i | bf(w)_i = chevron.l x, y, w, h, t chevron.r}$。

如(tudo img:widget-class) 所示，我们将控件分为可交互控件和不可交互控件两类。可交互控件包括文本按钮、图标按钮、组合按钮和输入框。文本按钮通过文本传达其功能，而图标按钮则使用图标。组合按钮同时整合了文本和图标，以提供更全面的表示。输入框允许用户输入文本。不可交互控件包括文本视图、图像视图和图表。

*操作（Action）。* 在单个屏幕 $bf(s)$ 上，可以执行一系列操作，每个操作与不同的控件进行交互。我们定义的操作空间包含7种操作：点击、长按、输入文本、滚动、滑动、拖放和返回。操作链 $bf(A)$ 被定义为一系列操作的序列 $bf(A) = (bf(a)_1(bf(w)_1), bf(a)_2(bf(w)_2), ..., bf(a)_i(bf(w)_i))$。以@img:mockup-example 为例，从屏幕4到屏幕5的操作链为 $bf(A)$ = (点击(密码输入框), 输入文本(我们的密码), 点击(协议复选框), 点击(安装按钮))。

*流程（Process）。* 流程 $bf(p)$ 是一个有向连通图 $bf(p): G = ( bf(S), bf(E) )$，其中 $bf(S)$ 是一组屏幕，$bf(E)$ 是一组操作链。每个操作链 $bf(A) in bf(E)$ 可以导致从一个屏幕转换到另一个屏幕，或者停留在同一屏幕上，从而指定图中的边。例如，@img:mockup-example 由5个顶点（5个屏幕）组成，它们通过4条边（4个操作链或转换）连接。

*屏幕不一致性（Screen Inconsistency）。* 我们将三种类型的不一致性视为屏幕不一致性，即：多余控件、缺失控件和语义变化。形式化地，我们将设计稿中特定屏幕的控件集合表示为 $bf(W)^"tar"$，将实现中对应屏幕的控件集合表示为 $bf(W)$。假设存在一个真实匹配函数 $f(.)$，该函数接受两组控件并返回匹配对的集合，即 $f(bf(W)^"tar", bf(W)) = {(bf(w)^"tar"_i, bf(w)_j) | bf(w)^"tar"_i in bf(W)^"tar", bf(w)_j in bf(W) "且二者匹配"}$。当满足以下任一条件时，报告不一致性：

_(i) 实现中缺失控件。_

$ exists bf(w)^"tar"_i in bf(W)^"tar" "使得" bf(w)^"tar"_i product f(bf(W)^"tar", bf(W)) $ <eq:miss-widget>

_(ii) 实现中存在多余控件。_

$ exists bf(w)_j in bf(W) "使得" bf(w)_j product f(bf(W)^"tar", bf(W)) $ <eq:extra-widget>

_(iii) 匹配控件的语义变化。_

两个控件成功配对但表现出不同的语义。例如，它们的文本、颜色或控件类型可能已被更改。设 $epsilon.alt_s$ 为可接受语义变化的阈值，设 $g(.)$ 表示将控件映射到d维表示向量的语义提取函数。两个配对控件之间的语义差异可以量化为它们语义向量之间的距离：

$
  exists & (bf(w)^"tar"_i, bf(w)_j) in f(bf(W)^"tar", bf(W)) "使得" \
         & t_i != t_j "或" norm(g(bf(w)^"tar"_i) - g(bf(w)_j))_2 > epsilon.alt_s
$ <eq:semantic-change>

*流程不一致性（Process Inconsistency）。* 流程不一致性检测从理论上来说是一个考虑拓扑同构的图比较问题。设设计稿上的预期流程表示为 $bf(p)^"tar": G = ( bf(S)^"tar", bf(E)^"tar" )$。$bf(E)^"tar"$ 可能包含模糊的指令，需要自动补全缺失的指令。这将产生修正后的操作链 $bf(E)^"tar"_("complete")$。在实现上执行 $bf(E)^"tar"_("complete")$ 会在应用程序上生成一个流程图 $bf(p): G = (bf(S), bf(E)^"tar"_("complete"))$。通过比较设计稿图 $bf(p)^"tar"$ 和实现图 $bf(p)$ 之间的所有边，我们识别并输出不一致的边：

$
  exists & t, (bf(s)_t^"tar", bf(E)_t^"tar", bf(s)_(t+1)^"tar") in bf(p)^"tar", (bf(s)_t, bf(A)_t, bf(s)_(t+1)) in bf(p) \
         & "使得" "sim"(bf(s)_(t+1), bf(s)_(t+1)^"tar") < epsilon.alt_("screen")
$ <eq:process-change>

= 方法实现
== 总体概述

#imagex(
  image(
    "figures/overview.pdf",
    width: 100%,
  ),
  caption: [GUIPilot 的整体工作流程],
  caption-en: [The overall workflow of GUIPilot],
  label-name: "overview",
)

@img:overview GUIPilot 的整体工作流程。
输入包括运行在移动设备上的已实现应用，以及一组设计原型文档。
每个原型描述了一个具体的使用场景，例如 ``购买交易型开放式指数基金（ETF）``。

首先，我们对这些原始设计原型进行一致性检查与解析，
以确保每个流程都被重构为符合标准元模型格式的表示（@app:meta-model 节）。
随后，基于每个流程中定义的操作链，
我们尝试在应用实现上执行这些操作（@app:process）。
在该过程中，我们利用视觉-语言模型（VLM）自动补全隐含的操作，
以确保操作链能够成功执行。
在获得设计原型中的流程以及应用实现中实际执行的流程后，
我们即可进行流程不一致性检测（@app:process）。
此外，我们还会对所有单个界面进行不一致性比较（@app:screen）。
最终输出为一份报告，列出了应用实现中所有违反设计原型的地方。


== 原型元模型与一致性检查<app:meta-model>
#imagex(
  image(
    "figures/metamodel.pdf",
    width: 80%,
  ),
  caption: [设计原型的元模型],
  caption-en: [The meta-model of design mock-ups],
  label-name: "meta-model",
)

如 @img:meta-model 所示，我们的元模型由四个关键要素组成：流程（process）、界面（screen）、组件（widget）和操作（action）。
每个流程都具有一个唯一的起始界面以及至少一个结束界面。
一个流程可以表示为一个由多个界面及其间连接动作构成的有向连通图。
该图也可以是循环的，即起始界面与结束界面相同，
例如用户从某一界面跳转到其他界面后又返回初始界面的场景。
操作在每个界面的组件元素之上执行。
在本工作中，我们考虑如下操作空间：
点击（click）、长按（long press）、输入文本（send keys）、滚动（scroll）、滑动（swipe）、拖拽（drag and drop）以及返回（go back）。
当一个操作被执行时，可能产生以下几种结果：
（i）不发生界面跳转，
（ii）跳转到同一流程中的另一个界面，或
（iii）跳转到另一个流程。
需要注意的是，如果某个设计原型不符合我们的元模型规范，
GUIPilot 将作为工具抛出编译错误，以提示设计人员对其原型进行修正和完善。

== 界面不一致性检测 <app:screen>
在本工作中，我们首先训练一个计算机视觉模型，用于在设计原型界面和应用实现界面中识别预定义的组件类型。
对于检测到的组件，我们将其建模为一个可优化的组件对齐问题，并采用动态规划方法进行求解。

=== 组件检测 <app:widget-detection>

受已有研究工作的启发 @chen2020object, @xie2020uied, @lin2021phishpedia, @bernal2022translating，
我们采用基于视觉的方法来识别设计原型截图和实现截图中的组件。
通过训练一个先进的目标检测模型 @yolov8，
我们可以准确地识别组件及其在 @sec:ps 节中定义的类型。
该方法统一了原型与实现两侧的组件提取流程，
使其能够更好地泛化到不同类型的应用场景。
对于包含文本的组件类型（即 TextButton、CombinedButton 和 TextView），
我们进一步使用光学字符识别（OCR）模型提取其文本内容，以便后续进行一致性检查。
最终，每一个界面都会被转换为一个组件集合，
其中每个组件均包含其位置、形状和类型信息，如 @sec:ps 节所述。

=== 组件对齐 <app:widget-matching>
我们将组件匹配问题建模为一个动态规划问题，其算法流程如@algo:widget-matching 所示。
算法的输入为来自设计原型和应用实现的两个组件集合，
输出为这两个集合之间的匹配组件对集合。
该算法主要包含以下三个关键步骤：


- *步骤 1：组件的 _偏序关系_（@algo:widget-matching 的第 2--3 行）。*
  我们为界面上的组件定义了一种 _偏序关系_。
  具体而言，组件首先按照其 $y$ 坐标进行升序排序（自上而下），
  对于位于同一行的组件，则再按照其 $x$ 坐标进行升序排序（自左而右）。
  该偏序关系来源于我们的经验观察，即大多数组件在界面中以水平方向布局#footnote[GUIPilot 默认采用该偏序关系，但实践者也可以根据需求自定义偏序规则。]。

- *步骤 2：组件相似度计算（@algo:widget-matching 的第 4--7 行）。*
  我们计算两个组件集合之间的两两相似度。
  相似度度量由四个部分组成：
  （i）位置相似度，使用组件 $(x, y, w, h)$ 坐标之间的 L1 范数距离计算，该方法最早由 @moran2018automated 提出；
  （ii）面积相似度，用于衡量组件尺寸（$w times h$）的差异；
  （iii）形状相似度，用于评估宽高比（$w / h$）的差异；
  （iv）类型相似度，当两个组件属于同一类别时赋值为 1。
  若组件类型不同（例如输入框与文本按钮），则该分数会乘以一个衰减因子 $delta$。
  最终，相似度得分由上述四项指标相乘得到。

- *步骤 3：基于 LCS 的匹配（@algo:widget-matching 的第 8--20 行）。*
  观察到界面上的组件可以被视为一个序列，
  我们将组件匹配问题转化为一个最长公共子序列（LCS）问题 @lcs。
  我们的目标是从两个组件集合中找到 _全局最优_ 的子序列，
  使得其匹配后的累计相似度最大。
  该过程通过动态规划方法 @dp 实现，
  最终得到两个匹配后的组件集合 $bf(W)_1^m$ 和 $bf(W)_2^m$。
  通过将组件匹配表述为一个优化问题，
  即使在存在多余或缺失组件的情况下，我们也能够识别出最佳的对应关系。
#algox(
  label-name: "widget-matching",
  caption: [组件对齐算法],
  pseudocode-list(line-gap: 1em, indentation: 2em)[
    - #h(-1.5em) *input:* 设计稿组件集 $bf(W)_1 = {bf(w)_i | bf(w)_i = (x_i, y_i, w_i, h_i, t_i)}$，实现组件集 $bf(W)_2 = {bf(w)_j | bf(w)_j = (x_j, y_j, w_j, h_j, t_j)}$
    - #h(-1.5em) *output:* 匹配对 $bf(W)_1^m, bf(W)_2^m$
    + $bf(W)_1^m <- emptyset, bf(W)_2^m <- emptyset$
    + /* 步骤 1: 按偏序关系排序组件 */
    + 对 $bf(W)_1$ 排序，使得 $(y_i, x_i) <= (y_(i'), x_(i')), forall i < i'$
    + 对 $bf(W)_2$ 排序，使得 $(y_j, x_j) <= (y_(j'), x_(j')), forall j < j'$
    + /* 步骤 2: 计算相似度矩阵 */
    + 初始化相似度矩阵 $A <- bf(0)_(|bf(W)_1| times |bf(W)_2|)$
    + *for* $bf(w)_i in bf(W)_1, bf(w)_j in bf(W)_2$ *do*
      + $s i m_("pos") = min(1 / (alpha(|x_i - x_j| + |y_i - y_j|) + |w_i - w_j| + |h_i - h_j|), 1)$
      + $s i m_("area") = min(w_i h_i, w_j h_j) / max(w_i h_i, w_j h_j)$
      + $s i m_("shape") = min(w_i \/ h_i, w_j \/ h_j) / max(w_i \/ h_i, w_j \/ h_j)$
      + $s i m_("type") = bf(1)(t_i = t_j) + delta bf(1)(t_i != t_j)$
      + $A_(i,j) <- s i m_("pos") dot s i m_("area") dot s i m_("shape") dot s i m_("type")$
    + *end*
    + /* 步骤 3: 基于 LCS 的匹配 */
    + 初始化匹配矩阵 $M <- bf(0)_(|bf(W)_1|+1 times |bf(W)_2|+1)$
    + *for* $i = 1,dots,|bf(W)_1|, j = 1,dots,|bf(W)_2|$ *do*
      + $M_(i,j) <- max{M_(i,j-1), M_(i-1,j), M_(i-1,j-1) + A_(i-1,j-1)}$
    + *end*
    + /* 回溯匹配对 */
    + $i <- |bf(W)_1|, j <- |bf(W)_2|$
    + *while* $i > 0$ *and* $j > 0$ *do*
      + *if* $M_(i,j) = M_(i-1,j-1) + A_(i-1,j-1)$ *then*
        + $bf(W)_1^m <- bf(W)_1^m union {bf(w)_(i-1)}$
        + $bf(W)_2^m <- bf(W)_2^m union {bf(w)_(j-1)}$
        + $i <- i - 1, j <- j - 1$
      + *else* *if* $M_(i,j) = M_(i-1,j)$ *then*
        + $i <- i - 1$
      + *else*
        + $j <- j - 1$
      + *end*
    + *end*
    + *return* $bf(W)_1^m, bf(W)_2^m$
  ],
) <alg:widget-matching>

=== 不一致性报告生成 <app:screen-inconsistency-report>
基于组件匹配结果，我们可以识别出界面实现中的不一致性问题，如 @sec:ps 所定义。
我们考虑三类违规情况：多余组件、缺失组件以及语义变化。
前两类，即多余组件和缺失组件，
// 通过将匹配后的组件集合 $widgetset_1^{m}$ 和 $widgetset_2^{m}$
// 与初始组件集合 $\widgetset_1$ 和 $\widgetset_2$ 进行比较来识别。
最后一类，即语义变化，则在已匹配的组件对上进行判断。
若匹配的组件对属于不同的组件类型，则视为发生了语义变化。
对于组件类型相同的匹配对，
我们遵循 GVT @moran2018automated 的实践来判断组件是否发生变化：

+ 对于基于文本的组件（TextView、TextButton、InputBox 和 CombinedButton），其文本值序列的相似度比值需要高于阈值 $epsilon_(e d)$。
+ 对于基于图标的组件（IconButton、ImageView、InputBox 和 CombinedButton），二值颜色空间差异需低于阈值 $epsilon_(b i n a r y)$，同时出现频率最高的前 $k$ 种颜色的 RGB 差异也需小于阈值 $epsilon_(c o l o r)$。


最后，我们对组件类型 ``Chart`` 放宽比较条件，
即只要两个图表组件在界面中完成对齐，便认为其未发生变化。
这是因为设计原型中的图表往往仅作为示例，
其具体内容在实际实现中是可以动态变化的。



== 流程不一致性检测<app:process>

#imagex(
  image(
    "figures/process/buy/buy_copy.pdf",
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
    "figures/process_inconsistency.pdf",
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

  image("figures/gui_screen_annotated.pdf", width: 100%),
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



= 实验评估
我们围绕以下研究问题对 GUIPilot 进行评估：

+ RQ1（屏幕一致性实验）：GUIPilot 在公开移动应用数据集中检测 $"屏幕不一致"$ 的效果如何？
+ RQ2（流程一致性实验）：GUIPilot 在公开移动应用数据集中检测 $"流程不一致"$ 的效果如何？
+ RQ3（组件级评估）：GUIPilot 的关键组件有多准确？

  + RQ3-1：$"控件检测"$模型的性能如何？
  + RQ3-2：VLM 能否将转移描述成功转换为可执行操作？

我们从 Google Play 中收集了 80 个热门免费应用，覆盖商业、通信、金融和社交等类别。
我们招募了四位具有至少两年软件开发经验的专家。对于每个应用，专家需手动标注两个应用场景作为设计稿流程示例（例如“关注某社交账号”和“设置通知偏好”）。
专家记录与这些流程相关的所有屏幕及中间动作链，作为我们的模拟设计稿。
每个应用衍生出两套设计稿，每套设计稿平均包含八个屏幕。更多收集的流程示例见 @dataset-examples。

算法 @algo:widget-matching 中的超参数 $alpha$ 和 $delta$ 通过网格搜索确定。
我们使用屏幕一致性实验（见@exp:rq1）的性能作为选择指标。
最终选择 $alpha=10$。该缩放因子使得 $bf("sim")_("pos")$ 的取值在 (0,1\] 上更均匀分布；若不做缩放，$bf("sim")_("pos")$ 在小距离时会集中接近 1，降低判别能力。
同时将 $delta$ 设为 0.5，表示当两个控件属于不同类别时，它们的最终相似度减半。


具体而言，当字符串相似度低于 $epsilon("ed")=0.95$ 时视为文本违规。
在计算颜色差异时，我们从每个控件中提取出现频率最高的前三种颜色并计算它们的 RGB 差异。当颜色差异超过 $epsilon("color")=0.05$ 时，视为颜色违规。此外，二值化颜色空间下差异像素的比例不超过 $epsilon("binary")=20\%$。


% 关于流程不一致问题，我们使用流程一致性实验（见@exp:rq2）中引入的 100 个变异设计稿来选择最优的屏幕匹配阈值（见@app:process-inconsistency-report 中的 $epsilon("screen")$）。
最终选择阈值为 0.73，以取得最高的 F1 分数。

== 屏幕一致性检测实验 <exp:rq1>

=== 实验设置

我们对模拟的设计原型屏幕进行变异，以注入屏幕不一致性。具体而言，我们选择了以下 GUI 变异类型，这些类型在实际应用中很常见，覆盖了 92% 的变异案例 @moran2018automated。我们假设大部分控件是正确实现的，因此在每个变异案例中，我们随机选择屏幕上 5% 的控件进行修改，平均每屏修改 1-2 个控件。该设置与 @moran2018automated 保持一致。

- *缺失控件（Missing widgets）：* 对于每个屏幕，我们随机选择 5% 的控件进行删除。为了模拟真实的渲染效果，我们删除包含所选控件的整行，并将剩余控件向上移动。
- *多余控件（Extra widgets）：* 对于每个屏幕，我们随机插入大约 5% 的额外控件。我们为这些控件添加完整的行，并将现有控件相应向下移动。
- *语义变化——控件交换（Swapped widgets）：* 对于每个屏幕，我们随机选择 5% 的控件，并将其与其他类型的控件交换，以引入语义变化。
- *语义变化——文本变更（Text change）：* 对于每个屏幕，我们随机选择 5% 的基于文本的控件并更改其文本内容，以产生语义不一致。
- *语义变化——颜色变更（Color change）：* 对于每个屏幕，我们随机选择 5% 的基于图像的控件并更改其颜色，以引入语义差异。

=== 基准方法
我们选择 GVT @moran2018automated 作为我们的基准，因为它是当前最先进的移动应用屏幕比对解决方案。我们在本实验中遵循 @moran2018automated 的配置。
此外，为了验证我们模型设计的必要性，我们还引入了一个简单的基准，即直接查询视觉-语言模型（VLM）进行不一致性检查。具体来说，我们将带有控件 ID 标注的两个屏幕输入 VLM，并提示其判断是否存在缺失、插入或语义编辑的控件。

=== 评估指标
遵循 @moran2018automated 中使用的指标，我们在本实验中使用精确率（Precision）、召回率（Recall）、Jaccard 指数（Jaccard Index）和分类精确率（Classification Precision）作为评估指标。
设 $T P$、$F P$、$F N$ 和 $T P_c$ 分别表示真阳性不一致、假阳性不一致、假阴性不一致和类型正确的真阳性。我们计算精确率、召回率、Jaccard 指数和分类精确率如下：

$
  "pre" = (T P) / (T P + F P), quad "rec" = (T P) / (T P + F N) \
  J_"Index" = (T P) / (T P + F N + F P), quad c p = (T P_c) / (T P)
$ <eq:metrics>

具体而言，精确率 $"pre"$ 是报告的真实不一致数除以报告的不一致总数；召回率 $"rec"$ 是报告的真实不一致数除以不一致总数；Jaccard 指数 $J_"Index"$ 对假阴性（未报告的真实不一致）和假阳性（错误警报）均进行惩罚；分类精确率 $c p$ 是被正确识别为正确类型的真实报告不一致数除以真实报告不一致总数。

=== 实验结果

#figure(
  table(
    columns: (1.2fr, 1fr, 1fr, 1fr, 1.2fr, 1fr, 1fr),
    align: (left, left, center, center, center, center, center),
    stroke: none,
    table.header([*变异类型*], [*方法*], [*精确率*], [*召回率*], [*分类精确率*], [*Jaccard*], [*耗时 (s)*]),
    table.hline(),
    [*多余控件*], [GVT], [0.793], [0.899], [1.000], [0.690], [0.001],
    [], [VLM], [0.088], [0.137], [1.000], [0.056], [1.230],
    [], [GUIPilot], [*0.998*], [*0.986*], [1.000], [*0.982*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*缺失控件*], [GVT], [0.912], [0.938], [1.000], [0.840], [0.001],
    [], [VLM], [0.123], [0.154], [1.000], [0.073], [1.430],
    [], [GUIPilot], [*0.997*], [*0.984*], [1.000], [*0.978*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*交换控件*], [GVT], [0.283], [0.430], [1.000], [0.200], [0.001],
    [], [VLM], [0.045], [0.078], [0.910], [0.026], [1.530],
    [], [GUIPilot], [*0.987*], [*0.992*], [1.000], [*0.971*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*文本变更*], [GVT], [0.998], [0.999], [0.981], [0.960], [0.001],
    [], [VLM], [0.119], [0.248], [0.992], [0.086], [1.870],
    [], [GUIPilot], [0.996], [0.999], [0.981], [0.960], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*颜色变更*], [GVT], [1.000], [0.999], [1.000], [0.990], [0.001],
    [], [VLM], [0.075], [0.177], [0.964], [0.052], [3.110],
    [], [GUIPilot], [1.000], [0.999], [1.000], [0.990], [0.001],
    table.hline(),
  ),
  caption: [屏幕一致性实验结果对比],
) <tab:screen-inconsistency-results>

#figure(
  grid(
    columns: 4,
    gutter: 0.5em,
    image("figures/gvt_fails_guipilot_success/1_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/1_guipilot.pdf"),
    image("figures/gvt_fails_guipilot_success/2_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/2_guipilot.pdf"),

    align(center)[GVT (示例 1)],
    align(center)[GUIPilot (示例 1)],
    align(center)[GVT (示例 2)],
    align(center)[GUIPilot (示例 2)],

    image("figures/gvt_fails_guipilot_success/5_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/5_guipilot.pdf"),
    image("figures/gvt_fails_guipilot_success/6_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/6_guipilot.pdf"),

    align(center)[GVT (示例 3)],
    align(center)[GUIPilot (示例 3)],
    align(center)[GVT (示例 4)],
    align(center)[GUIPilot (示例 4)],

    image("figures/gvt_fails_guipilot_success/9_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/9_guipilot.pdf"),
    image("figures/gvt_fails_guipilot_success/11_gvt.pdf"),
    image("figures/gvt_fails_guipilot_success/11_guipilot.pdf"),

    align(center)[GVT (示例 5)],
    align(center)[GUIPilot (示例 5)],
    align(center)[GVT (示例 6)],
    align(center)[GUIPilot (示例 6)],
  ),
  caption: [GVT 和 GUIPilot 之间的比较。在每张图中，原始屏幕显示在左侧，变异屏幕（插入、删除或交换后）显示在右侧。红色框表示多余或缺失的控件。绿色框表示不受变异影响的控件。黄色框表示由于变异而移动但仍能识别匹配的控件。],
) <fig:gui-win>

@tab:screen-inconsistency-results 展示了 GUIPilot 与 GVT @moran2018automated 的对比分析结果。总体而言，GUIPilot 在检测布局违规（如多余控件和控件交换）方面表现出更好的性能。对于颜色和文本更改等原地语义变化，GUIPilot 的性能与 GVT 相当。值得注意的是，GUIPilot 在不增加额外运行时开销的情况下实现了这些结果。

此外，直接查询 VLM 的分类性能较差，且运行时间较长。我们观察到 VLM 可能会产生幻觉，报告不存在的不一致（假阳性），或者虽然识别出不一致但分配了错误的控件 ID（假阳性和假阴性）。

==== 为什么 GUIPilot 优于 GVT？
首先，GVT 更容易受到位置偏移的影响。GVT 主要依赖屏幕上控件的相对位置进行匹配，这使其对 GUI 布局的微小移动非常敏感。相比之下，GUIPilot 不仅考虑控件的位置，还考虑了其形状和类型，使其即使在发生微小偏移时也能正确匹配相应的控件对。如 @fig:gui-win 所示，示例 1-4 表明，当插入或删除控件时，如果后续控件的位置略有偏移，GVT 会出现匹配错误。然而，GUIPilot 在正确识别相应匹配方面被证明更具鲁棒性。

其次，GVT 严格的匹配阈值可能会忽略正确的配对。在控件交换的情况下（@fig:gui-win 示例 5-6），GVT 严格的匹配阈值使其无法识别交换的配对，因为它们之间的得分不满足阈值要求。相反，GVT 会将这些报告为个别的缺失控件或多余控件。相比之下，GUIPilot 能够正确地将控件与其交换对进行匹配，从而提供更准确的报告。

==== GUIPilot 何时会出现假阳性？
我们观察到，当发生显著的布局变化时，GUIPilot 可能会出现假阳性。虽然 GUIPilot 比 GVT 对布局扰动更具鲁棒性，但在发生实质性变化且插入或相邻的控件恰好具有相似的类型和形状时，仍可能产生误匹配。如 @fig:gui-fail （FP 示例 1-2）所示，插入或删除的控件可能错误地与相邻控件配对，导致随后的控件变为未配对。这些未配对的控件随后被错误地报告为缺失或多余元素。
潜在的补救措施是开发一种更鲁棒的相似性度量，以更好地捕捉语义和上下文相似性。
此外，我们观察到重叠的控件也会导致假阳性。控件交换有时会导致控件重叠（FP 示例 3）。这可能导致一个控件错误地与另一对中的控件匹配，或干扰外观，例如改变底层控件的颜色。

#figure(
  grid(
    columns: 3,
    gutter: 0.5em,
    image("figures/guipilot_fp/2.pdf"), image("figures/guipilot_fp/5.pdf"), image("figures/guipilot_fp/9.pdf"),
    align(center)[FP 示例 1], align(center)[FP 示例 2], align(center)[FP 示例 3],

    image("figures/guipilot_fn/3.pdf"), [], [],
    align(center)[FN 示例 1], [], [],
  ),
  caption: [GUIPilot 的假阳性 (FP) 和假阴性 (FN) 示例。],
) <fig:gui-fail>

==== GUIPilot 何时会出现假阴性？
与假阳性的原因类似，显著的变化也会导致假阴性。当控件未对齐时，实际缺失或多余的元素可能错误地与不相关的控件配对，导致它们未被报告。此外，我们还观察到控件检测器的故障也会导致假阴性。如 @fig:gui-fail （FN 示例 1）所示，插入的控件未被目标检测器检测到，导致报告遗漏。

== 流程一致性实验 <exp:rq2>

=== 实验设置
我们在 80 个应用中收集了 160 个设计稿。然而，鉴于部分流程频繁更新或阻塞自动化交互，为保证实验可复现性，我们保留了其中 100 个设计稿用于实验。

先前研究 @xiong2023empirical @hu2024auitestagent @liu2024vision 指出应用中错误屏幕跳转的若干常见根因，包括：
(i) 资源 ID 引用错误，导致事件绑定到错误按钮；(ii) 数据同步缺失，例如用户登录状态等全局属性未更新；(iii) 父容器或邻近控件误拦截事件，使得触摸事件未作用到目标控件而触发了父控件或邻近控件。

基于这些观察，我们对每个被选的 100 个设计稿随机选取一个由 $chevron.l bf(s)_(s r c), "desc", bf(s)_(t a r) chevron.r$ 表示的屏幕跳转，并通过在该跳转上随机变异动作来模拟错误的目标屏幕，从而引入流程不一致。具体的变异操作包括：

+ *目标变异（变异 $bf(s)_(t a r)$）：* 应用流程在应跳转到正确下一个屏幕时却返回到上一个屏幕。该情形模拟由于数据不同步导致动作无效，从而返回上一步的情况。例如，在空日历页面添加新事件后，本应展示更新后的日历，但应用却返回到空日历页面。
+ *源变异（变异 $bf(s)_(s r c)$）：* 将动作错误地绑定到另一个控件。此类情况模拟资源 ID 被错误分配（可能因功能相似或标注错误），例如本应触发“注册”的按钮却触发了“登录”。

随后我们按照 @img:process-inconsistency 中的工作流在真实应用上验证这 100 个变异流程。

我们评估执行是否在变异的屏幕跳转处因报告不一致而被中止，并使用精确率与召回率衡量结果，主要考察屏幕匹配是否正确识别了真实的屏幕错位。为确保稳定且可复现的测试环境，我们在 Linux 系统上使用 Waydroid @waydroid 部署了虚拟 Android 设备，并将所有应用安装为实验期间的最新版本。应用交互使用 UiAutomator2 驱动 @uiautomator2 和 Android Debug Bridge (ADB) 自动化完成。

=== 实验结果
我们的方法在此实验中取得了 100\% 的精确率和召回率，表明所有引入的流程不一致均被成功检测到。每次屏幕跳转的中位运行时间为 0.193 秒，运行时间增加主要由应用内交互固有的延迟所致。

== 控件检测性能 <exp:rq3-1>

=== 实验设置
在本实验中，我们评估训练好的控件检测器的性能（见@app:widget-detection）。
我们将从公开应用中收集到的 1392 张屏幕按 7:3 的比例划分为训练集和测试集。训练集用于训练控件检测模型（本工作采用 YOLO-v8 middle @yolov8），测试集用于评估模型在未见屏幕上的泛化性能。
在目标检测任务中，我们使用平均精度均值（mAP）和平均召回均值（mAR）@map 作为标准度量，这些指标在 IoU 阈值 0.5 下计算。当检测到的边界框与真实框的重叠超过该阈值时视为匹配成功。

=== 实验结果

#figure(
  table(
    columns: (1.5fr, 1.2fr, 1fr, 1fr),
    align: (left, left, center, center),
    stroke: none,
    table.header([*大类*], [*类型*], [*mAP\@IoU=0.5*], [*mAR\@IoU=0.5*]),
    table.hline(),
    [*可交互*], [TextButton], [0.585], [0.715],
    [], [IconButton], [0.711], [0.804],
    [], [CombinedButton], [0.721], [0.817],
    [], [InputBox], [0.446], [0.511],
    table.hline(stroke: 0.5pt + gray),
    [*不可交互*], [TextView], [0.677], [0.758],
    [], [ImageView], [0.662], [0.778],
    [], [Chart], [0.317], [0.318],
    table.hline(stroke: 0.5pt + gray),
    [*总体*], [], [0.515], [0.588],
    table.hline(),
  ),
  caption: [控件检测准确率],
) <tab:widget-detection-accuracy>

@tab:widget-detection-accuracy 给出了按类别划分的控件检测性能，总体上模型取得了令人满意的检测率（作为参照，COCO 基准的最新方法 mAP 约为 0.502 @ultralytics-yolov8）。
然而，输入框和图表的准确率相较其他 UI 元素偏低。输入框准确率下降主要源于其在视觉上容易与文本按钮或复合按钮混淆，从而干扰目标检测模型的分类。
为缓解该问题，可在后处理阶段加入基于前端代码判断控件是否支持文本输入动作的检查。对于图表，检测失败通常源于其与周围内容缺乏清晰边界，导致检测器难以识别。更多失败示例见 @exp:rq3-2。

#figure(
  image("figures/mAP_Latency.pdf", width: 50%),
  caption: [目标检测架构比较。纵轴为平均精度均值（mAP），横轴为每张图像的延迟，气泡大小表示参数量。],
) <fig:object-detection-architect>

== VLM 操作完成性能 <exp:rq3-2>

=== 实验设置
在本评估中，我们使用与 RQ2 @exp:rq2 共享的 100 个屏幕跳转来评估 VLM 代理的性能，以判断其是否能准确识别相关控件并将动作转换为可执行格式。对于每个屏幕跳转，输入给 VLM 的内容包括描述动作的自然语言命令（例如“点击第一个建议”、“展开菜单”）以及一张对可交互控件进行编号并高亮的 GUI 截图。

VLM 代理的期望行为为： (1) 准确定位与描述动作相对应的屏幕控件，(2) 将自然语言动作有效地翻译为可执行命令。

我们通过跳转成功率来衡量 VLM 的有效性，即代理正确执行指定动作并获得预期屏幕变化的比例。本实验中我们使用 GPT-4o——在提交时最先进且在处理此类任务上高效且具成本效益的视觉-语言模型。

=== 实验结果
在测试的 100 个跳转中，90 个在一次尝试内达到正确结果，99 个在两次尝试内达到正确结果。这提示加入自我反思循环可能进一步提高修正准确率。唯一的失败案例是由于目标控件未被目标检测器检测到，因而在传入 VLM 时未被标注为可交互控件，导致 VLM 无法识别并执行该动作。

我们还按源屏幕上的控件数量对这 100 个跳转进行分组（1-10、10-20、20-30、30-40、40+），相关结果见 @fig:vlm-completion-grouped。条形深浅表示每类 UI 布局的频率，10-20 个控件最为常见，其次为 20-30 个控件。各布局下的成功率保持稳定，控件数量并未显著降低成功率。

#figure(
  image("figures/vlm_completion_by_UI.pdf", width: 50%),
  caption: [不同 UI 布局下的 VLM 操作完成性能（按源屏幕控件数量分组）。],
) <fig:vlm-completion-grouped>



= 案例研究 <exp:rq4>

我们与一家领先的投资银行与金融服务提供商合作，获得了真实的应用数据集。该应用为移动端金融服务类应用，提供实时股票交易、行情分析、金融资讯推送、组合管理和个性化投资建议等功能。我们基于真实设计稿对该交易型应用进行了定性研究。
在合作中我们共获得 23 份设计稿；剔除已经废弃或依赖真实交易场景的过期设计稿后，最终集中分析了 19 份设计稿。
在这些设计稿中，我们识别出 8 起屏幕不一致和 1 起流程不一致的实例。具体而言，在实现中我们发现 3 处额外控件、9 处缺失控件、3 处文本控件不一致以及 5 处颜色方案不一致。工业界专家反馈指出，缺失的小型控件对人工核验尤为具有挑战性，这进一步凸显了自动化测试工具在发现并解决此类不一致中的重要作用。
上述违规已向我们的工业合作方报告并获得确认。

@fig:case-study-screen-inconsistency 展示了不同类型不一致的实例。在第一个示例中，设计稿中的“开启通知”标签在实现中被替换为“续费订阅”标签，应以加粗显示的日期未被实现，且“市值”标签在实际应用中被替换为“更多 >”。在第二个示例中，“指数类型”标签缺失、分享图标缺失，并且设计稿与最终实现之间存在若干颜色差异。更多示例见匿名网站 @case-study。

#figure(
  grid(
    columns: 3,
    gutter: 0.5em,
    image("figures/case_study/screen/image-1.pdf"),
    image("figures/case_study/screen/image-3.pdf"),
    image("figures/case_study/screen/image-4.pdf"),

    align(center)[(a) 示例 1：语义变化与控件缺失],
    align(center)[(b) 示例 2：语义变化与控件缺失],
    align(center)[(c) 示例 3：语义变化、控件缺失与控件额外],
  ),
  caption: [GUIPilot 在该交易应用上报告的真实屏幕不一致实例。每幅图左侧为设计稿，右侧为实现屏幕。红框表示额外或缺失的控件，黄框表示语义不一致。],
) <fig:case-study-screen-inconsistency>


== 结论
$"设计原型缺乏同步"$
在实际的 App 开发过程中，设计原型相对于当前的实现可能会过时。
这是因为设计原型的维护并不像移动应用程序那样严格。
在软件开发中，代码经历了持续集成和持续部署（CI/CD），确保其定期进行测试、更新和完善。
同样，设计原型也需要一种类似于 CI/CD 的系统化维护方法，以确保它们与应用程序并行演进，保持最新状态。
此外，当开发人员对应用程序实施变更时，应将这些修改传达给设计团队，以确保设计原型得到相应更新。
这需要进行战略性的调整，以提高设计原型在开发周期中的有效性和可用性。

$"设计原型规范建议"$
我们对工业级设计原型的案例研究表明，当前的设计原型设计方法仍有巨大的改进空间。
在工业级设计原型中，缺失了一些重要的规范细节。
在研究中，从应用程序的主屏幕导航到设计原型中指定的起始屏幕并非易事，
这阻碍了我们要应用本工具。
在研究中，我们手动将此类信息包含在工业设计原型中。


$"效度威胁"$
(i) 内部效度：我们的工具依赖于第三方 OpenAI 服务来完成动作，因此网络延迟和稳定性可能会影响性能。未来的改进是蒸馏一个本地的大型视觉-语言模型来缓解这些问题。
(2) 外部效度：
在模拟研究中，由于无法获得实际的设计原型，我们使用真实的移动屏幕截图来模拟原型。只要满足以下条件，我们的工具就可以推广到其他应用程序：(i) 它们的设计原型通过了 @app:meta-model and (ii) each screen transition includes a description $"desc"$ (@app:process). Any shortcomings can be manually corrected.



// 请根据文档类型，自行选择 if-else 中的内容
// 参考文献
#bib(
  bibfunc: bibliography.with("ref.bib"),
  full: false,
)// full: false 表示只显示已引用的文献，不显示未引用的文献；true 表示显示所有文献
#show: appendix




= 绘图

== 流程图 <app:flowchart>

`fletcher` 是一个基于 `CeTZ` 的 `Typst` 包，用于绘制流程图，功能丰富，可参考 `fletcher` 的文档进行学习。

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond, parallelogram

#imagex(
  diagram(
    node-stroke: 0.5pt,
    node-inset: 1em,
    edge-corner-radius: 0pt,
    spacing: 2.5em,

    (
      node((0, 0), "待测图片", corner-radius: 5pt),
      node((0, 1), "读取背景", shape: parallelogram),
      node((0, 2), "匹配特征点对"),
      node((0, 3), "多于阈值", shape: diamond),
    )
      .intersperse(edge("-|>"))
      .join(),
    (
      node((0, 4), "透视变换矩阵"),
      node((0, 5), "图像修正"),
      node((0, 6), "配准结果", corner-radius: 5pt),
    )
      .intersperse(edge("-|>"))
      .join(),
    node((3, 2), "重采"),
    edge("<|-", [是]),
    node((3, 3), "清晰?", shape: diamond),
    edge("-|>", [是]),
    node((3, 4), "仿射变换矩阵"),

    edge((0, 3), (0, 4), [是], "-|>"),
    edge((0, 3), (3, 3), [否], "-|>"),
    edge((3, 4), (0, 5), "-|>", corner: right),
    edge((3, 2), (0, 0), "-|>", corner: left),
  ),
  caption: [绘制流程图效果],
  caption-en: [Flow chart],
  label-name: "fletcher-example",
)

== 数据图

`lilaq` 是一个强大的 Typst 绘图库，可以绘制各种类型的数据图。

#import "@preview/lilaq:0.5.0" as lq

#let xs = (0, 1, 2, 3, 4)
#let (y1, y2) = ((1, 2, 3, 4, 5), (5, 3, 7, 9, 3))

#imagex(
  lq.diagram(
    width: 10cm,
    height: 6cm,

    title: [Precious data],
    xlabel: $x$,
    ylabel: $y$,

    lq.plot(xs, y1, mark: "s", label: [A]),
    lq.plot(xs, y2, mark: "o", label: [B]),
  ),
  caption: [绘制折线图效果],
  caption-en: [Line plots],
  label-name: "lilaq-line-example",
)

#import "@preview/suiji:0.4.0"
#let rng = suiji.gen-rng(33)
#let (rng, x) = suiji.uniform(rng, size: 20)
#let (rng, y) = suiji.uniform(rng, size: 20)
#let (rng, colors) = suiji.uniform(rng, size: 20)
#let (rng, sizes) = suiji.uniform(rng, size: 20)

#imagex(
  lq.diagram(
    width: 10cm,
    height: 6cm,

    lq.scatter(
      x,
      y,
      size: sizes.map(size => 1000 * size),
      color: colors,
      map: color.map.magma,
    ),
  ),
  caption: [绘制散点图效果],
  caption-en: [Scatter],
  label-name: "lilaq-scatter-example",
)


#if doctype == "bachelor" [
  #achievement(
    papers: (
      "Chen H, Chan C T. Acoustic cloaking in three dimensions using acoustic metamaterials[J]. Applied Physics Letters, 2007, 91:183518.",
      "Chen H, Wu B I, Zhang B, et al. Electromagnetic Wave Interactions with a Metamaterial Cloak[J]. Physical Review Letters, 2007, 99(6):63903.",
    ),
    patents: ("第一发明人, 永动机[P], 专利申请号202510149890.0.",),
  )

  #acknowledgement[
    致谢主要感谢导师和对论文工作有直接贡献和帮助的人士和单位。致谢言语应谦虚诚恳，实事求是。
  ]

  #summary-en[
    HCCI (Homogenous Charge Compression Ignition)combustion has advantages in terms of efficiency and reduced emission. HCCI combustion can not only ensure both the high economic and dynamic quality of the engine, but also efficiently reduce the NOx and smoke emission. Moreover, one of the remarkable characteristics of HCCI combustion is that the ignition and combustion process are controlled by the chemical kinetics, so the HCCI ignition time can vary significantly with the changes of engine configuration parameters and operating conditions......
  ]
] else [
  #acknowledgement[
    致谢主要感谢导师和对论文工作有直接贡献和帮助的人士和单位。致谢言语应谦虚诚恳，实事求是。
  ]

  #achievement(
    papers: (
      "Chen H, Chan C T. Acoustic cloaking in three dimensions using acoustic metamaterials[J]. Applied Physics Letters, 2007, 91:183518.",
      "Chen H, Wu B I, Zhang B, et al. Electromagnetic Wave Interactions with a Metamaterial Cloak[J]. Physical Review Letters, 2007, 99(6):63903.",
    ),
    patents: ("第一发明人, 永动机[P], 专利申请号202510149890.0.",),
  )
]


