  a && b;
  a && b || c;
  a && b || c && d; // Noncompliant {{减少此表达式中条件运算符的数量 （当前为3）  （最大允许数量为2）。}}
