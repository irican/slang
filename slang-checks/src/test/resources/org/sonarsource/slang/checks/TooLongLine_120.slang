int fun (p1, p2) {}

// short comment

// Noncompliant@+1 {{拆分此拥有124字符的代码行（超过了允许的字符数120）。}}
int fun fooVeryLongName(fooVeryLongName1, fooVeryLongName2, fooVeryLongName3, fooVeryLongName4, fooVeryLongName5, p6, p7) {}

// Noncompliant@+1 {{拆分此拥有125字符的代码行（超过了允许的字符数120）。}}
// this is a very comment that should raise an issue when its length is greater that 120 characters that is the default value