  match (x) {
    1 -> 'a';
    2 -> 'b';
    3 -> 'c';
  };

  match (x) { // Noncompliant {{将match的分支数从4减少到不超过3。}}
    1 -> 'a';
    2 -> 'b';
    3 -> 'c';
    4 -> 'd';
  };

  match (x) {
    1 -> 'a';
    2 -> 'b';
    else -> 'c';
  };

  match (x) { // Noncompliant
//^^^^^
    1 -> 'a';
//  ^^^^<
    2 -> 'b';
//  ^^^^<
    3 -> 'c';
//  ^^^^<
    else -> 'd';
//  ^^^^^^^<
};
