  match (x) { }; // Noncompliant {{在此 "match" 语句中加入一个默认（default）子句。}}
//^^^^^
  match (x) { 1 -> 1; }; // Noncompliant {{在此 "match" 语句中加入一个默认（default）子句。}}
  match (x) { 1 -> 1; else -> 2; };
  match (x) { else -> 2; 1 -> 1; };

  int fun foo() {
    match (x) { 1 -> 1; }; // Noncompliant
    match (x) { 1 -> 1; else -> 2; };

    int val value = match (x) { 1 -> 1; }; // Noncompliant
    value = if (y) { match (x) { 1 -> 1; }; } else 2; // Noncompliant

    while (y) {
      match (x) { else -> 2; };
      match (x) { 1 -> 1; }; // Noncompliant
    };

    native[] { [
     match (x) { // Noncompliant
      1 -> { match (y) { // Noncompliant
          1 -> 1;
          2 -> {
            var c;
            match (z) { // Noncompliant
              1 -> { c = 2; };
            };
          };
          3 -> {
            var variable;
            match (c) {
              1 -> variable = 1;
              else -> variable = 2;
            };
            variable;
          };
        };
      };
    }
    ] }
  }
