//
//  AvatarView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 11/11/2022.
//

import Foundation
import UIKit
//
import RxCocoa
import RxSwift

class AvatarListView: BaseGenericView {
    var collectionView: UICollectionView

    // var viewModel: AvatarViewModel?

   required init() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)

        super.init()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createViews() {
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()

//        collectionView.backgroundColor = .none
    }

    private func setUpViews() {
        collectionView.register(CellsTableView.self, forCellWithReuseIdentifier: CellsTableView.reuseCellIdentifier)
    }

    private func addViewsToSuperview() {
        addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

    }

}
