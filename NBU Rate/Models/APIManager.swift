//
//  APIManager.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

final class APIManager {
    
    enum RequestResult {
        case success([Currency])
        case failure(Error)
    }
 
    private var dataTask: URLSessionDataTask?
    
    func performRequest(currencyCode: String, for date: Date, completion: @escaping (RequestResult) -> Void) {
        
        //dataTask?.cancel()
        
        guard let url = requestURL(currencyCode: currencyCode, for: date) else {
            print("Error with URL")
            return
        }
        
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let currencies = self.parse(data: data)
                
                DispatchQueue.main.async {
                    completion(.success(currencies))
                }
            }

        })
        dataTask?.resume()
    }
    
    // configuring URL due to request parameters
    private func requestURL(currencyCode: String, for date: Date) -> URL? {
        let convertedDate = DateConverter.toURLFormat(with: date)
        
        let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?\(currencyCode)date=\(convertedDate)&json"
        let url = URL(string: urlString)
        return url
    }
    
    // transforming data into Currency array using Codable
    private func parse(data: Data) -> [Currency] {
        do {
            let decoder = JSONDecoder()
            let currencies = try decoder.decode([Currency].self, from: data)
            return currencies
        } catch {
            print("json error: \(error)")
            return []
        }
    }
}
