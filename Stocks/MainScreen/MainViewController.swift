//
//  MainViewController.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    var mainStocksData = [MainStockData]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainStocksData = StocksDataManager.sharedInstance.mainStocks
        for stock in mainStocksData {
            print(stock)
        }
        
        
        
        self.navigationController?.navigationItem.title = "Stocks"
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainStocksData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainStockID", for: indexPath) as! MainStockCell
        cell.nameLabel.text = mainStocksData[indexPath.row].name
        cell.stkLabel.text = mainStocksData[indexPath.row].stk
        cell.priorityLabel.text = "\(mainStocksData[indexPath.row].priority ?? 0)"
        return cell
    }
}

