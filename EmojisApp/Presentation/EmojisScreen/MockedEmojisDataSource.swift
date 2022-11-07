//
//  MockedEmojisDataSource.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 07/11/2022.
//

import Foundation
import UIKit

class MockedDataSource: NSObject, UICollectionViewDataSource {
    var mockedEmojis: MockedEmojiStorage = .init()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return mockedEmojis.emojis.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.setUpCell(url: mockedEmojis.emojis[indexPath.row].emojiUrl)

        return cell
    }

}
