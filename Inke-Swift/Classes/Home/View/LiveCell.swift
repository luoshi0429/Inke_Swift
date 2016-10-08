//
//  LiveCell.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage

class LiveCell: UITableViewCell {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var onlineCountLabel: UILabel!
    @IBOutlet weak var coverPortraitImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeightCons: NSLayoutConstraint!
    
    var live: Live? {
    
        didSet {
            portraitImageView.image = UIImage(named: "default_head")
            portraitImageView.clipsToBounds = true
            coverPortraitImageview.image = UIImage(named: "default_room")
            
            if let url = NSURL(string: live?.creator?.portrait ?? "") {
            
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: .RetryFailed, progress: nil, completed: { (image, error, _, _, _) in
                    if error != nil || image == nil {
                        return
                    }
                    self.portraitImageView.image = image.circleImage()
                    self.coverPortraitImageview.image = image
                })
            }
            
            nickLabel.text = live?.creator?.nick ?? ""
            let city = live?.city ?? ""
            cityLabel.text = city.characters.count > 0 ? city : "难道在火星"
            
            if let count = live?.online_users {
                onlineCountLabel.text = "\(count)"
            } else {
                onlineCountLabel.text = "0"
            }
            
            if live?.name == nil || live?.name?.characters.count == 0 {
                bottomViewHeightCons.constant = 0
                nameLabel.hidden = true
            } else {
                nameLabel.hidden = false
                nameLabel.text = live?.name
                 bottomViewHeightCons.constant = 30 
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
