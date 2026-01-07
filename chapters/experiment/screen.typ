== 屏幕一致性检测实验 <exp:rq1>

=== 实验设置

本实验对模拟的设计原型屏幕进行变异，以注入屏幕不一致性。具体包括以下常见的 GUI 变异类型，覆盖了 92% 的实际变异案例 @moran2018automated。假设大部分控件实现正确，每个变异案例中随机选择屏幕上 5% 的控件进行修改，平均每屏修改 1-2 个控件，设置与 @moran2018automated 保持一致。

- *缺失控件（Missing widgets）：* 每个屏幕随机选择 5% 的控件进行删除。为模拟真实渲染效果，删除包含所选控件的整行，并将剩余控件向上移动。
- *多余控件（Extra widgets）：* 每个屏幕随机插入约 5% 的额外控件。为这些控件添加完整的行，并将现有控件相应向下移动。
- *语义变化——控件交换（Swapped widgets）：* 每个屏幕随机选择 5% 的控件，并与其他类型控件交换，以引入语义变化。
- *语义变化——文本变更（Text change）：* 每个屏幕随机选择 5% 的基于文本控件并更改其文本内容，产生语义不一致。
- *语义变化——颜色变更（Color change）：* 每个屏幕随机选择 5% 的基于图像控件并更改其颜色，引入语义差异。

=== 基准方法

本实验选择 GVT @moran2018automated 作为基准方法，因其为当前最先进的移动应用屏幕比对解决方案，实验配置与 @moran2018automated 保持一致。为验证模型设计的必要性，还引入了直接查询视觉-语言模型（VLM）进行不一致性检查的简单基准。具体做法为，将带有控件 ID 标注的两个屏幕输入 VLM，并提示其判断是否存在缺失、插入或语义编辑的控件。

=== 评估指标

评估指标采用 @moran2018automated 中的精确率（Precision）、召回率（Recall）、Jaccard 指数（Jaccard Index）和分类精确率（Classification Precision）。设 $T P$、$F P$、$F N$ 和 $T P_c$ 分别表示真阳性不一致、假阳性不一致、假阴性不一致和类型正确的真阳性。各指标计算如下：

$
  "pre" = (T P) / (T P + F P), quad "rec" = (T P) / (T P + F N) \
  J_"Index" = (T P) / (T P + F N + F P), quad c p = (T P_c) / (T P)
$ <eq:metrics>

其中，精确率 $"pre"$ 为报告的真实不一致数除以报告的不一致总数；召回率 $"rec"$ 为报告的真实不一致数除以不一致总数；Jaccard 指数 $J_"Index"$ 对假阴性（未报告的真实不一致）和假阳性（错误警报）均进行惩罚；分类精确率 $c p$ 为被正确识别为正确类型的真实报告不一致数除以真实报告不一致总数。

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
    image("../../figures/gvt_fails_guipilot_success/1_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/1_guipilot.pdf"),
    image("../../figures/gvt_fails_guipilot_success/2_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/2_guipilot.pdf"),

    align(center)[GVT (示例 1)],
    align(center)[GUIPilot (示例 1)],
    align(center)[GVT (示例 2)],
    align(center)[GUIPilot (示例 2)],

    image("../../figures/gvt_fails_guipilot_success/5_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/5_guipilot.pdf"),
    image("../../figures/gvt_fails_guipilot_success/6_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/6_guipilot.pdf"),

    align(center)[GVT (示例 3)],
    align(center)[GUIPilot (示例 3)],
    align(center)[GVT (示例 4)],
    align(center)[GUIPilot (示例 4)],

    image("../../figures/gvt_fails_guipilot_success/9_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/9_guipilot.pdf"),
    image("../../figures/gvt_fails_guipilot_success/11_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/11_guipilot.pdf"),

    align(center)[GVT (示例 5)],
    align(center)[GUIPilot (示例 5)],
    align(center)[GVT (示例 6)],
    align(center)[GUIPilot (示例 6)],
  ),
  caption: [GVT 和 GUIPilot 之间的比较。在每张图中，原始屏幕显示在左侧，变异屏幕（插入、删除或交换后）显示在右侧。红色框表示多余或缺失的控件。绿色框表示不受变异影响的控件。黄色框表示由于变异而移动但仍能识别匹配的控件。],
) <fig:gui-win>

@tab:screen-inconsistency-results 展示了 GUIPilot 与 GVT @moran2018automated 的对比分析结果。总体来看，GUIPilot 在检测布局违规（如多余控件和控件交换）方面表现更优。对于颜色和文本更改等原地语义变化，GUIPilot 的性能与 GVT 相当。值得注意的是，GUIPilot 在不增加额外运行时开销的情况下实现了这些结果。

此外，直接查询 VLM 的分类性能较差，且运行时间较长。实验观察到 VLM 可能会产生幻觉，报告不存在的不一致（假阳性），或者虽然识别出不一致但分配了错误的控件 ID（假阳性和假阴性）。

=== GUIPilot 优势分析
GVT 更容易受到位置偏移的影响。GVT 主要依赖控件的相对位置进行匹配，对 GUI 布局的微小移动非常敏感。相比之下，GUIPilot 同时考虑控件的位置、形状和类型，即使发生微小偏移也能正确匹配。如 @fig:gui-win 所示，插入或删除控件时，若后续控件位置略有偏移，GVT 会出现匹配错误，而 GUIPilot 具备更强鲁棒性。

此外，GVT 严格的匹配阈值可能忽略正确配对。在控件交换场景下（@fig:gui-win 示例 5-6），GVT 由于阈值限制无法识别交换配对，往往将其报告为缺失或多余控件。GUIPilot 则能正确将控件与其交换对进行匹配，报告更为准确。

=== GUIPilot 假阳性分析
显著的布局变化时，GUIPilot 可能出现假阳性。尽管对布局扰动更具鲁棒性，但在插入或相邻控件类型、形状相似时，仍可能误匹配。如 @fig:gui-fail （FP 示例 1-2）所示，插入或删除控件可能与相邻控件配对，导致后续控件未配对并被误报为缺失或多余元素。潜在补救措施包括开发更鲁棒的相似性度量以更好捕捉语义和上下文。

重叠控件也会导致假阳性。控件交换有时会导致控件重叠（FP 示例 3），可能导致控件错误匹配或干扰外观，如改变底层控件颜色。

#figure(
  grid(
    columns: 3,
    gutter: 0.5em,
    image("../../figures/guipilot_fp/2.pdf"), image("../../figures/guipilot_fp/5.pdf"), image("../../figures/guipilot_fp/9.pdf"),
    align(center)[FP 示例 1], align(center)[FP 示例 2], align(center)[FP 示例 3],

    image("../../figures/guipilot_fn/3.pdf"), [], [],
    align(center)[FN 示例 1], [], [],
  ),
  caption: [GUIPilot 的假阳性 (FP) 和假阴性 (FN) 示例。],
) <fig:gui-fail>

=== GUIPilot 假阴性分析
与假阳性原因类似，显著变化也会导致假阴性。控件未对齐时，实际缺失或多余元素可能与不相关控件配对，导致未被报告。此外，控件检测器故障也会导致假阴性。如 @fig:gui-fail （FN 示例 1）所示，插入控件未被目标检测器检测到，导致遗漏报告。

