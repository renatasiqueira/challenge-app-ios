//
//  BaseGenericViewController.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 27/10/2022.
//

import Foundation
import UIKit


class BaseGenericViewController<View: BaseGenericView>: UIViewController {
    
    var genericView: View {
        view as! View
    }

    override func loadView() {
        view = View()
    }
}
