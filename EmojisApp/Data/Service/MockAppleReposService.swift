//
//  MockAppleReposService.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 15/11/2022.
//

import Foundation

class MockAppleReposService: AppleReposService {

    var mockedAppleRepos: MockedAppleReposStorage = .init()

    func getRepos(itemsPerPage: Int, pageNumber: Int,
                  _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void) {

        var currentAppleRepos: [AppleRepos] = []
        let endIndex: Int = itemsPerPage * pageNumber
        let startIndex: Int = endIndex - itemsPerPage

        for index in startIndex...endIndex - 1 where index < mockedAppleRepos.appleRepos.count {
            currentAppleRepos.append(mockedAppleRepos.appleRepos[index])
        }

        resultHandler(.success(currentAppleRepos))
    }

}
