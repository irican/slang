void fun FOOBAR() {}  // OK
void fun foo() {} // Noncompliant {{重命名函数 "foo" 使其符合正则表达式 ^[A-Z]*$}}
//       ^^^

class A {
  fun constructor() {} // Compliant, constructor
}
