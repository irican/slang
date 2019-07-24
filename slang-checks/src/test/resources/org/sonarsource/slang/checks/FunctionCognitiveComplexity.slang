fun ok() {
  if (x) {
    if (y) {
      foo();
    };
  };
  if (z) {
    foo();
  };
}

fun ko() { // Noncompliant {{重构此方法以将其认知复杂度从5降低到被允许的4。}} [[effortToFix=1]]
//  ^^
  if (x) {
//^^< {{+1}}
    if (y) {
//  ^^< {{+2（包含1层嵌套）}}
      foo();
    };
    if (z) {
//  ^^< {{+2（包含1层嵌套）}}
      foo();
    };
  };
}

fun logical_operators() { // Noncompliant
//  ^^^^^^^^^^^^^^^^^
  if (a
//^^<
     && b && c
//   ^^<
     || d || e
//   ^^<
     && f
//   ^^<
     || g) {
//   ^^<
    foo();
  }
}

fun nesting_anonymous() { // Noncompliant
  fun() {
    a && b || c && d || e && f;
  }
}

