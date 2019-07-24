  a && b;
  a && b || c;
  a && b || c && d;
  a && b || c && d || e; // Noncompliant {{减少此表达式中条件运算符的数量 （当前为4）  （最大允许数量为3）。}} [[effortToFix=1]]
  a && b || c && d || e && f; // Noncompliant [[effortToFix=2]]
//^^^^^^^^^^^^^^^^^^^^^^^^^^
if (a && b || c && d || e && f) {}; // Noncompliant
if (a && (b || c) && (d || e && f)) {}; // Noncompliant
if (a && b || c) {};
if (!(a && b || c && d)) {};
if (!(a && b || c && d || e)) {}; // Noncompliant
foo(a && b) && foo(a || b) && foo(a && b);
