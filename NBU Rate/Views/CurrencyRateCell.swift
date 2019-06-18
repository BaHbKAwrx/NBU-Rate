//
//  CurrencyRateCell.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class CurrencyRateCell: UITableViewCell {
    
    @IBOutlet private weak var currencyImage: UIImageView!
    @IBOutlet private weak var currencyCode: UILabel!
    @IBOutlet private weak var currencyName: UILabel!
    @IBOutlet private weak var currencyRate: UILabel!

    func configure(with currency: Currency) {
        currencyCode.text = currency.code
        currencyName.text = currency.name
        currencyRate.text = String(format: "%.4f", currency.rate)
        currencyImage.image = UIImage(named: currency.image)
    }
}
