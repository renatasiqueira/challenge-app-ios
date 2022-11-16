//
//  CellsCollectionView.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 08/11/2022.
//

import Foundation
import UIKit

class CellsCollectionView: UICollectionViewCell {

    private var imageView: UIImageView
    var dataTask: URLSessionDataTask?

    override init(frame: CGRect) {
        imageView = .init(frame: .zero)
        super.init(frame: .zero)
        self.contentView.addSubview(imageView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpCell(url: URL) {
        dataTask = self.imageView.createDownloadDataTask(from: url)
        dataTask?.resume()
    }

    func setUpConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }

    override func prepareForReuse() {

        super.prepareForReuse()
        dataTask?.cancel()

        imageView.image = nil

    }

}
