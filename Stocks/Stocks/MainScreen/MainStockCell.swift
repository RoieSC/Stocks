//
//  MainStockCell.swift
//  Stocks
//
//  Created by Roie Shimon Cohen on 15/01/2020.
//  Copyright © 2020 RoieSC. All rights reserved.
//

import UIKit
import SDWebImage

class MainStockCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stkLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var stockImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(urlStr: String?, completion:@escaping(Bool, Error?) -> ()) {
        if let imgURL = URL(string: urlStr ?? "") {
            let thumbnailSize = CGSize(width: 100, height: 100)
            stockImgView?.sd_setImage(with: imgURL, placeholderImage: nil, context: [SDWebImageContextOption.imageThumbnailPixelSize: thumbnailSize], progress: nil, completed: { (image, error, cacheType, url) in
                if error == nil && image != nil {
                    completion(true, nil)
                }
                else {
                    completion(false, error)
                }
            })
        }
    }

}
