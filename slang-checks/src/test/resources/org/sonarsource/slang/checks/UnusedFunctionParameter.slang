void fun fooBar() {}  // OK

void fun fooBar(int a) {}  // Noncompliant {{删除此未使用的函数参数 "a"。}}
//                  ^

void fun fooBar(int a, int b) {}  // Noncompliant {{删除这些未使用的函数参数。}}
//                  ^      ^<  {{删除此未使用的方法参数 "b"。}}
//                  ^@-1<      {{删除此未使用的方法参数 "a"。}}

void fun fooBar(int a, int b) {   // Noncompliant {{删除此未使用的函数参数 "b"。}}
//                         ^
  x = a;
}

void fun fooBar(int a, int b) {   // Noncompliant {{删除此未使用的函数参数 "a"。}}
//                  ^
  match (b) { }
}

void fun fooBar(int a, b) {   // OK
  x = a;
  match (b) { }
}

id fun fooBar(int id) {} // OK - issue is not raised here as 'id' is found in method header.
                         // This is done to avoid FP in languages that can use parameters in method headers (ex: in initializers for kotlin)

class A {

  private fun constructor(int a) { // Compliant to prevent FP on constructor
  }

  void fun fooBar() {}

  void fun fooBar(int a, int b) { // OK - method is not private and could potentially be overridden
    x = a;
  }

  private void fun fooBar(int a, int b) { // Noncompliant
    x = a;
  }

  private override void fun fooBar(int a, int b) { // OK - even though it is private, it is an override method
    x = a;
  }

}

void fun main(int a) {} // OK - "main" functions are ignored
int fun Main(int a) {} // OK - "main" functions are ignored
fun foo(p1, native [] {} p2) {p1} // OK - parameter with modifier are ignored