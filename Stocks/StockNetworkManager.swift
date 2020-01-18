//
//  StockNetworkManager.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 18/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import Foundation
import Alamofire

enum StockDataInterval: Int {
    case one = 1, five = 5, fifteen = 15, thirty = 30, sixty = 60
}

class StockNetworkManager {
    
    static let apiKey = "Z8EW6CI3PHR9SUTK"
    
    class func requestStockData(symbol: String, interval:StockDataInterval, completion: @escaping(Bool, Error?, [String:[String:Any]]?) -> ()) {
        if let url = requestURL(symbol: symbol, interval: interval) {
            Alamofire.request(url, method: .get, parameters: nil).validate().responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completion(false, response.error, nil)
                  return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchAllRooms service")
                    completion(false, response.error, nil)
                    return
                }
                
                for dict in value {
                    if dict.value is [String:[String:Any]] {
                        completion(true, nil, dict.value as? [String:[String:Any]])
                        break
                    }
                }
            }
        }

    }
    
    class func requestURL(symbol: String, interval: StockDataInterval) -> URL? {
        let urlStr = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=\(interval.rawValue)min&apikey=\(apiKey)"
        return URL(string: urlStr)
    }
}
