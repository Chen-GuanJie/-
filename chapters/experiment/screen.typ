#import "../../define.typ": *
== 屏幕一致性检测实验 <exp:rq1>

=== 实验设置

本实验通过对标准设计稿屏幕进行系统性的自动化变异，模拟真实开发过程中可能出现的各类不一致场景，构建了大规模的测试数据集。所采用的变异策略涵盖了 @moran2018automated 中统计的 92% 的常见 GUI 实现偏差。实验假设绝大多数控件实现正确，仅对每个屏幕中随机选取的 5% 控件（平均约 1-2 个）实施以下几类修改：

- *缺失控件（Missing widgets）：* 随机移除屏幕上 5% 的控件。为确切模拟布局重排效果，移除操作不仅删除了目标控件，还在垂直方向上移除了其所占据的空间行，并将其下方的其余控件相应上移。
- *多余控件（Extra widgets）：* 在屏幕随机位置插入约 5% 的额外控件。系统为新插入的控件分配了独立的布局空间，迫使原有控件向下偏移以腾出位置，从而引发连锁的布局变动。
- *语义变化——控件交换（Swapped widgets）：* 随机选取 5% 的控件对，并将其类型替换为视觉或功能上不同的其他组件（例如将按钮替换为文本框），以此引入语义层面的不一致。
- *语义变化——文本变更（Text change）：* 针对包含文本属性的控件，随机修改其中 5% 控件的字符串内容，产生文案不一致。
- *语义变化——颜色变更（Color change）：* 针对基于图像或图标的控件，随机调整其中 5% 控件的主色调属性，模拟视觉风格上的偏差。

=== 基准方法与对比

本研究选取了 GVT @moran2018automated 作为主要的对比基准（Baseline）。GVT 是目前公认的最先进的移动应用界面自动化比对工具之一，本实验严格复现了其配置参数以确保比较的公平性。此外，为探究大模型直接应用于此类任务的可行性及现有局限，实验还设置了一个基于视觉-语言模型（VLM）的简单基准（Naive Baseline）。该方法将标注有组件 ID 的前后两帧屏幕截图直接输入 VLM，并通过自然语言提示（Prompting）引导模型识别并输出缺失、新增或被修改的控件列表。

=== 评估指标体系

为了全面衡量检测工具的性能，本实验采用了 @moran2018automated 推荐的一套综合评估指标，包括精确率（Precision）、召回率（Recall）、Jaccard 指数以及分类精确率（Type Classification Precision）。各指标的定义基于混淆矩阵中的真阳性（$T P$）、假阳性（$F P$）、假阴性（$F N$）以及分类正确的真阳性（$T P_c$）：

$
  "pre" = (T P) / (T P + F P), quad "rec" = (T P) / (T P + F N) \
  J_"Index" = (T P) / (T P + F N + F P), quad c p = (T P_c) / (T P)
$ <eq:metrics>

具体而言：
- *精确率（Precision）* 反映了工具报告的不一致项中真实存在的比例，即抗误报能力。
- *召回率（Recall）* 衡量了工具发现所有真实不一致项的能力，即抗漏报能力。
- *Jaccard 指数* 是精确率与召回率的调和指标，同时惩罚漏报和误报，是对检测质量的综合评价。
- *分类精确率* 专门用于评估工具在正确识别出不一致位置的同时，是否也能正确判别其不一致的类型（如区分“缺失”与“类型错误”）。

=== 实验结果分析

#figure(
  table(
    columns: (1.2fr, 1fr, 1fr, 1fr, 1.2fr, 1fr, 1fr),
    align: (left, left, center, center, center, center, center),
    stroke: none,
    table.header([*变异类型*], [*方法*], [*精确率*], [*召回率*], [*分类精确率*], [*Jaccard*], [*耗时 (s)*]),
    table.hline(),
    [*多余控件*], [GVT], [0.793], [0.899], [1.000], [0.690], [0.001],
    [], [VLM], [0.088], [0.137], [1.000], [0.056], [1.230],
    [], [#(tool)], [*0.998*], [*0.986*], [1.000], [*0.982*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*缺失控件*], [GVT], [0.912], [0.938], [1.000], [0.840], [0.001],
    [], [VLM], [0.123], [0.154], [1.000], [0.073], [1.430],
    [], [#(tool)], [*0.997*], [*0.984*], [1.000], [*0.978*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*交换控件*], [GVT], [0.283], [0.430], [1.000], [0.200], [0.001],
    [], [VLM], [0.045], [0.078], [0.910], [0.026], [1.530],
    [], [#(tool)], [*0.987*], [*0.992*], [1.000], [*0.971*], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*文本变更*], [GVT], [0.998], [0.999], [0.981], [0.960], [0.001],
    [], [VLM], [0.119], [0.248], [0.992], [0.086], [1.870],
    [], [#(tool)], [0.996], [0.999], [0.981], [0.960], [0.001],
    table.hline(stroke: 0.5pt + gray),
    [*颜色变更*], [GVT], [1.000], [0.999], [1.000], [0.990], [0.001],
    [], [VLM], [0.075], [0.177], [0.964], [0.052], [3.110],
    [], [#(tool)], [1.000], [0.999], [1.000], [0.990], [0.001],
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
    align(center)[#(tool) (示例 1)],
    align(center)[GVT (示例 2)],
    align(center)[#(tool) (示例 2)],

    image("../../figures/gvt_fails_guipilot_success/5_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/5_guipilot.pdf"),
    image("../../figures/gvt_fails_guipilot_success/6_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/6_guipilot.pdf"),

    align(center)[GVT (示例 3)],
    align(center)[#(tool) (示例 3)],
    align(center)[GVT (示例 4)],
    align(center)[#(tool) (示例 4)],

    image("../../figures/gvt_fails_guipilot_success/9_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/9_guipilot.pdf"),
    image("../../figures/gvt_fails_guipilot_success/11_gvt.pdf"),
    image("../../figures/gvt_fails_guipilot_success/11_guipilot.pdf"),

    align(center)[GVT (示例 5)],
    align(center)[#(tool) (示例 5)],
    align(center)[GVT (示例 6)],
    align(center)[#(tool) (示例 6)],
  ),
  caption: [GVT 和 #(tool) 之间的比较。在每张图中，原始屏幕显示在左侧，变异屏幕（插入、删除或交换后）显示在右侧。红色框表示多余或缺失的控件。绿色框表示不受变异影响的控件。黄色框表示由于变异而移动但仍能识别匹配的控件。],
) <fig:gui-win>

@tab:screen-inconsistency-results 详细展示了 #(tool) 与基准方法 GVT @moran2018automated 的对比数据。综合实验结果表明，#(tool) 在各类不一致性检测任务中均表现出色，尤其在处理涉及布局变动的复杂场景时拥有显著优势。具体而言，对于多余控件（Extra widgets）检测和控件交换（Swapped widgets）检测，#(tool) 展现了近乎完美的准确率（Jaccard 指数分别达到 0.982 与 0.971），大幅领先于 GVT。而在处理文本更改或颜色替换等不改变布局结构的局部属性变化时，#(tool) 的性能与 GVT 持平，维持了极高的检测水准。值得强调的是，#(tool) 获得性能提升的同时，并没有引入显著的额外计算开销，保证了检测的高效性。

相比之下，直接通过 Prompt 方式查询 VLM 的基准方法表现不佳，不仅运行耗时远高于专用工具，且在多数任务上的各项指标均极低。定性分析发现，VLM 在处理此类细粒度差异对比任务时存在严重的“幻觉”问题，经常臆造并不存在的差异（高假阳性），或者即便发现了差异也难以将其精确定位到具体的控件 ID 上（高定位错误率）。

=== 结果讨论与优势分析

*对布局偏移的鲁棒性：*
GVT 的核心缺陷在于其高度依赖控件的绝对坐标或相对网格位置进行匹配，这使其对界面布局的微小扰动极为敏感。在真实场景中，仅仅插入或删除一个控件往往会导致后续所有同列元素的级联移动（如 @fig:gui-win 所示）。这种整体性的坐标偏移会导致 GVT 的贪婪匹配算法失效，错误地将位移后的正确控件判定为不匹配，从而产生大量的连锁误报。相比之下，#(tool) 采用了基于最长公共子序列（LCS）的动态规划对齐算法，并融合了位置、形状和类型等多模态特征。这种设计使得 #(tool) 能够理解序列结构，在即使发生像素级坐标偏移的情况下，依然能够根据上下文关系找回正确的对应关系，从而精确区分“真正的缺失”与“合法的移动”。

*对语义交换的识别能力：*
在控件交换（Swapped widgets）场景下，即两个控件位置互换或原位类型变更，GVT 由于设置了严格的类型匹配约束或过于简单的距离阈值，往往无法将变化后的控件与原位置的控件关联起来，导致其将一次“交换”错误地拆解为一次“缺失”和一次“多余”。而 #(tool) 通过综合权重的相似度度量矩阵，允许跨类型的弱匹配存在，能够敏锐地识别出控件虽发生了类型质变但依然存在逻辑对应关系，从而正确报告出“语义不一致”而非简单的增删，如 @fig:gui-win 中的示例 5 和 6 所示。

=== 错误案例深度分析

尽管 #(tool) 表现出了较强的鲁棒性，但在部分极端场景下仍存在误判，主要集中在以下两类情况：

*假阳性（False Positives）分析：*
当界面发生剧烈的布局重构，且插入的新控件与原有相邻控件在视觉特征（如形状、类型）上极度相似时，#(tool) 的匹配算法可能会发生“错位匹配”。例如，插入的一个标准按钮可能被误认为是原有按钮的位移，导致真正的原有按钮反而处于未匹配状态，进而被误报为缺失（见 @fig:gui-fail 中的 FP 示例 1-2）。此外，某些复杂的控件交换可能导致元素间的重叠覆盖（FP 示例 3），这种物理上的遮挡会严重干扰视觉特征提取，导致相似度计算偏差，进而引发误匹配。
#figure(
  grid(
    columns: 2,
    gutter: 0.5em,
    image("../../figures/guipilot_fp/2.pdf"), image("../../figures/guipilot_fp/5.pdf"),
    align(center)[FP 示例 1], align(center)[FP 示例 2],
    image("../../figures/guipilot_fp/9.pdf"), image("../../figures/guipilot_fn/3.pdf"),
    [], [],
    align(center)[FP 示例 3], align(center)[FN 示例 1],
    [], [],
  ),
  caption: [#(tool) 的假阳性 (FP) 和假阴性 (FN) 示例。],
) <fig:gui-fail>

*假阴性（False Negatives）分析：*
假阴性的产生主要归因于两个方面：一是与假阳性类似的严重错位匹配，导致本应报出的差异被错误的“张冠李戴”掩盖；二是上游视觉检测模型的失效。如果在实现端截图中，新插入的控件未能被目标检测模型（YOLO）正确识别（如 @fig:gui-fail 中的 FN 示例 1），那么后续的匹配逻辑自然无从谈起，导致该不一致项被彻底遗漏。这表明，自动化检测流程的整体上限在一定程度上受限于基础视觉感知模块的性能。

