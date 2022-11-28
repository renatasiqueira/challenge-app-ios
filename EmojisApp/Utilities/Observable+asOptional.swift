//
//  Observable+asOptional.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 28/11/2022.
//

import Foundation
import RxSwift

extension Observable {
    typealias OptionalElement = Optional<Element>

    func asOptional() -> Observable<OptionalElement> {
        return map ({ element -> OptionalElement in return element })
    }
}
