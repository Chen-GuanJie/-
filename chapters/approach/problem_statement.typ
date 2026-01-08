#import "@preview/modern-sjtu-thesis:0.5.1": *
#import "../../define.typ": *
== 问题定义 <sec:ps>

本节将给出相关概念的形式化定义和具体的问题定义。

#tablex(
  columns: (1fr, 1fr),
  align: left,
  caption: [控件类别],
  caption-en: [Widget categories],
  label-name: "widget-class",
  header: (
    [*Interactable*],
    [*Non-Interactable*],
  ),

  [TextButton #h(0.5em)
    #box(image("../../figures/widgets/textbutton/6.pdf", height: 0.7cm)) #h(0.5em)
    #box(image("../../figures/widgets/textbutton/7.pdf", height: 0.7cm))],
  [TextView #h(0.5em)
    #box(image("../../figures/widgets/textview/5.pdf", height: 0.7cm)) #h(0.5em)
    #box(image("../../figures/widgets/textview/12.pdf", height: 0.7cm))],

  [IconButton #h(0.5em)
    #box(image("../../figures/widgets/iconbutton/2.pdf", height: 0.7cm)) #h(0.2em)
    #box(image("../../figures/widgets/iconbutton/4.pdf", height: 0.7cm)) #h(0.2em)
    #box(image("../../figures/widgets/iconbutton/9.pdf", height: 0.7cm)) #h(0.5em)
    #box(image("../../figures/widgets/switch/1.pdf", height: 0.7cm))],
  [ImageView #h(0.5em)
    #box(image("../../figures/widgets/imageview/6.pdf", height: 0.7cm)) #h(0.2em)
    #box(image("../../figures/widgets/imageview/20.pdf", height: 0.7cm)) #h(0.2em)
    #box(image("../../figures/widgets/imageview/18.pdf", height: 0.7cm))],

  [CombinedButton #h(0.5em)
    #box(image("../../figures/widgets/combinedbutton/1.pdf", height: 1.5cm)) #h(0.5em)
    #box(image("../../figures/widgets/combinedbutton/2.pdf", height: 1.5cm))],
  [Chart #h(0.5em)
    #box(image("../../figures/widgets/chart/9.pdf", height: 1.75cm))],

  table.cell(colspan: 2)[InputBox #h(0.5em)
    #box(image("../../figures/widgets/input/3.pdf", width: 50%))],
)


*屏幕（Screen）。* 屏幕 $screen$ 被形式化定义为单个 GUI 界面，其包含若干视觉控件，如图像、按钮、文本等。每个控件 $widget$ 以 $chevron.l x, y, w, h, t chevron.r$ 的五元组格式表示。其中，$x, y$ 代表控件在以截图左上角为原点的坐标系中的左上角坐标；$w, h$ 分别表示控件相对于完整截图尺寸的归一化宽度和高度；$t$ 标识该控件的类型。本研究定义了 7 种主要的控件类型，具体的视觉示例详见 @tbl:widget-class。一个屏幕可表示为一组控件的集合，即 $widget = {widget_i | widget_i = chevron.l x, y, w, h, t chevron.r}$。

如@tbl:widget-class 所示，依据可交互性将控件分为两类：(1) 可交互控件，包括文本按钮（TextButton）、图标按钮（IconButton）、组合按钮（CombinedButton）和输入框（InputBox）。文本按钮通过文字传达功能，图标按钮依赖图形符号，组合按钮整合了图文信息以提供更丰富的语义，输入框则支持文本输入交互；(2) 不可交互控件，涵盖文本视图（TextView）、图像视图（ImageView）和图表（Chart），主要用于静态信息的展示。

*操作（Action）。* 在单个屏幕 $screen$ 上，用户可执行一系列交互操作，每个操作均针对特定的控件。本研究定义的操作空间包含 7 种原子动作：点击（Click）、长按（Long Press）、输入文本（Input Text）、滚动（Scroll）、滑动（Swipe）、拖放（Drag & Drop）和返回（Back）。操作链 $actionchain$ 定义为按时序排列的一系列操作序列 $actionchain = (actionchain_1(widget_1),action_2(widget_2), ...,action_i(widget_i))$。以 @img:mockup-example 为例，完成从屏幕 4 跳转到屏幕 5 的任务，其对应的操作链为 $actionchain$ = (点击(密码输入框), 输入文本(用户密码), 点击(协议复选框), 点击(安装按钮))。

*流程（Process）。* 流程 $process$ 被建模为一个有向连通图 $process: G = ( screen, actionchainset )$。其中，$screen$ 代表一组屏幕节点集合，$actionchainset$ 代表一组操作链集合。图中的每一条边由操作链 $actionchain in actionchainset$ 构成，该操作链驱动应用从当前屏幕状态转换到下一个屏幕状态（或保持状态不变）。例如，@img:mockup-example 展示的登录流程由 5 个顶点（屏幕）组成，它们之间通过 4 条有向边（操作链或状态转移）相连。

*屏幕不一致性（Screen Inconsistency）。* 本文关注三种类型的屏幕级不一致：多余控件、缺失控件和语义变化。形式化地，记设计稿中特定屏幕的控件集合为 $widget^tar$，实现端对应屏幕的控件集合为 $widget$。假设存在一个理想的匹配函数 $f(.)$，该函数接受两个控件集合并返回成功匹配的控件对集合，即 $f(widget^tar, widget) = {(widget^tar_i, widget_j) | widget^tar_i in widget^tar, widget_j in widget "且匹配成功"}$。当满足以下任一条件时，判定存在不一致性：

_(i) 实现中缺失控件。_

$ exists widget^tar_i in widget^tar "使得" widget^tar_i product f(widget^tar, widget) $ <eq:miss-widget>

_(ii) 实现中存在多余控件。_

$ exists widget_j in widget "使得" widget_j product f(widget^tar, widget) $ <eq:extra-widget>

_(iii) 匹配控件的语义变化。_

两个控件成功配对但表现出不同的语义。例如，它们的文本、颜色或控件类型可能已被更改。设 $epsilon.alt_s$ 为可接受语义变化的阈值，设 $g(.)$ 表示将控件映射到d维表示向量的语义提取函数。两个配对控件之间的语义差异可以量化为它们语义向量之间的距离：

$
  exists & (widget^tar_i, widget_j) in f(widget^tar, widget) "使得" \
         & t_i != t_j "或" norm(g(widget^tar_i) - g(widget_j))_2 > epsilon.alt_s
$ <eq:semantic-change>

*流程不一致性（Process Inconsistency）。* 流程不一致性检测本质上是一个考虑拓扑同构的图比较问题。设设计稿上的预期流程为 $process^tar: G = ( screen^tar, actionchainset^tar )$。由于 $actionchainset^tar$ 可能包含模糊或非原子化的指令，需先进行指令补全与规范化，生成修正后的可执行操作链集 $actionchainset^tar_(c o m p l e t e)$。随后，在实现端执行 $actionchainset^tar_(c o m p l e t e)$ 将在应用程序上生成实际的运行时流程图 $process: G = (screen, actionchainset^tar_(c o m p l e t e))$。通过逐一比对设计稿流程图 $process^tar$ 和实现流程图 $process$ 之间的对应边，识别并报告满足以下条件的不一致边：

$
  exists & t, (screen_t^tar, actionchainset_t^tar, screen_(t+1)^tar) in process^tar, (screen_t,action_t, screen_(t+1)) in process \
  & "使得" s i m(screen_(t+1), screen_(t+1)^tar) < epsilon.alt_(s c r e e n)
$ <eq:process-change>
#imagex(
  image(
    "../../figures/introduction_example.png",
    width: 95%,
  ),
  caption: [交易类移动应用登录流程的设计稿示例，包含五个屏幕和四个转换。],
  caption-en: [A design mock-up on the login process of a trading mobile application, consisting of five screens and four transitions.],
  label-name: "mockup-example",
)
