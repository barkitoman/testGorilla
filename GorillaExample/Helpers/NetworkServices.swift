//
//  NetworkServices.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation

public enum FactorError: Error, Equatable {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case errorInPathFile
    case errorHandler(message: String)
    
    
    static public func == (lhs: FactorError, rhs:FactorError) -> Bool {
        switch (lhs, rhs) {
        case (.apiError, .apiError):
            return true
        case (.invalidEndpoint, .invalidEndpoint):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.noData, .noData):
            return true
        case (.decodeError, .decodeError):
            return true
        case (.errorInPathFile, .errorInPathFile):
            return true
        case (.errorHandler(message: _), .errorHandler(message: _)):
            return true
        default:
            return false
        }
    }
}

class NetworkServices {
    static let share = NetworkServices()
    
    private let urlSession = URLSession.shared
    private var aditionalPath: String = ""
    
    private var baseUrl: URL? {
        let  path = "https://gl-endpoint.herokuapp.com"
        var url = URL(string: "\(path)/")
        if !aditionalPath.isEmpty {
            url?.appendPathComponent(aditionalPath)
        }
        return url
    }

    func get<T: Codable>(type: T.Type,
                         params: [URLQueryItem] = [],
                         aditionalPath: String) -> Result<T, FactorError> {
        self.aditionalPath = aditionalPath
        
        guard let url = baseUrl, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return .failure(.invalidEndpoint)
            
        }
        urlComponents.queryItems = params
        
        guard let completeUrl = urlComponents.url else {
            return .failure(.invalidEndpoint)
        }
        
        var result: Result<T, FactorError>!
            
        let semaphore = DispatchSemaphore(value: 0)
        
        urlSession.dataTask(with: completeUrl) { (data, response, error)  in
            guard let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                result = .failure(.invalidResponse)
                return
            }
            do {
                let values = try JSONDecoder().decode(T.self, from: data)
                result = .success(values)
            } catch {
                result = .failure(.decodeError)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
}
