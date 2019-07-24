x = "pass";
"pass";
x = "password";
"password";
x = "login=a&password=";
"login=a&password=";
"login=a&password= " + value;
"login=a&password=a"; // Noncompliant
x = "login=a&password=xxx"; // Noncompliant {{"password" 在此表达式中被检测到， 请检查这个潜在的硬编码凭证。}}
//  ^^^^^^^^^^^^^^^^^^^^^^
"login=a&password=xxx"; // Noncompliant
"login=a&passwd=xxx"; // Noncompliant {{"passwd" 在此表达式中被检测到， 请检查这个潜在的硬编码凭证。}}
"login=a&pwd=xxx"; // Noncompliant {{"pwd" 在此表达式中被检测到， 请检查这个潜在的硬编码凭证。}}
  variableNameWithPasswordInIt = "xxx"; // Noncompliant {{"Password" 在此表达式中被检测到， 请检查这个潜在的硬编码凭证。}}
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^
variableNameWithPasswdInIt = "xxx"; // Noncompliant
variableNameWithPasswdInIt += "xxx"; // Noncompliant
variableNameWithPwdInIt = "xxx";  // Noncompliant {{"Pwd" 在此表达式中被检测到， 请检查这个潜在的硬编码凭证。}}
otherVariableNameWithPasswordInIt;
variableNameWithPasswordInIt = native[] { [ "NativeFunctionCall" ] };
val constValue = "login=a&password=xxx"; // Noncompliant
var passwd = "xxxx"; // Noncompliant
var okVariable = "xxxx";
