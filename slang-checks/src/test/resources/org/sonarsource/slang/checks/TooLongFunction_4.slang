fun f1() { // Noncompliant {{此函数有5行代码，超过了允许的最大行数4。请将其拆分为更小的函数。}}
  a;
  a;
  a;
}

fun f1() {
  a;

  a;
}
