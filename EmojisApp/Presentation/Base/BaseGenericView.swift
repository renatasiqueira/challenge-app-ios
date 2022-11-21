//
//  BaseGenericView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 27/10/2022.
//

import Foundation
import UIKit
import RxSwift

class BaseGenericView: UIView {

    var disposeBag = DisposeBag()

    required init() {
        super.init(frame: .zero)
        createViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

    func createViews() {}
}
