//
//  APIManager.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

class APIManager {
 
    private var dataTask: URLSessionDataTask?
    
    func performRequest(for date: Date, completion: @escaping ([Currency]) -> Void) {
        
        dataTask?.cancel()
        
        guard let url = requestURL(for: date) else {
            print("Error with URL")
            return
        }
        
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error as NSError?, error.code == -999 {
                print("data task was cancelled")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let currencies = self.parse(data: data)
                
                DispatchQueue.main.async {
                    completion(currencies)
                }
            }

        })
        dataTask?.resume()
    }
    
    private func requestURL(for date: Date) -> URL? {
        let convertedDate = DateConverter.toURLFormat(with: date)
        
        let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=\(convertedDate)&json"
        let url = URL(string: urlString)
        return url
    }
    
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
