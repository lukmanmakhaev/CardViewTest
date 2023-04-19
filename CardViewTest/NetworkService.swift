//
//  NetworkLayer.swift
//  CardViewTest
//
//  Created by Lukman Makhaev on 15.04.2023.
//

import Foundation
import Alamofire
import SwiftUI

enum NetworkErroreType {
    case authError
    case serverError(message: String)
    case serverDown
    
    case emptyData
    case decodeError
    
    case messageError(message: String)
}

extension NetworkErroreType: Error, LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .authError:
            return "Ошибка авторизации"
        case .serverError(message: let message):
            return message
        case .serverDown:
            return "Все упало"
        case .emptyData:
            return "Данные не получены"
        case .decodeError:
            return "Ошибка в декодировании"
        case .messageError(message: let message):
            return message
            
        default: return ""
        }
    }
}

class NetworkService: ObservableObject {
    
    @StateObject var viewModel = CardViewModel()
    
    func takeCompanies(offset: Int, completion: @escaping ((Result<[Responce], NetworkErroreType>)) -> Void) {
        let parameters = ["offset": offset]

        let headers: HTTPHeaders = [
            "TOKEN" : "123",
            "Content-Type" : "application/json"
        ]

        AF.request("http://dev.bonusmoney.pro/mobileapp/getAllCompanies",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers
        )
        .validate()
        .response { responce in
            switch responce.result {
            case .success (let data):
                guard let data = data else {
                    completion(.failure(.emptyData))
                    print("empty data")
                    return
                }
                do {
                    let jsondata = try JSONDecoder().decode([Responce].self, from: data)
                    completion(.success(jsondata))
                    
                    print(offset)
                    //print(jsondata)
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                switch responce.response?.statusCode {
                case 401:
                    completion(.failure(.authError))
                case 400:
                    completion(.failure(.messageError(message: error.localizedDescription)))
                case 500:
                    completion(.failure(.serverDown))
                default:
                    completion(.failure(.messageError(message: error.localizedDescription)))
                }
            }
        }
    }
}
