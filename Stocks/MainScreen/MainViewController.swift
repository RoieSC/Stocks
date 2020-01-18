//
//  MainViewController.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var mainStocksData = [MainStockData]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainStocksData = StocksDataManager.sharedInstance.mainStocks
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainStocksData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainStockID", for: indexPath) as! MainStockCell
        let stocksData = mainStocksData[indexPath.row]
        cell.nameLabel.text = stocksData.name
        cell.stkLabel.text = stocksData.stk
        cell.priorityLabel.text = "\(stocksData.priority ?? 0)"
        cell.setImage(urlStr: stocksData.imgUrlStr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stocksData = mainStocksData[indexPath.row]
        StockDataManager.getStockData(symbol: stocksData.stk!, interval: .one) { (success, error, stocksData) in
            
        }
    }
}
