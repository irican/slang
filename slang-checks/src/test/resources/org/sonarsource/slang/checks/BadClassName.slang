class myClass{} // Noncompliant {{重命名类 "myClass" 使其符合正则表达式 ^[A-Z][a-zA-Z0-9]*$。}}
//    ^^^^^^^

class My_Class{} // Noncompliant {{重命名类 "My_Class" 使其符合正则表达式 ^[A-Z][a-zA-Z0-9]*$。}}

class my_class{} // Noncompliant {{重命名类 "my_class" 使其符合正则表达式 ^[A-Z][a-zA-Z0-9]*$。}}

class MyClass{} // Compliant

class MyClassC{} // Compliant

class MyClass${} // Noncompliant {{重命名类 "MyClass$" 使其符合正则表达式 ^[A-Z][a-zA-Z0-9]*$。}}
