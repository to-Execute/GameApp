//
//  NetworkServices.swift
//  GameApp
//
//  Created on 23/03/2025.
//

import Foundation

class NetworkServices {
    
    static let shared: NetworkServices = {
        return NetworkServices()
    }()
    
    func parseJson<T> (_ type: T.Type, file: String, completion: @escaping (_ response: String, _ userData: T) -> Void) where T: Codable {
        
        if let url = Bundle.main.url(forResource: file, withExtension: nil) {
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                do {
                    guard let userData = try? decoder.decode(T.self, from: data) else {
                        return
                    }
//                    print(userData)
                    completion("success", userData)
                } catch {
                    print("error")
                    
                }
                
            }
            
        } else {
            
        }
    }
}
