int fun foo(p1, p2, p3) {}
int fun foo(p1, p2, p3, p4, p5, p6, p7, p8) {} // Noncompliant {{此函数有8个参数， 超过了允许的最大数量3。}}
//      ^^^             ^^< ^^< ^^< ^^< ^^<
