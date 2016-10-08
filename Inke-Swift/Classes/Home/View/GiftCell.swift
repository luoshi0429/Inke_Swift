//
//  GiftCell.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/5.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage

class GiftCell: UICollectionViewCell {
    
    var gift: Gift? {
        didSet {
            
            guard let g = gift else {
                return
            }
            
            goldLabel.text = "\(g.gold)"
            expLabel.text = "加\(g.exp)经验值"
            
            if g.isSelected == true {
                typeImageView.image = UIImage(named: "gift_selected")
            } else {
                if g.type != 1 {
                    typeImageView.image = UIImage()
                } else {
                    typeImageView.image = UIImage(named: "pop_gift_lian")
                }
            }
            
            guard let url = NSURL(string:g.image ?? "") else {
                return
            }
            iconImageView.sd_setImageWithURL(url)
            
        }
    }

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var expLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

}
