//
//  EmojiAPI.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 03/10/2022.
//

import Foundation

protocol APIProtocol {
    var url: URL { get }
    var method: Method { get }
    var headers: [String: String] { get }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case unknownError
}

func executeNetworkCall<ResultType: Decodable>(_ call: APIProtocol, _ resultHandler: @escaping (Result<ResultType, Error>) -> Void) {
    let decoder = JSONDecoder()
    var request = URLRequest(url: call.url)
    request.httpMethod = call.method.rawValue
    call.headers.forEach { (key: String, value: String) in
        request.setValue(value, forHTTPHeaderField: key)
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let result = try? decoder.decode(ResultType.self, from: data) {
                resultHandler(Result<ResultType, Error>.success(result))
            } else {
                resultHandler(Result<ResultType, Error>.failure(APIError.unknownError))
            }
        } else if let error = error {
            resultHandler(Result<ResultType, Error>.failure(error))
        }
    }

    task.resume()
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

protocol APIProtocol {
    var url: URL { get }
    var method: Method { get }
    var headers: [String: String] { get }
}

enum APIError: Error {
    case unknownError
}

enum EmojiAPI {
    case getEmojis
    case postEmoji
}

extension EmojiAPI: APIProtocol {

    var url: URL {
        URL(string: "https://api.github.com/emojis")!
    }

    var method: Method {
        switch self {
        case .getEmojis:
            return .get
        case .postEmoji:
            return .post
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}

struct EmojisAPICAllResult: Decodable {
    let emojis: [Emoji]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            Emoji(name: key, emojiUrl: URL(string: value)!)
        
        }
    }
}
