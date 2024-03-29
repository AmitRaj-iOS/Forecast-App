//
//  APIService.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import Foundation


struct APIService {
    // MARK: - Property
    static let shared = APIService()
    // MARK: - API Error Enumeration
    enum APIError: Error {
        case error(_ errorString: String)
    }
    //MARK: - Fetching and Decoding JSON Data
    //MARK: <T: Decodable> ->  For data encoding and decoding tasks,
    //MARK: JSONDecoder ->   An object that decodes instances of a data type from JSON objects
    //MARK: DateDecodingStrategy ->   The strategy to use for decoding Date values.
    //MARK: KeyDecodingStrategy ->   The strategy to use for decoding keys. Defaults to.
    //MARK: Result ->  A value that represents either a success or a failure, including an associated value in each case.
    //MARK: dataTask -> Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion
    //MARK: .resume() -> Resumes the task, if it is suspended.
    func getJSON<T: Decodable>(urlString: String,
                               dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: "Local Language"))))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data is currupt", comment: "Local Language"))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(APIError.error("DecodingError: \(decodingError.localizedDescription)")))
            }
        }.resume()
    }
}
