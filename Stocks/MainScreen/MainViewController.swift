//
//  MainViewController.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
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
        let stocksData = mainStocksData[indexPath.row]
        cell.nameLabel.text = stocksData.name
        cell.stkLabel.text = stocksData.stk
        cell.priorityLabel.text = "\(stocksData.priority ?? 0)"
        if let imgURL = URL(string: stocksData.imgUrlStr ?? "") {
            if !cell.didLoadImage {
                let thumbnailSize = CGSize(width: 100, height: 100) // Thumbnail will bounds to (200,200)
                print("loading image from url: \(String(describing: imgURL.lastPathComponent))")
                cell.stockImgView?.sd_setImage(with: imgURL, placeholderImage: nil, context: [SDWebImageContextOption.imageThumbnailPixelSize: thumbnailSize], progress: nil, completed: { (image, error, cacheType, url) in
                    print("load image from url completed: \(String(describing: url?.lastPathComponent))")
                    if error == nil && image != nil {
                        cell.didLoadImage = true
                    }
                })
            }
        }
        return cell
    }
}
