match (x) {
    expression -> { // Noncompliant {{将此case子句的行数从 8 减少到最多 5， 例如，通过将代码提取到方法中。}}
 // ^^^^^^^^^^^^^
        a = 1;
        foo();
        bar();
        if (a == 1) {
          print(1);
        };
    };
    else -> b;
};

match (x) {
    1 -> foo(); // OK
    else -> b;
};
