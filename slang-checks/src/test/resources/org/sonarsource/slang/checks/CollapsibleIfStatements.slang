if (a) {
  print(a);
  print(b);
};

if (a) {
} else if (b) {
  if (c) {
  }
} else {
};

if (a)
  if (b) {
  } else {
  };

   if (a) { // Noncompliant {{将此 "if" 语句合并到嵌套语句中。}}
// ^^
     if (b) {}
//   ^^<
    };

if (a) {
} else {
    if (c) { // Noncompliant {{将此 "if" 语句合并到嵌套语句中。}}
      if (b) {}
    }
};

if (a) // Noncompliant {{将此 "if" 语句合并到嵌套语句中。}}
 if (b)
    print();


if (a) { // Noncompliant
  if (b) {
  }
};

if (a) { // Noncompliant
  if (b) { // Noncompliant
    if (c) {
    }
  }
};

if (a) { // Noncompliant
  if (b) {
    if (c) {
    } else {
    }
  }
};

if (a) // Noncompliant
  if (b) {
  };

