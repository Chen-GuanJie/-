
#import "@preview/modern-sjtu-thesis:0.5.1": *

#let bf(x) = math.bold(math.upright(x))

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


- *步骤 1：基于递归布局分解的组件偏序关系（@algo:widget-matching 的第 2-- 3 行）。*
  传统的基于坐标（$y$-then-$x$）的排序在处理复杂嵌套布局时容易丢失结构语义。为此，我们提出了一种基于递归投影切割（Recursive Projection Cut）的组件线性化算法。
  该算法 $cal(L)(W)$ 将无序的组件集合 $W$ 递归地分解为具有视觉逻辑的有序序列。
  首先，算法分别沿 $X$ 轴（垂直切分）和 $Y$ 轴（水平切分）计算组件的投影间隙，尝试将集合 $W$ 划分为潜在的子组群 $cal(G)_x$ 和 $cal(G)_y$。
  为了确定当前的布局流向（即是行布局还是列布局），我们计算切分后各子组内部边界对齐的标准差 $sigma$，并选择对齐度更高（标准差更小）的方向作为最优分割轴 $d^*$：
  $
    d^* = arg min_(d in {x, y}) ( sum_(g in cal(G)_d) sigma("align"(g)) )
  $
  基于最优轴 $d^*$，集合 $W$ 被分割为有序子数组 $g_1, g_2, dots, g_k$。最终的偏序序列通过递归连接子组生成：
  $
    cal(L)(W) = cases(
      (w) & "若" |W|=1,
      cal(L)(g_1) plus cal(L)(g_2) plus dots plus cal(L)(g_k) & "其他"
    )
  $
  其中 $plus$ 表示序列连接操作。该算法来源于 `relative_loc` 布局分析模块，能有效保持视觉上相邻或包含的组件在逻辑序列中的邻接性。

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
    + /* 步骤 1: 基于递归投影切割的组件线性化 */
    + $bf(W)_1 <- cal(L)(bf(W)_1)$
    + $bf(W)_2 <- cal(L)(bf(W)_2)$
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



