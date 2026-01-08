#import "@preview/modern-sjtu-thesis:0.5.1": *
#import "define.typ": *
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
    title: "基于语言模型的移动应用GUI一致性自动化测试方法研究",
    title_en: "Automated GUI Consistency Testing for Mobile Applications Based on Language Models",
    school: "计算机学院",
    school_en: "School of Computer Science",
    major: "电子信息专业",
  ),
)

#show: doc

#cover()

#cover-en()

#declare(
  confidentialty-level: "internal", // 保密级别: "public" | "internal" | "secret" | "confidential"
  confidentialty-year: 2, // 保密年份数，请根据保密级别的要求填写
  date: datetime.today(),
  original-statement-sign: place(dx: 13cm, dy: -1.3cm, image("figures/student-sign2.jpg", height: 2em)), // 请根据签名图片的大小，自行调整图片的高度和位置
  authorization-author-sign: place(dx: 5cm, dy: -1.3cm, image("figures/student-sign2.jpg", height: 2em)),
  supervisor-sign: place(dx: 4cm, dy: -1.2cm, image("figures/supervisor-sign.png", height: 2em)),
) // 不需要显示日期和签名，可直接注释

#show: preface

#abstract(keywords: (
  "GUI 测试",
  "移动应用",
  "设计稿",
  "视觉-语言模型",
))[
  图形用户界面（GUI）测试对于保障移动应用程序的可靠性至关重要。当前主流的GUI测试方法在探索更多应用场景和发现通用缺陷（如应用程序崩溃）方面表现出色。然而，工业级GUI测试还需要检测应用特定缺陷，例如屏幕布局、控件位置或GUI跳转与应用设计师所创建的GUI设计稿之间的偏差。这些设计稿明确规定了预期的屏幕界面、控件及其相应的交互行为。验证GUI设计与实际实现之间的一致性是一项耗时费力的工作，但这一验证环节在工业级GUI测试中具有重要意义。
  本研究提出了GUIPilot方法，用于检测移动端设计稿与其实现之间的不一致性。移动端设计通常由设计稿组成，这些设计稿规定了：（1）预期的屏幕外观（如控件布局、颜色和形状）；（2）预期的屏幕行为，即屏幕之间的跳转方式（如带有文本描述标签的控件）。给定设计稿及其对应的应用实现，GUIPilot能够同时报告屏幕不一致性和流程不一致性。
  在屏幕不一致性检测方面，GUIPilot将每个屏幕抽象为控件容器，其中每个控件由其位置、宽度、高度和类型表示。通过定义控件的偏序关系以及屏幕中控件替换、插入和删除的代价，本文将屏幕匹配问题转化为可估计的控件对齐问题。在流程不一致性检测方面，本文将规定的GUI跳转转换为移动屏幕上的逐步操作（如点击、长按、在某些控件上输入文本）。为此，本文提出了一种面向视觉-语言模型的视觉提示方法，以推断屏幕上针对特定控件的操作。通过这种方式，可以验证实现中预期跳转的存在与否。
  本文在80个移动应用程序和160个设计稿上进行了大量实验，结果表明：（1）GUIPilot在屏幕不一致性检测方面可达到99.8\%的精确率和98.6\%的召回率；（2）GUIPilot在流程不一致性检测方面实现了零错误率。此外，本文在某交易类移动应用上开展的工业案例研究表明，GUIPilot检测出了9个应用缺陷，且所有缺陷均得到了原应用专家的确认。
]

#abstract-en(keywords: (
  "GUI testing",
  "mobile applications",
  "design mock-ups",
  "vision-language models",
))[
  GUI testing is crucial for ensuring the reliability of mobile applications. State-of-the-art GUI testing approaches are successful in exploring more application scenarios and discovering general bugs such as application crashes. However, industrial GUI testing also needs to investigate application-specific bugs such as deviations in screen layout, widget position, or GUI transition from the GUI design mock-ups created by the application designers. These mock-ups specify the expected screens, widgets, and their respective behaviors. Validating the consistency between the GUI design and the implementation is labor-intensive and time-consuming, yet, this validation step plays an important role in industrial GUI testing.
  In this work, we propose #(tool), an approach for detecting inconsistencies between the mobile design and their implementations. The mobile design usually consists of design mock-ups that specify (1) the expected screen appearances (e.g., widget layouts, colors, and shapes) and (2) the expected screen behaviors, regarding how one screen can transition into another (e.g., labeled widgets with textual description). Given a design mock-up and the implementation of its application, #(tool) reports both their screen inconsistencies as well as process inconsistencies. On the one hand, #(tool) detects the screen inconsistencies by abstracting every screen into a widget container where each widget is represented by its position, width, height, and type. By defining the partial order of widgets and the costs of replacing, inserting, and deleting widgets in a screen, we convert the screen-matching problem into an estimizable widget alignment problem. On the other hand, we translate the specified GUI transition into stepwise actions on the mobile screen (e.g., click, long-press, input text on some widgets). To this end, we propose a visual prompt for the vision-language model to infer widget-specific actions on the screen. By this means, we can validate the presence or absence of expected transitions in the implementation. Our extensive experiments on 80 mobile applications and 160 design mock-ups show that (1) #(tool) can achieve $99.8\%$ precision and $98.6\%$ recall in detecting screen inconsistencies, and (2) #(tool) reports zero errors in detecting process inconsistencies. Furthermore, our industrial case study on applying #(tool) on a trading mobile application shows that #(tool) has detected nine application bugs, and all the bugs were confirmed by the original application experts.
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

// 正文内容
#include "chapters/intro.typ"
#include "chapters/background.typ"

#include "chapters/approach/main.typ"
#include "chapters/experiment/main.typ"

#include "chapters/conclusion/main.typ"

// 请根据文档类型，自行选择 if-else 中的内容
// 参考文献
#bib(
  bibfunc: bibliography.with("ref.bib"),
  full: false,
)// full: false 表示只显示已引用的文献，不显示未引用的文献；true 表示显示所有文献

//附录
#show: appendix
#acknowledgement[
  致谢主要感谢导师和对论文工作有直接贡献和帮助的人士和单位。致谢言语应谦虚诚恳，实事求是。
]

#achievement(
  patents: ("第二发明人, 面向需求设计稿的GUI软件测试系统及方法[P], 专利申请号CN202510267792.7",),
)



