//
//  AppleReposView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 09/11/2022.
//

import Foundation
import UIKit

class AppleReposView: BaseGenericView {
    let tableView: UITableView

    required init() {
        tableView = .init(frame: .zero)

        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }

    override func createViews() {
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
    }

    private func setUpViews() {
        backgroundColor = .appColor(name: .suface)

        tableView.frame = bounds
        tableView.backgroundColor = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ReposNameTableViewCell.self,
                           forCellReuseIdentifier: ReposNameTableViewCell.reuseCellIdentifier)
    }

    private func addViewToSuperView() {
        addSubview(tableView)
    }
    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
}
