  x == 1;
  1 == 1; // Noncompliant {{纠正这个运算符两边的相同子表达式其中的一个}}
  1 == (1); // Noncompliant {{纠正这个运算符两边的相同子表达式其中的一个}}
  (1 + 2) == 1 + 2; // Noncompliant
  (1 + 2) == ((1 + 2)); // Noncompliant
  (1 + 2) == ((1 + 2 + 3));
  x
//^>
    == x; // Noncompliant
//     ^
  1 == 2;
  x = x;
  x + x;
  x * x;
  x <= x; // Noncompliant
  _x <= _x; // Noncompliant
  x_ <= x_; // Noncompliant
  _x <= x_;
  x <= _;
  _ <= y;
  _ <= _;
