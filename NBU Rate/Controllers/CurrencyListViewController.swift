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
        title = "Loading..."
        
        apiManager.performRequest(for: Date()) { currencyArray in
            self.currencies = currencyArray
            self.title = "Курс на \(self.currencies.first?.exchangeDate ?? " ")"
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let controller = segue.destination as? CurrencyDetailViewController {
                if let cell = sender as? CurrencyRateCell, let indexPath = tableView.indexPath(for: cell) {
                    controller.currencyCode = currencies[indexPath.row].code
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyRateCell {
            let currency = currencies[indexPath.row]
            cell.currencyCode.text = currency.code
            cell.currencyName.text = currency.name
            cell.currencyRate.text = String(format: "%.4f", currency.rate)
            cell.currencyImage.image = UIImage(named: currency.image)
            return cell
        }
        return UITableViewCell()
    }

}
