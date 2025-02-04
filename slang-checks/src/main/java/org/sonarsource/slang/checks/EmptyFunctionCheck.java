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

import org.sonar.check.Rule;
import org.sonarsource.slang.api.BlockTree;
import org.sonarsource.slang.api.FunctionDeclarationTree;
import org.sonarsource.slang.api.TreeMetaData;
import org.sonarsource.slang.checks.api.InitContext;
import org.sonarsource.slang.checks.api.SlangCheck;

@Rule(key = "S1186")
public class EmptyFunctionCheck implements SlangCheck {

  @Override
  public void initialize(InitContext init) {
    init.register(FunctionDeclarationTree.class, (ctx, tree) -> {
      BlockTree body = tree.body();
      if (!tree.isConstructor() && body != null && body.statementOrExpressions().isEmpty() && !hasComment(body, ctx.parent().metaData())) {
        ctx.reportIssue(body, "添加嵌套注释解释为什么此函数为空，或者完成实现。");
      }
    });
  }

  private static boolean hasComment(BlockTree body, TreeMetaData parentMetaData) {
    if (!body.metaData().commentsInside().isEmpty()) {
      return true;
    }

    int emptyBodyEndLine = body.textRange().end().line();
    return parentMetaData.commentsInside().stream()
      .anyMatch(comment -> comment.contentRange().start().line() == emptyBodyEndLine);
  }

}
