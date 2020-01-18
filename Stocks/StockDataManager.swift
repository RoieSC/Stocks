//
//  StockDataManager.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 18/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import Foundation

struct StockDataKeys {
    static let open = "1. open"
    static let high = "2. high"
    static let low = "3. low"
    static let close = "4. close"
    static let volume = "5. volume"
}

struct StockData {
    var time: Date
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Double
}

class StockDataManager {
    
    class func getStockData(symbol: String, interval:StockDataInterval, completion: @escaping(Bool, Error?, [StockData]?) -> ()) {
        StockNetworkManager.requestStockData(symbol: symbol, interval: .one) { (success, error, response) in
            if success && response != nil {
                var stocksData = [StockData]()
                for (timeStr, data) in (response!) {
                    print("time: \(timeStr), data: \(data)")
                    if let stockData = getStockData(timeStr: timeStr, data: data) {
                        print("stockData: \(stockData)")
                        stocksData.append(stockData)
                    }
                }
                
            }
        }
    }
    
    //MARK:Utilities
    class func getStockData(timeStr: String, data: [String:Any]) -> StockData? {
        guard let date = date(fromString: timeStr) else {
            print("Error getting date")
            return nil
        }
        
        if  let open = data[StockDataKeys.open] as? NSString,
            let high = data[StockDataKeys.high] as? NSString,
            let low = data[StockDataKeys.low] as? NSString,
            let close = data[StockDataKeys.close] as? NSString,
            let volume = data[StockDataKeys.volume] as? NSString {
            return StockData(time: date, open: open.doubleValue, high: high.doubleValue, low: low.doubleValue, close: close.doubleValue, volume: volume.doubleValue)
        }
        return nil
    }
    
    class func date(fromString str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: str) {
            return date
        }
        return nil
    }
}
