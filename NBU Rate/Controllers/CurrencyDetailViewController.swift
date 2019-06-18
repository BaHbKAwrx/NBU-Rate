//
//  CurrencyDetailViewController.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit
import Charts

final class CurrencyDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var rateChart: LineChartView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var currencyImage: UIImageView!
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var currencyCode = ""
    private let apiManager = APIManager()
    private var currencies = [Currency]()

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        setElementsAlpha(to: 0)
        
        getHistoricData(forDays: Constants.historicDataCount)
    }
    
    deinit {
        print("Deinit completed")
    }
    
    // MARK: - Methods
    private func setElementsAlpha(to value: CGFloat) {
        rateChart.alpha = value
        codeLabel.alpha = value
        currencyImage.alpha = value
        currencyNameLabel.alpha = value
        descriptionLabel.alpha = value
    }
    
    private func getHistoricData(forDays days: Int) {
        // checking for valid value
        guard days > 0 else { return }
        for i in 1..<days + 1 {
            apiManager.performRequest(currencyCode: "valcode=\(currencyCode)&", for: DateConverter.getPreviousDate(withOffset: i)) { (result) in
                switch result {
                case .failure(let error as NSError):
                    print("\(error.localizedDescription)")
                case .success(let currencies):
                    guard let currency = currencies.first else { return }
                    self.currencies += [currency]
                    if self.currencies.count == days {
                        self.currencies.sort { DateConverter.dateFromString($0.exchangeDate).compare(DateConverter.dateFromString($1.exchangeDate)) == .orderedAscending }
                        self.setupUI(with: self.currencies)
                    }
                }
            }
        }
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
        // fade animation
        UIView.animate(withDuration: Constants.fadeAnimationDuration) {
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
