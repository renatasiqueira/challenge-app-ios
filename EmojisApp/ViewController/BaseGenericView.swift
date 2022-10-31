//
//  BaseGenericView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 27/10/2022.
//

import Foundation
import UIKit

class BaseGenericView: UIView {
    required init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

    func setupView() {}
}
