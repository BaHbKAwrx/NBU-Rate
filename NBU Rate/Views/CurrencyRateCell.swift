//
//  CurrencyRateCell.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class CurrencyRateCell: UITableViewCell {
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
