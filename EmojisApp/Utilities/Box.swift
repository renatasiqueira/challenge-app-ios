import Foundation


final class Box {
    typealias Listiner = (T) -> Void
    var listiner: Listiner?

    var value: T {
        didSet {
            listiner?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listiner: Listiner?) {
        self.listiner = listiner
        listiner?(value)
    }
}
