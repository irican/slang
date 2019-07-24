int var global;       // Compliant

void fun fooBar() {
    int val a = 0;    // Compliant

    int val b;        // Noncompliant {{删除此未使用的 "b" 局部变量。}}
    //      ^

    int var c;        // Noncompliant {{删除此未使用的 "c" 局部变量。}}
    //      ^

    int var d;        // Compliant
    d = 0;

    int var e;        // Compliant
    e = d + a;
}
