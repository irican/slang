fun f1() {
  a; a;
}

fun f1() { // Noncompliant {{此函数有4行代码，超过了允许的最大行数3。请将其拆分为更小的函数。}}
//  ^^
  a;
  a;
}

fun f1() {

  a;
}

fun f1() {
  // comment
  a;
}
