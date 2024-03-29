---
title: "C++ Primer"
date: 2018-11-13T17:59:25+08:00
draft: true
markup: "pandoc"
---

## Getting Started

### Writing a Simple C_++ Program

`main` 函数必须返回 `int`。

`std::endl` 有 2 个效果：
- 结束当前行
- flush buffer

## The Basics

### Variables and Basic Types

`0` 开头的整数解释为八进制。

`decltype`: declared type。

`constexpr` 表示编译时常量，`const` 表示运行时常量。

### Strings, Vectors and Arrays

`it->mem` 等价于 `(*it).mem`。

### Expressions

- `C` 里，`lvalue` 可以放在赋值表达式的左侧，`rvalue` 不行；
- `C++` 里，`lvalue` 是对象自己（内存里的位置）；`rvalue` 指对象的值；
- 可以用 `lvalue` 替代 `rvalue`；反之不行。

`a ${op}= b` 等价于 `a = a ${op} b`。
