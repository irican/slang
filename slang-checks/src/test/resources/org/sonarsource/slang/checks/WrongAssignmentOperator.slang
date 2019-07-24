target =-num; // Noncompliant {{要表达的意思是 "-=" 吗？}}
//     ^^
target =
        -num;
target = -num; // Compliant intent to assign inverse value of num is clear
target =--num;

target += num;
target =+ num; // Noncompliant {{要表达的意思是 "+=" 吗？}}
//     ^^
target =
        + num;
target =
        +num;
target = +num;
target =++num;
target=+num; // Compliant - no spaces between variable, operator and expression

a = b != c;
a = b =! c; // Noncompliant {{要表达的意思是 "!=" 吗？}} [[sc=11;ec=13]]
a = b =!! c; // Noncompliant
a = b = !c;
a =! c; // Noncompliant {{在 "=" 和 "!" 之间加入空格以避免混淆。}}
a = ! c;
a = !c;
a =
   !c;
