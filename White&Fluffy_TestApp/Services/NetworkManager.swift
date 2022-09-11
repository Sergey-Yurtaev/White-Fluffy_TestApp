//
//  NetworkManager.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let key = "Client-ID rJeB0E-9_h5I60V4_GdWKRgirYcb3SW6y39kXRkQwM4"
    
    private init() {}
    
    func getData(searchTerm: String, completion: @escaping ([Photo]) -> Void) {
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        guard let url = self.url(parameters: parameters) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] =  key
        return headers
    }
    
    private func prepareParaments(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        if searchTerm != "" {
            parameters["query"] = searchTerm
        }
        parameters["count"] = String(30)
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        return components.url
    }
}

