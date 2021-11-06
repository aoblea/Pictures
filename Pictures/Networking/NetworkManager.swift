//
//  NetworkManager.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
}

class NetworkManager {
    private lazy var session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func fetchPhotos(completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        let endpoint = Endpoint.list(page: "1", limit: "50")
        let request = URLRequest(url: endpoint.url)
        
        dataTask(with: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let photos = try JSONDecoder().decode([Photo].self, from: data)
                        completion(.success(photos))
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print(key, context)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print(type, context)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        dataTask(with: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    
                    let image = UIImage(data: data)
                    completion(.success(image ?? UIImage.remove))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

// MARK: - Private
private extension NetworkManager {
    func dataTask(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        return task
    }
}
