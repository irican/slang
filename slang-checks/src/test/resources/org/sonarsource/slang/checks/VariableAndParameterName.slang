var NOT_LOCAL;

fun localVariables() {
  var localVar;
  var INVALID_LOCAL; // Noncompliant {{重命名此局部变量使其符合正则表达式 "^[_a-z][a-zA-Z0-9]*$"。}}
//    ^^^^^^^^^^^^^
  var invalid_local; // Noncompliant
}

fun parameters(param1, PARAM2, param3) { // Noncompliant {{重命名此参数使其符合正则表达式 "^[_a-z][a-zA-Z0-9]*$"。}}
//                     ^^^^^^
}

native [] {
  [
    var POSSIBLY_NOT_LOCAL;
  ]
};

class A {
  fun constructor(param1, PARAM2) { // Noncompliant
//                        ^^^^^^
  }
  fun method(param1, PARAM2) { // Noncompliant
//                   ^^^^^^
  }
}
