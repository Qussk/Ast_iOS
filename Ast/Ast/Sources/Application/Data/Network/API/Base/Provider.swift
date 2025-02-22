//
//  Provider.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import Foundation
import Moya
import UIKit


final class Provider<T: TargetType> {
    enum PrintOption {
        case disable
        case endPoint
        case endPointAndParameters
    }
        
    var printRequest: PrintOption = .endPointAndParameters
    var printResponse: PrintOption = .endPointAndParameters
    private var moyaProvider = MoyaProvider<T>()
}


// MARK: - Request
extension Provider {
    func request<E: Decodable>(_ target: T, entityType: E.Type, completion: @escaping (Result<E, APIError>) -> Void) {
        printRequestDescription(target: target)
        guard NetworkMonitor.shared.isNetworkAvailable() else {
            completion(.failure(.unconnect))
            return
        }
        moyaProvider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    self.printResponseDescription(response: response)
                    let object = try self.jsonArrObject(data: response.data)
                    let data = try JSONSerialization.data(withJSONObject: object)
                    let apiResponse = try JSONDecoder().decode(entityType.self, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(.unowned))
                }
            case .failure(_):
                completion(.failure(.unowned))
            }
        }
    }
    
    func asyncRequest<E: Decodable>(_ target: T, entityType: E.Type) async throws -> E {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target, entityType: entityType) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Parsing

private extension Provider {
    func jsonArrObject(data: Data) throws -> [[String: Any?]] {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: [])

            guard let array = object as? [[String: Any]] else {
                throw APIError.parsingResponse(body: String(data: data, encoding: .utf8))
            }
            
            return array
        }
        catch {
            throw error
        }
    }
}

// MARK: - Print

extension Provider {
    func printRequestDescription(target: T, withHeaders: Bool = false) {
        guard printRequest != .disable
        else { return }
        
        let endPoint = "\(target.method.rawValue) \(target.baseURL)/\(target.path)"
        var description = "[REQUEST | \(endPoint)]:"
        
        guard printRequest == .endPointAndParameters
        else {
            print(description)
            return
        }
        
        if withHeaders,
           let headers = target.headers,
           !headers.isEmpty,
           let data = try? JSONSerialization.data(withJSONObject: headers, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8){
            description += "\n\(string)"
        }
        
        if case .requestParameters(let parameters, _) = target.task,
           let data = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8) {
            description += "\n\(string)"
        }
        else {
            description += "\n\(target.task)"
        }
        
        print(description)
    }
    
    func printResponseDescription(response: Moya.Response) {
        guard printResponse != .disable,
              let request = response.request
        else { return }
        
        let data = response.data
        let endPoint = "\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")"
        let description = "[RESPONSE | \(endPoint)]:"
        
        guard printResponse == .endPointAndParameters
        else {
            print(description)
            return
        }
         
        if let object = try? JSONSerialization.jsonObject(with: data, options: []),
           let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8) {
            print("\(description)\n\(string)")
        }
        else {
            print("\(description) unknown.")
        }
    }
     
    func printUnknownResponse() {
        print("[RESPONSE]: unknown.")
    }
}
