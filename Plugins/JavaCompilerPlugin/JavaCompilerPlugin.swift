//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift.org project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of Swift.org project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
import PackagePlugin

@main
struct JavaCompilerBuildToolPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
    guard let sourceModule = target.sourceModule else { return [] }

    // Collect all of the Java source files within this target's sources.
    let javaFiles = sourceModule.sourceFiles.map { $0.url }.filter {
      $0.pathExtension == "java"
    }
    if javaFiles.isEmpty {
      return []
    }

    // Note: Target doesn't have a directoryURL counterpart to directory,
    // so we cannot eliminate this deprecation warning.
    let sourceDir = target.directory.string

    // The class files themselves will be generated into the build directory
    // for this target.
    let classFiles = javaFiles.map { sourceFileURL in
      let sourceFilePath = sourceFileURL.path
      guard sourceFilePath.starts(with: sourceDir) else {
        fatalError("Could not get relative path for source file \(sourceFilePath)")
      }

      return URL(
        filePath: context.pluginWorkDirectoryURL.path
      ).appending(path: "Java")
       .appending(path: String(sourceFilePath.dropFirst(sourceDir.count)))
       .deletingPathExtension()
       .appendingPathExtension("class")
    }

    let javaHome = URL(filePath: findJavaHome())
    let javaClassFileURL = context.pluginWorkDirectoryURL
      .appending(path: "Java")
    return [
      .buildCommand(
        displayName: "Compiling \(javaFiles.count) Java files for target \(sourceModule.name) to \(javaClassFileURL)",
        executable: javaHome
          .appending(path: "bin")
          .appending(path: "javac"),
        arguments: javaFiles.map { $0.path(percentEncoded: false) } + [
          "-d", javaClassFileURL.path(),
          "-parameters", // keep parameter names, which allows us to emit them in generated Swift decls
        ],
        inputFiles: javaFiles,
        outputFiles: classFiles
      )
    ]
  }
}

// Note: the JAVA_HOME environment variable must be set to point to where
// Java is installed, e.g.,
//   Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home.
func findJavaHome() -> String {
  if let home = ProcessInfo.processInfo.environment["JAVA_HOME"] {
    return home
  }

  // This is a workaround for envs (some IDEs) which have trouble with
  // picking up env variables during the build process
  let path = "\(FileManager.default.homeDirectoryForCurrentUser.path()).java_home"
  if let home = try? String(contentsOfFile: path, encoding: .utf8) {
    if let lastChar = home.last, lastChar.isNewline {
      return String(home.dropLast())
    }

    return home
  }

  fatalError("Please set the JAVA_HOME environment variable to point to where Java is installed.")
}
