match (x) {
    1 -> { // Noncompliant {{将此case子句的行数从 4 减少到最多 3， 例如，通过将代码提取到方法中。}}
//  ^^^^
        a = 1;
        print(a);
    };
    else -> b;
};

match (x) {
    1 -> foo();
    else -> { // Noncompliant {{将此case子句的行数从 4 减少到最多 3， 例如，通过将代码提取到方法中。}}
//  ^^^^^^^
        a = 1;
        print(a);
    };
};

match (x) {
    1 -> foo(); // OK
    // comments should be ignored
    // another comment

    else -> b;
};
