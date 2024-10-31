// Auto-generated by Java-to-Swift wrapper generator.
import JavaKit
import JavaRuntime

@JavaClass("java.util.TreeMap", extends: JavaObject.self)
public struct TreeMap<K: AnyJavaObject, V: AnyJavaObject> {
  @JavaMethod
  public init(environment: JNIEnvironment? = nil)

  @JavaMethod
  public func remove(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func size() -> Int32

  @JavaMethod
  public func get(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func put(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!

  @JavaMethod
  public func values() -> JavaCollection<JavaObject>!

  @JavaMethod
  public func clone() -> JavaObject!

  @JavaMethod
  public func clear()

  @JavaMethod
  public func replace(_ arg0: JavaObject?, _ arg1: JavaObject?, _ arg2: JavaObject?) -> Bool

  @JavaMethod
  public func replace(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!

  @JavaMethod
  public func putIfAbsent(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!

  @JavaMethod
  public func containsKey(_ arg0: JavaObject?) -> Bool

  @JavaMethod
  public func keySet() -> JavaSet<JavaObject>!

  @JavaMethod
  public func containsValue(_ arg0: JavaObject?) -> Bool

  @JavaMethod
  public func firstKey() -> JavaObject!

  @JavaMethod
  public func putFirst(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!

  @JavaMethod
  public func putLast(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!

  @JavaMethod
  public func lowerKey(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func floorKey(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func ceilingKey(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func higherKey(_ arg0: JavaObject?) -> JavaObject!

  @JavaMethod
  public func lastKey() -> JavaObject!

  @JavaMethod
  public func equals(_ arg0: JavaObject?) -> Bool

  @JavaMethod
  public func toString() -> String

  @JavaMethod
  public func hashCode() -> Int32

  @JavaMethod
  public func isEmpty() -> Bool

  @JavaMethod
  public func getClass() -> JavaClass<JavaObject>!

  @JavaMethod
  public func notify()

  @JavaMethod
  public func notifyAll()

  @JavaMethod
  public func wait(_ arg0: Int64) throws

  @JavaMethod
  public func wait(_ arg0: Int64, _ arg1: Int32) throws

  @JavaMethod
  public func wait() throws

  @JavaMethod
  public func remove(_ arg0: JavaObject?, _ arg1: JavaObject?) -> Bool

  @JavaMethod
  public func getOrDefault(_ arg0: JavaObject?, _ arg1: JavaObject?) -> JavaObject!
}
