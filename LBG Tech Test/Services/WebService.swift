//
//  WebService.swift
//  LBG Tech Test
//
//  Created by Nithin Cheruthala on 20/10/2022.
//

import Foundation
enum NetworkError: Error{
    case urlError
    case domainError
    case decodingError
}
struct OutPutData<T: Codable>{
    let endPoind: String
}
class WebService{
    func getResponse<T>(endPoint: OutPutData<T>, completion: @escaping(Result<T, NetworkError>) -> Void){
        
        let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/\(endPoint.endPoind)")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
