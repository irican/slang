fun testReturn() {
  return 42; // Noncompliant {{重构这段代码，使得在此 "return" 之后没有任何死代码。}}
//^^^^^^^^^
  42;
}

fun lastReturn() {
  42;
  return 42;
}

fun testBreak() {
  while (cond) {
    break; // Noncompliant {{重构这段代码，使得在此 "break" 之后没有任何死代码。}}
//  ^^^^^
    42;
    42;
  }
}

fun testContinue() {
  while (cond) {
    continue; // Noncompliant {{重构这段代码，使得在此 "continue" 之后没有任何死代码。}}
//  ^^^^^^^^
    42;
  }
}

fun testContinueWithLabel() {
  while (cond) {
    continue myLabel; // Noncompliant {{重构这段代码，使得在此 "continue" 之后没有任何死代码。}}
//  ^^^^^^^^^^^^^^^^
    42;
  }
}

fun empty() {
}

fun fnRequiresCfg() {
  if (cond) {
    return;
  } else {
    return;
  };

  42;
}

fun testThrow() {
  throw 42; // Noncompliant {{重构这段代码，使得在此 "throw" 之后没有任何死代码。}}
  42;
}
