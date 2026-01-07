#import "@preview/modern-sjtu-thesis:0.5.1": *

== 原型元模型与一致性检查<app:meta-model>
#imagex(
  image(
    "../../figures/metamodel.pdf",
    width: 80%,
  ),
  caption: [设计原型的元模型],
  caption-en: [The meta-model of design mock-ups],
  label-name: "meta-model",
)

如 @img:meta-model 所示，我们的元模型由四个关键要素组成：流程（process）、界面（screen）、组件（widget）和操作（action）。
每个流程都具有一个唯一的起始界面以及至少一个结束界面。
一个流程可以表示为一个由多个界面及其间连接动作构成的有向连通图。
该图也可以是循环的，即起始界面与结束界面相同，
例如用户从某一界面跳转到其他界面后又返回初始界面的场景。
操作在每个界面的组件元素之上执行。
在本工作中，我们考虑如下操作空间：
点击（click）、长按（long press）、输入文本（send keys）、滚动（scroll）、滑动（swipe）、拖拽（drag and drop）以及返回（go back）。
当一个操作被执行时，可能产生以下几种结果：
（i）不发生界面跳转，
（ii）跳转到同一流程中的另一个界面，或
（iii）跳转到另一个流程。
需要注意的是，如果某个设计原型不符合我们的元模型规范，
GUIPilot 将作为工具抛出编译错误，以提示设计人员对其原型进行修正和完善。

