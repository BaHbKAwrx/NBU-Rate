//
//  CurrencyListViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

final class CurrencyListViewController: UITableViewController {
    
    // MARK: - Properties
    private var currencies = [Currency]() {
        didSet {
            title = "Курс на \(currencies.first?.exchangeDate ?? " ")"
            tableView.reloadData()
        }
    }
    private let apiManager = APIManager()

    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Loading..."
        
        getCurrencyData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailSegueIdentifier {
            if let controller = segue.destination as? CurrencyDetailViewController {
                if let cell = sender as? CurrencyRateCell, let indexPath = tableView.indexPath(for: cell) {
                    controller.currencyCode = currencies[indexPath.row].code
                }
            }
        }
    }
    
    // MARK: - Methods
    private func getCurrencyData() {
        apiManager.performRequest(currencyCode: "", for: Date()) { (result) in
            switch result {
            case .failure(let error as NSError):
                self.showNetworkError(error: error)
            case .success(let currencies):
                self.currencies = currencies
            }
        }
    }
    
    private func showNetworkError(error: NSError) {
        let alertController = UIAlertController(title: Constants.alertTitle, message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.currencyCellIdentifier, for: indexPath) as? CurrencyRateCell {
            let currency = currencies[indexPath.row]
            cell.configure(with: currency)
            return cell
        }
        return UITableViewCell()
    }

}
