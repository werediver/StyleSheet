import ObjectiveC

enum ObjC {

    final class Class<T: AnyObject> {

        init(_: T.Type) {}

        /// An array of the instance methods implemented by the class.
        /// Any instance methods implemented by superclasses are not included.
        private(set) lazy var methods: [Method] = Class.instanceMethods()

        func instanceMethod(named selector: Selector) -> Method? {
            return methods.first { $0.name == selector }
        }

        private static func instanceMethods() -> [Method] {
            var methods = [Method]()

            var methodCount: UInt32 = 0
            if let rawMethods = class_copyMethodList(T.self, &methodCount) {
                methods.reserveCapacity(Int(methodCount))
                for i in 0 ..< Int(methodCount) {
                    let rawMethod = rawMethods.advanced(by: i).pointee
                    methods.append(Method(rawMethod))
                }
                free(rawMethods)
            }

            return methods
        }

        final class Method {

            private let method: ObjectiveC.Method

            private(set) lazy var name: Selector = method_getName(method)
            private(set) lazy var typeEncoding: String? = method_getTypeEncoding(method).map(String.init)

            func exchange(with alternate: Method) { method_exchangeImplementations(method, alternate.method) }

            init(_ method: Method) {
                self.method = method.method
            }

            fileprivate init(_ method: ObjectiveC.Method) {
                self.method = method
            }
        }
    }
}
