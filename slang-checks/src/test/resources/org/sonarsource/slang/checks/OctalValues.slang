17000;

   02522; // Noncompliant {{使用十进制值代替八进制值。}}
// ^^^^^
0o2522; // Noncompliant
0O2522; // Noncompliant

"0o2522";
"02522";
"0O2522";

a + 022; // Noncompliant
//  ^^^

02; // Compliant - part of exceptions
0077; // Compliant - part of exceptions
0o077; // Compliant - part of exceptions