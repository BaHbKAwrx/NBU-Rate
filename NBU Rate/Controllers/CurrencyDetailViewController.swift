//
//  CurrencyDetailViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class CurrencyDetailViewController: UIViewController {
    
    var currencyCode = ""
    private let apiManager = APIManager()
    private var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(currencyCode)
        
        // getting 7 previous days date
        for i in 1..<8 {
            apiManager.performRequest(currencyCode: "valcode=\(currencyCode)&", for: DateConverter.getPreviousDate(withOffset: i)) { (result) in
                switch result {
                case .failure(let error as NSError):
                    print("\(error.localizedDescription)")
                case .success(let currencies):
                    self.currencies += currencies
                    if self.currencies.count == 7 {
                        self.currencies.sort(by: { (currencyData1, currencyData2) -> Bool in
                            DateConverter.dateFromString(currencyData1.exchangeDate).compare(DateConverter.dateFromString(currencyData2.exchangeDate)) == .orderedAscending
                        })
                        // TODO: Instead of print make chart representation
                        print("Ready: ", self.currencies)
                    }
                }
            }
        }
        
    }
    
    deinit {
        print("Deinit completed")
    }
    
}
