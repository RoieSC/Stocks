//
//  SingleStockDataVC.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 18/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit

class SingleStockDataVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var stockName: String?
    var stocksData: [StockData]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = stockName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksData != nil ? stocksData!.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockDataCellID", for: indexPath) as! StockDataCell
        if let stocksData = stocksData {
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
}
