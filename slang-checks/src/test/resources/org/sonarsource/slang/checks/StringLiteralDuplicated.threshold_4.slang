  "string literal1";  "string literal1";  "string literal1"; // Compliant - only appears 3 times which is less than the custom threshold of 4
  "string literal2"; // Noncompliant {{定义常量而不是复制文本 "string literal2" 4 次。}}
//^^^^^^^^^^^^^^^^^
   "string literal2";  "string literal2";  "string literal2";
//<^^^^^^^^^^^^^^^^^  <^^^^^^^^^^^^^^^^^  <^^^^^^^^^^^^^^^^^
