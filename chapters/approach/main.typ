#import "@preview/modern-sjtu-thesis:0.5.1": *
= 方法实现
== 总体概述

#imagex(
  image(
    "../../figures/overview.pdf",
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

#include "meta_model.typ"
#include "screen.typ"
#include "process.typ"