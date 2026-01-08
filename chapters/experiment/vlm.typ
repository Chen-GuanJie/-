#import "@preview/modern-sjtu-thesis:0.5.1": *
== VLM 操作完成性能 <exp:rq3-2>

=== 实验设置与评估目标
本节聚焦于评估视觉-语言模型（VLM）在基于视觉的自动化交互任务中的表现。实验复用了 RQ2 @exp:rq2 中的 100 个典型屏幕跳转场景，旨在检验 VLM Agent 将高层自然语言指令转化为低层可执行设备操作的能力。具体而言，输入的上下文包括：一条描述用户意图的自然语言命令（如“点击首个搜索建议项”或“展开侧边导航栏”），以及一张经过预处理的 GUI 屏幕截图，图中所有的可交互控件均已被加上可见的数字索引标签和高亮边框。

实验定义 VLM Agent 的核心任务为两步：
(1) *视觉定位（Visual Grounding）：* 准确识别并关联截图中的数字索引，找到响应该指令的目标控件；
(2) *动作映射（Action Mapping）：* 将自然语言描述转换为标准化的 API 调用格式（如 `click(widget_id=5)`），确保指令切实可执行。

衡量指标采用“单次跳转成功率”（Step Success Rate），即 Agent 是否能通过单一或有限次尝试，正确驱动应用从当前状态跳转至预期的目标状态。本实验选用 GPT-4o 模型作为基础 VLM，该模型代表了当前多模态理解与生成的先进水平，且在推理延迟与成本效益之间取得了较好的平衡。

=== 实验结果与误差分析
实验结果显示，在 100 个测试样本中，模型在首轮交互中即获得成功的案例达到 90 个；当允许模型在第一次失败后结合错误反馈进行一轮自我修正（Self-reflection）时，累计成功样本增至 99 个。这表明引入简单的迭代反馈循环能显著纠正偶发的幻觉或定位偏差，大幅提升系统的鲁棒性。关于这一个不可恢复的失败案例，经深入排查发现，根因在于上游的目标检测器未能检测到该特殊控件，导致输入 VLM 的提示图中该控件缺失索引标注，VLM 因而无法引用它执行操作。这再次印证了基础视觉感知模块对端到端系统性能的制约作用。

进一步的控制变量分析探究了屏幕复杂度对模型性能的影响。将测试样本按屏幕内控件数量划分为五个区间（1-10, 10-20, ..., 40+），结果如 @img:vlm-completion-grouped 所示。统计数据呈现出一种有趣的稳定性：尽管屏幕元素数量的增加客观上提高了视觉检索的难度，但 VLM 的操作成功率并未随界面密度的增加而出现显著下降。这一现象暗示了现代 VLM 具备较强的注意力聚焦能力，能够在复杂的视觉噪声中根据语义线索精准锁定目标区域。

#imagex(
  image("../../figures/vlm_completion_by_UI.pdf", width: 90%),
  caption: [不同 UI 布局下的 VLM 操作完成性能（按源屏幕控件数量分组）。条形颜色的深浅代表了该类别在测试集中的分布频率，其中包含 10-30 个控件的中等复杂度界面占多数。],
  caption-en: [
    VLM action completion performance under different UI layouts (grouped by the number of widgets on the source screen). The color intensity of the bars represents the distribution frequency of that category in the test set, with medium-complexity interfaces containing 10-30 widgets being the most common.
  ],
  label-name: "vlm-completion-grouped",
)

