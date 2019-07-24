if (x == 0) {
  x = 42;
};

if (x == 0) {
  x = 42;
} else {
  x = 43;
};

if (x == 0) {
  doSomething();
} else if (x == 1) { // Noncompliant {{加入遗漏的 "else" 子句。}}
//^^^^^^^
  doSomethingElse();
};

if (x == 0) {
  doSomething();
} else if (x == 1) {
  doSomethingElse();
} else {
  print("Something");
};
