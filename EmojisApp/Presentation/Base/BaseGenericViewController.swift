//
//  BaseGenericViewController.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 27/10/2022.
//

import Foundation
import UIKit
//
import RxSwift

class BaseGenericViewController<View: BaseGenericView>: UIViewController {

    let disposeBag = DisposeBag()

    var genericView: View {

        // swiftlint:disable:next force_cast
        view as! View

    }

    override func loadView() {
        view = View()
    }
}
