= 问题陈述 <sec:ps>
#import "@preview/modern-sjtu-thesis:0.5.1": *

在本节中，我们给出形式化定义和问题陈述。
#let bf(x) = math.bold(math.upright(x))



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
#imagex(
  image(
    "../figures/introduction_example.pdf",
    width: 95%,
  ),
  caption: [交易类移动应用登录流程的设计稿示例，包含五个屏幕和四个转换。],
  caption-en: [A design mock-up on the login process of a trading mobile application, consisting of five screens and four transitions.],
  label-name: "mockup-example",
)