x = "string literal1";                           // Noncompliant {{定义常量而不是复制文本 "string literal1" 3 次。}} [[effortToFix=2]]
//  ^^^^^^^^^^^^^^^^^
x += "string literal1" + "other string literal";
//  <^^^^^^^^^^^^^^^^^
native[] { [] } = native[] {
  [
    "string literal1"
// <^^^^^^^^^^^^^^^^^
  ]
};

void fun function1(string abcde) {
  v = "string literal2" + "string literal2"     // Compliant - literal only appears twice
}
"string literal3"; "string literal3";
"string literal3${x}";                          // Compliant - string entries of string templates not considered as string literals

void fun funtcion2(int abcde) {
  if (abcde == "string literal4") {             // Noncompliant {{定义常量而不是复制文本 "string literal4" 5 次。}} [[effortToFix=4]]
//             ^^^^^^^^^^^^^^^^^
  }
}

match("string literal4") {
//   <^^^^^^^^^^^^^^^^^
    1 -> "string literal4";
//      <^^^^^^^^^^^^^^^^^
    "string literal4" -> "string literal4";
// <^^^^^^^^^^^^^^^^^   <^^^^^^^^^^^^^^^^^
};

"abcd"; "abcd"; "abcd"; "abcd";                 // Compliant - string length smaller than threshold
"string_literal5"; "string_literal5";
"string_literal5"; "string_literal5";           // Compliant - single word