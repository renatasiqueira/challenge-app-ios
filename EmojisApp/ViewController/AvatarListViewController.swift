//
//  AvatarListViewController.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 26/09/2022.
//

import UIKit

class AvatarListViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        title = "Avatar List"

        // Do any additional setup after loading the view.
    }
    
}
