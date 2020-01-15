//
//  StocksDataManager.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import Foundation

let mainStocksJSON = """
{
    "stocks":
       [
           { "name":"JPMorgan", "stk":"JPM", "img":"https://www.interbrand.com/assets/00000001535.png","priority":"100" },
           { "name":"Bank of America", "stk":"BAC", "img":"https://www.charlotteobserver.com/latest-news/uiy86c/picture6131838/alternates/FREE_1140/E8VhA.So.138.jpg","priority":"99" },
           { "name":"Citigroup", "stk":"C", "img":"https://pentagram-production.imgix.net/wp/592ca89f19a1d/ps-citibank-01.jpg","priority":"80" },
           { "name":"Wells Fargo", "stk":"IIS", "img":"https://motorsportsnewswire.com/wp-content/uploads/2019/08/Wells-Fargo-Company-logo-678.jpg","priority":"15" },
           { "name":"Morgan Stanley", "stk":"MS", "img":"https://www.spglobal.com/_assets/images/leveragedloan/2012/07/morgan-stanley-logo.jpg","priority":"15"  }
    
       ]
}
"""

struct MainStockKeys {
    static let name = "name"
    static let stk = "stk"
    static let imgURL = "img"
    static let priority = "priority"
}

struct MainStockData {
    var name: String?
    var stk: String?
    var imgURL: String?
    var priority: Int?
}

class StocksDataManager {
    
    static let sharedInstance = StocksDataManager()
    
    var mainStocks = [MainStockData]()
    
    init() {
        setMainStocksData()
    }
    
    func setMainStocksData() {
        let data = Data(mainStocksJSON.utf8)
            
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let stocks = json["stocks"] as? [[String:Any]] {
                    for stock in stocks {
                        var stockData = MainStockData()
                        if let name = stock[MainStockKeys.name] as? String {
                            stockData.name = name
                        }
                        if let stk = stock[MainStockKeys.stk] as? String {
                            stockData.stk = stk
                        }
                        if let imgURL = stock[MainStockKeys.imgURL] as? String {
                            stockData.imgURL = imgURL
                        }
                        if let priority = stock[MainStockKeys.priority] as? NSString {
                            stockData.priority = priority.integerValue
                        }
                        mainStocks.append(stockData)
                    }
                }
            }
        } catch let error {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
