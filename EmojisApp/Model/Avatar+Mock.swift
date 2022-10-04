//
//  MockAvatar.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 04/10/2022.
//

import Foundation

class MockedAvatarStorage: AvatarStorage {
    weak var delegate: AvatarStorageDelegate?
    var avatars: [Avatar] = []
    
}
