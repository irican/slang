match (x) { 1 -> a; else -> b; }; // OK

match (x) {
    1 -> a;
    2 -> match (y) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
    //   ^^^^^
      3 -> c;
      else -> d;
    };
    else -> b;
};

match (x) {
    1 -> a;
    2 -> {
      match (y) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
          3 -> c;
          else -> d;
       };
       match (z) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
          3 -> c;
          else -> d;
       };
    };
    else -> b;
};

match (x) {
    1 -> a;
    2 -> match (y) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
      3 -> c;
      else -> match (z) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
        4 -> d;
        else -> e;
      };
    };
    else -> b;
};

match (x) {
    1 -> a;
    2 -> b;
    else -> match (y) { // Noncompliant {{重构代码以消除此嵌套的 "match"。}}
      3 -> c;
      else -> d;
    };
};