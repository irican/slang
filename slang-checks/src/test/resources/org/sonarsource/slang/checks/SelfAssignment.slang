  x = 1;
  x = x + 1;
  x += x;
  x = x; // Noncompliant {{删除或纠正这种无用的自我赋值。}}
//^^^^^
  native[] { [x] } = x; // Ex: this.x = x

  // Ex: this.x = this.x
  // Noncompliant@+1
  native[] { [x] } = native[] {
    [
      x;
    ]
  };