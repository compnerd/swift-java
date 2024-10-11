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

import JavaKit
import Java2SwiftLib
import JavaKitVM
import XCTest // NOTE: Workaround for https://github.com/swiftlang/swift-java/issues/43

/// Handy reference to the JVM abstraction.
var jvm: JavaVirtualMachine {
  get throws {
    try .shared()
  }
}

class Java2SwiftTests: XCTestCase {
  func testJavaLangObjectMapping() async throws {
    try assertTranslatedClass(
      JavaObject.self,
      swiftTypeName: "MyJavaObject",
      expectedChunks: [
        "import JavaKit",
        """
        @JavaClass("java.lang.Object")
        public struct MyJavaObject {
        """,
        """
          @JavaMethod
          public func toString() -> String
        """,
        """
          @JavaMethod
          public func wait() throws
        """
      ]
    )
  }
}

/// Translate a Java class and assert that the translated output contains
/// each of the expected "chunks" of text.
func assertTranslatedClass<JavaClassType: AnyJavaObject>(
  _ javaType: JavaClassType.Type,
  swiftTypeName: String,
  translatedClasses: [
    String: (swiftType: String, swiftModule: String?, isOptional: Bool)
  ] = JavaTranslator.defaultTranslatedClasses,
  expectedChunks: [String],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let environment = try jvm.environment()
  let translator = JavaTranslator(
    swiftModuleName: "SwiftModule",
    environment: environment
  )

  translator.translatedClasses = translatedClasses
  translator.translatedClasses[javaType.fullJavaClassName] = (swiftTypeName, nil, true)

  translator.startNewFile()
  let translatedDecls = translator.translateClass(
    try JavaClass<JavaObject>(
      javaThis: javaType.getJNIClass(in: environment),
      environment: environment)
  )
  let importDecls = translator.getImportDecls()

  let swiftFileText = """
    // Auto-generated by Java-to-Swift wrapper generator.
    \(importDecls.map { $0.description }.joined())
    \(translatedDecls.map { $0.description }.joined(separator: "\n"))
    """

  for expectedChunk in expectedChunks {
    if swiftFileText.contains(expectedChunk) {
      continue
    }

    XCTFail("Expected chunk '\(expectedChunk)' not found in '\(swiftFileText)'", file: file, line: line)
  }
}
