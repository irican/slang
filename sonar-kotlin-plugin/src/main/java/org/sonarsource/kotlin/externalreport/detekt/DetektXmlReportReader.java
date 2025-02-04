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
package org.sonarsource.kotlin.externalreport.detekt;

import java.io.IOException;
import java.io.InputStream;
import javax.annotation.Nullable;
import javax.xml.namespace.QName;
import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.Attribute;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;
import org.sonar.api.batch.fs.FilePredicates;
import org.sonar.api.batch.fs.InputFile;
import org.sonar.api.batch.sensor.SensorContext;
import org.sonar.api.batch.sensor.issue.NewExternalIssue;
import org.sonar.api.batch.sensor.issue.NewIssueLocation;
import org.sonar.api.rule.RuleKey;
import org.sonar.api.utils.log.Logger;
import org.sonar.api.utils.log.Loggers;
import org.sonarsource.analyzer.commons.ExternalRuleLoader;
import org.sonarsource.analyzer.commons.xml.SafetyFactory;

class DetektXmlReportReader {

  private static final Logger LOG = Loggers.get(DetektXmlReportReader.class);

  private static final QName CHECKSTYLE = new QName("checkstyle");
  private static final QName FILE = new QName("file");
  private static final QName ERROR = new QName("error");
  private static final QName NAME = new QName("name");
  private static final QName SOURCE = new QName("source");
  private static final QName LINE = new QName("line");
  private static final QName MESSAGE = new QName("message");

  private static final String DETEKT_PREFIX = "detekt.";

  private final SensorContext context;

  private int level = 0;

  @Nullable
  private InputFile inputFile = null;

  private DetektXmlReportReader(SensorContext context) {
    this.context = context;
  }

  static void read(SensorContext context, InputStream in) throws XMLStreamException, IOException {
    new DetektXmlReportReader(context).read(in);
  }

  private void read(InputStream in) throws XMLStreamException, IOException {
    XMLEventReader reader = SafetyFactory.createXMLInputFactory().createXMLEventReader(in);
    while (reader.hasNext()) {
      XMLEvent event = reader.nextEvent();
      if (event.isStartElement()) {
        level++;
        onElement(event.asStartElement());
      } else if (event.isEndElement()) {
        level--;
      }
    }
  }

  private void onElement(StartElement element) throws IOException {
    if (level == 1 && !CHECKSTYLE.equals(element.getName())) {
      throw new IOException("Unexpected document root '" + element.getName().getLocalPart() + "' instead of 'checkstyle'.");
    } else if (level == 2 && FILE.equals(element.getName())) {
      onFileElement(element);
    } else if (level == 3 && ERROR.equals(element.getName()) && inputFile != null) {
      onErrorElement(element);
    }
  }

  private void onFileElement(StartElement element) {
    String filePath = getAttributeValue(element, NAME);
    if (filePath.isEmpty()) {
      inputFile = null;
      return;
    }
    FilePredicates predicates = context.fileSystem().predicates();
    inputFile = context.fileSystem().inputFile(predicates.or(
      predicates.hasAbsolutePath(filePath),
      predicates.hasRelativePath(filePath)));
    if (inputFile == null) {
      LOG.warn("No input file found for {}. No detekt issues will be imported on this file.", filePath);
    }
  }

  private void onErrorElement(StartElement element) {
    String source = getAttributeValue(element, SOURCE);
    String line = getAttributeValue(element, LINE);
    String message = getAttributeValue(element, MESSAGE);
    if (!source.startsWith(DETEKT_PREFIX)) {
      LOG.debug("Unexpected rule key without '{}' suffix: '{}'", DETEKT_PREFIX, source);
      return;
    }
    if (message.isEmpty()) {
      LOG.debug("Unexpected error without message for rule: '{}'", source);
      return;
    }
    RuleKey ruleKey = RuleKey.of(DetektSensor.LINTER_KEY, source.substring(DETEKT_PREFIX.length()));
    saveIssue(ruleKey, line, message);
  }

  private void saveIssue(RuleKey ruleKey, String line, String message) {
    NewExternalIssue newExternalIssue = context.newExternalIssue();
    setRulesDefinitionProperties(newExternalIssue, ruleKey.rule());

    NewIssueLocation primaryLocation = newExternalIssue.newLocation()
      .message(message)
      .on(inputFile);

    if (!line.isEmpty()) {
      primaryLocation.at(inputFile.selectLine(Integer.parseInt(line)));
    }

    newExternalIssue
      .at(primaryLocation)
      .forRule(ruleKey)
      .save();
  }

  private static void setRulesDefinitionProperties(NewExternalIssue newExternalIssue, String ruleKey) {
    ExternalRuleLoader externalRuleLoader = DetektRulesDefinition.RULE_LOADER;
    newExternalIssue
      .type(externalRuleLoader.ruleType(ruleKey))
      .severity(externalRuleLoader.ruleSeverity(ruleKey))
      .remediationEffortMinutes(externalRuleLoader.ruleConstantDebtMinutes(ruleKey));
  }

  private static String getAttributeValue(StartElement element, QName attributeName) {
    Attribute attribute = element.getAttributeByName(attributeName);
    return attribute != null ? attribute.getValue() : "";
  }

}
