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

import org.sonarsource.slang.api.MatchTree;
import org.sonarsource.slang.api.Token;
import org.sonarsource.slang.checks.api.InitContext;
import org.sonarsource.slang.checks.api.SecondaryLocation;
import org.sonarsource.slang.checks.api.SlangCheck;
import java.util.List;
import java.util.stream.Collectors;
import org.sonar.check.Rule;
import org.sonar.check.RuleProperty;

@Rule(key = "S1479")
public class TooManyCasesCheck implements SlangCheck {

  private static final int DEFAULT_MAX = 30;

  @RuleProperty(
    key = "maximum",
    description = "最大分支数",
    defaultValue = "" + DEFAULT_MAX)
  public int maximum = DEFAULT_MAX;

  @Override
  public void initialize(InitContext init) {
    init.register(MatchTree.class, (ctx, tree) -> {
      int numberOfCases = tree.cases().size();
      if (numberOfCases > maximum) {
        Token matchKeyword = tree.keyword();
        String message = String.format(
          "将%s的分支数从%s减少到不超过%s。",
          matchKeyword.text(),
          numberOfCases,
          maximum);
        List<SecondaryLocation> secondaryLocations = tree.cases().stream()
          .map(matchCase -> new SecondaryLocation(matchCase.rangeToHighlight(), null))
          .collect(Collectors.toList());
        ctx.reportIssue(matchKeyword, message, secondaryLocations);
      }
    });
  }

}
