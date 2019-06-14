//
//  CurrencyListViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class CurrencyListViewController: UITableViewController {
    
    let currencies = [
        Currency(code: "USD", name: "Американський долар", rate: 26.833, exchangeDate: "18.06.2019", image: "US"),
        Currency(code: "EUR", name: "Эвро", rate: 29.345, exchangeDate: "18.06.2019", image: "EU"),
        Currency(code: "RUB", name: "Росiйський рубль", rate: 0.322, exchangeDate: "18.06.2019", image: "RU")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyRateCell {
            let currency = currencies[indexPath.row]
            cell.currencyCode.text = currency.code
            cell.currencyName.text = currency.name
            cell.currencyRate.text = "\(currency.rate)"
            cell.currencyImage.image = UIImage(named: "\(currency.image)")
            return cell
        }
        return UITableViewCell()
    }

}
