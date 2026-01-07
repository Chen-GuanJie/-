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
  image("../../figures/mAP_Latency.pdf", width: 50%),
  caption: [目标检测架构比较。纵轴为平均精度均值（mAP），横轴为每张图像的延迟，气泡大小表示参数量。],
) <fig:object-detection-architect>
