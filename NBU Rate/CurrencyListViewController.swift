//
//  CurrencyListViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class CurrencyListViewController: UITableViewController {
    
    private var currencies = [Currency]()
    private let apiManager = APIManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        apiManager.performRequest { currencyArray in
            self.currencies = currencyArray
            self.tableView.reloadData()
        }
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
            cell.currencyImage.image = UIImage(named: "RU")
            return cell
        }
        return UITableViewCell()
    }

}
