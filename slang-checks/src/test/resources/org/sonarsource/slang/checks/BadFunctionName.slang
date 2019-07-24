void fun fooBar() {}  // OK
fun () {}             // OK
void fun foo_bar() {} // Noncompliant {{重命名函数 "foo_bar" 使其符合正则表达式 ^[a-z][a-zA-Z0-9]*$}}
//       ^^^^^^^
