//
//  EmojisView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 07/11/2022.
//

import Foundation
import UIKit

class EmojisView: BaseGenericView {
    var collectionView: UICollectionView

    required init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }

    override func createViews() {
        setUpViews()
        collectionView.frame = bounds
        addViewToSuperView()
        setUpConstraints()
    }

    private func setUpViews() {
        collectionView.register(CellsCollectionView.self,
                                forCellWithReuseIdentifier: CellsCollectionView.reuseCellIdentifier)

        collectionView.delegate = self

    }

    private func addViewToSuperView() {
        addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension EmojisView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
        let widthPerItem = collectionView.frame.width / 5 - layout.minimumInteritemSpacing

        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
