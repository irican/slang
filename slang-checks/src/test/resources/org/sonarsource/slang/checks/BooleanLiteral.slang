x == true;                                   // OK - as for now without semantic we do not know if x is nullable or a primitive
x == false;                                  // OK - as for now without semantic we do not know if x is nullable or a primitive
x != true;                                   // OK - as for now without semantic we do not know if x is nullable or a primitive
x != false;                                  // OK - as for now without semantic we do not know if x is nullable or a primitive
true == x;                                   // OK - as for now without semantic we do not know if x is nullable or a primitive
false == x;                                  // OK - as for now without semantic we do not know if x is nullable or a primitive
true != x;                                   // OK - as for now without semantic we do not know if x is nullable or a primitive
false != x;                                  // OK - as for now without semantic we do not know if x is nullable or a primitive
!true;                                       // Noncompliant {{删除不必要的布尔文字。}}
+true;
!false;                                      // Noncompliant {{删除不必要的布尔文字。}}
false && foo;                                // Noncompliant {{删除不必要的布尔文字。}}
x || true;                                   // Noncompliant {{删除不必要的布尔文字。}}
x || ((true));                               // Noncompliant {{删除不必要的布尔文字。}}

!x;                                          // OK
x || foo;                                    // OK
x == y;                                      // OK
z != x;                                      // OK

x = if (foo) y else false;                   // Noncompliant {{删除不必要的布尔文字。}}
x = if (foo) y else true;                    // Noncompliant {{删除不必要的布尔文字。}}
x = if (foo) true else y;                    // Noncompliant {{删除不必要的布尔文字。}}
x = if (foo) false else y;                   // Noncompliant {{删除不必要的布尔文字。}}
x = if (foo) false;                          // Noncompliant {{删除不必要的布尔文字。}}

x = if (foo) x else y;                       // OK

x = if (foo) false
    else { doSomething(); y };

x = if (foo) false
    else if (bar) { doSomething(); y }
    else true;

x = if (foo) { doSomething(); y }
    else true;

x = if (a) true // Noncompliant
    else false;

x =   if (a) true
      else if (b) false
      else        false;

x =   if (b)
        if (a) true // Noncompliant
        else   false;
