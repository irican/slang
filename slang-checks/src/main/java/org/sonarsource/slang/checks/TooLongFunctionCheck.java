/*
 * SonarSource SLang
 * Copyright (C) 2018-2019 SonarSource SA
 * mailto:info AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package org.sonarsource.slang.checks;

import org.sonarsource.slang.api.FunctionDeclarationTree;
import org.sonarsource.slang.checks.api.InitContext;
import org.sonarsource.slang.checks.api.SlangCheck;
import org.sonar.check.Rule;
import org.sonar.check.RuleProperty;

@Rule(key = "S138")
public class TooLongFunctionCheck implements SlangCheck {

  private static final int DEFAULT_MAX = 100;

  @RuleProperty(
    key = "max",
    description = "一个函数中允许的最大代码行数",
    defaultValue = "" + DEFAULT_MAX
  )
  public int max = DEFAULT_MAX;

  @Override
  public void initialize(InitContext init) {
    init.register(FunctionDeclarationTree.class, (ctx, tree) -> {
      int numberOfLinesOfCode = tree.metaData().linesOfCode().size();
      if (numberOfLinesOfCode > max) {
        String message = String.format(
          "此函数有%s行代码，超过了允许的最大行数%s。请将其拆分为更小的函数。",
          numberOfLinesOfCode,
          max);
        ctx.reportIssue(tree.rangeToHighlight(), message);
      }
    });
  }

}
