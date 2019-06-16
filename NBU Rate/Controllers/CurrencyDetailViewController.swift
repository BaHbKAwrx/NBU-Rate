//
//  CurrencyDetailViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit
import Charts

class CurrencyDetailViewController: UIViewController {
    
    @IBOutlet weak var rateChart: LineChartView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var currencyCode = ""
    private let apiManager = APIManager()
    private var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        setElementsAlpha(to: 0)

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
                        print("Ready: ", self.currencies)
                        self.setupUI(with: self.currencies)
                    }
                }
            }
        }
        
    }
    
    deinit {
        print("Deinit completed")
    }
    
    private func setElementsAlpha(to value: CGFloat) {
        rateChart.alpha = value
        codeLabel.alpha = value
        currencyImage.alpha = value
        currencyNameLabel.alpha = value
        descriptionLabel.alpha = value
    }
    
    private func setupUI(with currencies: [Currency]) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        codeLabel.text = currencies.first?.code
        currencyNameLabel.text = currencies.first?.name
        if let image = currencies.first?.image {
            currencyImage.image = UIImage(named: image)
        }
        setupChart(with: currencies)
        UIView.animate(withDuration: 1) {
            self.setElementsAlpha(to: 1.0)
        }
    }
    
    
    private func setupChart(with currencies: [Currency]) {
        var values = [ChartDataEntry]()
        for i in 0..<currencies.count {
            values.append(ChartDataEntry(x: Double(DateConverter.getDay(from: Date()) - currencies.count + i), y: currencies[i].rate))
        }
        let set = LineChartDataSet(values: values, label: "Historic data")
        
        let legend = rateChart.legend
        legend.enabled = false
        
        let xAxis = rateChart.xAxis
        xAxis.labelPosition = .bottom
        
        set.setCircleColor(NSUIColor.black)
        set.drawCirclesEnabled = false
        set.colors = [NSUIColor.black]
        set.valueTextColor = .clear
        
        let data = LineChartData(dataSet: set)
        
        rateChart.data = data
    }
    
}
