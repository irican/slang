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
import org.sonarsource.slang.api.MatchTree;
import org.sonarsource.slang.api.Token;
import org.sonarsource.slang.checks.api.InitContext;
import org.sonarsource.slang.checks.api.SlangCheck;

@Rule(key = "S131")
public class MatchWithoutElseCheck implements SlangCheck {

  @Override
  public void initialize(InitContext init) {
    init.register(MatchTree.class, (ctx, tree) -> {
      if (tree.cases().stream().noneMatch(matchCase -> matchCase.expression() == null)) {
        Token keyword = tree.keyword();
        String message = String.format("在此 \"%s\" 语句中加入一个默认（default）子句。", keyword.text());
        ctx.reportIssue(keyword, message);
      }
    });
  }

}
