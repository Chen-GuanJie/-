== 控件检测性能 <exp:rq3-1>

=== 实验设置与数据集
控件检测器是后续所有一致性分析的基础，其性能直接决定了系统整体的有效性上限。本节对所采用的视觉检测模型（具体为 YOLO-v8 middle 版本 @yolov8）进行独立评估。实验使用的数据集包含了从公开可获取的真实应用中采集的 1392 张高分辨率屏幕截图。为了保证评估的客观性，数据集按照 7:3 的比例随机划分为训练集与测试集，其中测试集中的屏幕样本从未参与模型训练，以检验模型的泛化能力。

评价指标遵循目标检测领域的标准规范 @map，主要采用平均精度均值（Mean Average Precision, mAP）和平均召回均值（Mean Average Recall, mAR）。所有指标均在交并比（Intersection over Union, IoU）阈值设为 0.5 的条件下计算（即 $m A P @ I o U = 0.5$），这意味着仅当检测框与人工标注的真实框（Ground Truth）重叠面积超过 50% 时，该检测才被视为“命中”。

=== 实验结果与误差来源
@tab:widget-detection-accuracy 详细列出了模型在七大控件类别上的检测性能。从总体来看，模型在多样化的公开数据集上达到了 0.515 的 mAP 和 0.588 的 mAR，这一结果展现了令人满意的基准性能，作为对比参考，同类模型在通用的 COCO 数据集上的 mAP 约为 0.502 @ultralytics-yolov8。这表明经过 GUI 领域数据微调的模型已具备理解复杂应用界面的基本能力。

然而，分类别的详细分析揭示了模型在特定控件上的性能短板：
- *输入框（InputBox）与 文本按钮（TextButton）的混淆*：InputBox 的检测精度相对较低（mAP 0.446），主要归因于其在静止状态下的视觉特征（通常仅为“边框+占位符文本”）与普通的 TextButton 或 CombinedButton 极其相似。这使得纯视觉模型在缺乏交互上下文的情况下难以进行准确区分。作为改进策略，未来可在检测流水线中引入基于代码层级的属性检查（如检查 View 属性是否包含 `editable`），作为纯视觉推断的补充。
- *图表（Chart）的边界模糊*：Chart 类的检测效果最差（mAP 0.317）。定性分析显示，这主要是因为图表这种复杂控件往往与背景融合紧密，缺乏明确的封闭轮廓，且内部的数据点、坐标轴极易被误检为独立的微小控件，从而干扰了对图表整体边界框的回归。

为了进一步验证选型依据，@fig:object-detection-architect 展示了不同模型架构在精度与延迟之间的权衡关系。YOLO-v8 middle 在保持实时推理速度的同时提供了最佳的精度表现，因此被选为本系统的核心检测引擎。

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
  caption: [各具体控件类别的检测性能指标（IoU=0.5 下的 mAP 与 mAR）。],
) <tab:widget-detection-accuracy>

#figure(
  image("../../figures/mAP_Latency.pdf", width: 50%),
  caption: [目标检测模型架构的性能权衡对比。纵轴代表平均精度均值（mAP），横轴为处理单帧图像的推理延迟（Latency）。气泡大小正比于模型的参数量（FLOPs）。],
) <fig:object-detection-architect>
