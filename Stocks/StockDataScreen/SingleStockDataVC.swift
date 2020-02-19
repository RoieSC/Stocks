//
//  SingleStockDataVC.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 18/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit
import MBProgressHUD

class SingleStockDataVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var stockName: String?
    var stockSymbol: String?
    var stockDataList: [StockData]?
    var stockDataInterval: StockDataInterval = .one
    var segmentedControlIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = stockName
        stockDataList?.sort(by: {$0.date > $1.date})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDataList != nil ? stockDataList!.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockDataCellID", for: indexPath) as! StockDataCell
        if let stocksData = stockDataList {
            let stockData = stocksData[indexPath.row]
            cell.timeLabel.text = stockData.timeStr
            cell.openLabel.text = "Open: \(stockData.open)"
            cell.highLabel.text = "High: \(stockData.high)"
            cell.lowLabel.text = "Low: \(stockData.low)"
            cell.closeLabel.text = "Close: \(stockData.close)"
            cell.volumeLabel.text = "Volume: \(stockData.volume)"
        }
        return cell
    }
    
    
    //MARK: Actions
    @IBAction func segmentedControlChanged(_ sender: Any) {
        let _stockDataInterval = stockDataInterval.getInterval(withIndex: segmentedControl.selectedSegmentIndex)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        StockDataManager.getStockData(symbol: stockSymbol!, interval: _stockDataInterval) { (success, error, stocksData) in
            if success && stocksData != nil {
                self.stockDataInterval = _stockDataInterval
                self.segmentedControlIndex = self.segmentedControl.selectedSegmentIndex
                self.stockDataList = stocksData
                self.stockDataList?.sort(by: {$0.date > $1.date})
                self.tableView.reloadData()
            }
            else {
                self.segmentedControl.selectedSegmentIndex = self.segmentedControlIndex
                self.showAlert(title: "Error loading:", message: "\(error?.localizedDescription ?? "There is a limit to 5 requests per minute only")")
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
