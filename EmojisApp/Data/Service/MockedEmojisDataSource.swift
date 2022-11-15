//
//  MockedEmojisDataSource.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 07/11/2022.
//

import Foundation
import UIKit

class MockedDataSource: NSObject, UICollectionViewDataSource {
    var mockedEmojis: MockedEmojiService = .init()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return mockedEmojis.emojis.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CellsCollectionView = collectionView.dequeueReusableCell(for: indexPath)

        let url = mockedEmojis.emojis[indexPath.row].emojiUrl

        cell.setUpCell(url: url)

        return cell
    }

}
