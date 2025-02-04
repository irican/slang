/*
 * SonarQube Go Plugin
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
package org.sonar.go.converter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import org.sonar.api.utils.log.Logger;
import org.sonar.api.utils.log.Loggers;


class ExternalProcessStreamConsumer {

  private static final Logger LOG = Loggers.get(ExternalProcessStreamConsumer.class);
  private ExecutorService executorService;

  public ExternalProcessStreamConsumer() {
    executorService = Executors.newCachedThreadPool(r -> {
      Thread thread = new Thread(r);
      thread.setName("stream-consumer");
      thread.setDaemon(true);
      return thread;
    });
  }

  public final void consumeStream(InputStream inputStream, StreamConsumer streamConsumer) {
    executorService.submit(() -> {
      try (BufferedReader errorReader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
        readErrors(errorReader, streamConsumer);
      } catch (IOException e) {
        LOG.error("Error while reading stream", e);
      }
    });
  }

  protected void readErrors(BufferedReader errorReader, StreamConsumer streamConsumer) {
    errorReader.lines().forEach(streamConsumer::consumeLine);
    streamConsumer.finished();
  }

  interface StreamConsumer {

    void consumeLine(String line);

    default void finished() {

    }
  }
}
