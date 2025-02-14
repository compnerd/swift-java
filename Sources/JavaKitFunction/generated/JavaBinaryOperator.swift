// Auto-generated by Java-to-Swift wrapper generator.
import JavaKit
import JavaRuntime

@JavaInterface(
  "java.util.function.BinaryOperator",
  extends: JavaBiFunction<JavaObject, JavaObject, JavaObject>.self)
public struct JavaBinaryOperator<T: AnyJavaObject> {
  @JavaMethod
  public func apply(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject?

  @JavaMethod
  public func andThen(_ arg0: JavaFunction<JavaObject, JavaObject>?) -> JavaBiFunction<
    JavaObject, JavaObject, JavaObject
  >?
}
