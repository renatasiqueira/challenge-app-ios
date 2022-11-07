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

    override init(frame: CGRect) {
        super.init(frame: .zero)
        createViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {}
}
