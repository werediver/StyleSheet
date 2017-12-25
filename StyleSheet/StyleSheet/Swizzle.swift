func swizzle<T: AnyObject>(instanceOf _: T.Type, selectors selector1: Selector, _ selector2: Selector) throws {
    let cls = ObjC.Class(T.self)

    guard
        let method1 = cls.instanceMethod(named: selector1),
        let method2 = cls.instanceMethod(named: selector2)
    else { throw SwizzleFailure.methodNotFound }

    guard
        method1.typeEncoding == method2.typeEncoding
    else { throw SwizzleFailure.typeSignatureDoesNotMatch }

    method1.exchange(with: method2)
}

enum SwizzleFailure: Error {
    case methodNotFound
    case typeSignatureDoesNotMatch
}
