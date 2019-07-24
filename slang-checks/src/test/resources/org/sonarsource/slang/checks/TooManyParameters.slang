int fun foo(p1, p2, p3, p4, p5, p6, p7) {}
int fun (p1, p2, p3, p4, p5, p6, p7) {}

int fun (p1, p2, p3, p4, p5, p6, p7, p8) {} // Noncompliant
int fun foo(p1, p2, p3, p4, p5, p6, p7, p8) {} // Noncompliant {{此函数有8个参数， 超过了允许的最大数量7。}}
//      ^^^                             ^^<

int fun foo(int p1, int p2, int p3, int p4, int p5, int p6, int p7) {}
int fun foo(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8) {} // Noncompliant

override int fun foo(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8) {} // OK
private int fun foo(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8) {} // Noncompliant
native [] {} int fun foo(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8) {} // Noncompliant

class A {
  fun constructor(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8) {} // Compliant, constructor
}
