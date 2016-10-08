//
//  LiveVisitorCell.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/6.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class LiveVisitorCell: UICollectionViewCell {
    
    var iconUrl: String? {
        didSet {
            if let url = NSURL(string: iconUrl ?? "") {
                SDWebImageManager.sharedManager().downloadWithURL(url, options: .RetryFailed, progress: nil, completed: { (image, error, _, _) in
                    if error != nil || image == nil {
                        return
                    }
                    self.iconImageView.image = image.circleImage()
                })
            }
        }
    }
    
    private lazy var iconImageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
