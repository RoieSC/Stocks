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
        let stockData = mainStocksData[indexPath.row]
        cell.nameLabel.text = stockData.name
        cell.stkLabel.text = stockData.stk
        cell.priorityLabel.text = "\(stockData.priority ?? 0)"
        cell.setImage(urlStr: stockData.imgUrlStr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockData = mainStocksData[indexPath.row]
        StockDataManager.getStockData(symbol: stockData.stk!, interval: .one) { (success, error, stocksData) in
            if let stockDataVC = UIStoryboard.init(name: "SingleStockDataVC", bundle: Bundle.main).instantiateViewController(identifier: "SingleStockDataVC") as? SingleStockDataVC {
                stockDataVC.stockName = stockData.name
                stockDataVC.stocksData = stocksData
                self.navigationController?.show(stockDataVC, sender: nil)
            }
            print("stocksData = \(String(describing: stocksData))")
        }
    }
}
