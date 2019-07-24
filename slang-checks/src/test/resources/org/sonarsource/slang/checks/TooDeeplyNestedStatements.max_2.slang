  if (true) {}
//^^>
  else if (true) {}
  else if (true) {
    if (true) { // Compliant
//  ^^>
      if (true) {// Noncompliant {{重构此代码使得其控制流语句嵌套的深度不会超过2。}}
//    ^^
        if (true) {
        };
      };
    };
  };