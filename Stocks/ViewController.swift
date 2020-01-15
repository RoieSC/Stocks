//
//  ViewController.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainStocksData: [MainStockData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStocksData = StocksDataManager.sharedInstance.mainStocks
        if let stocks = mainStocksData {
            for stock in stocks {
                print(stock)
            }
        }
        
    }


}

