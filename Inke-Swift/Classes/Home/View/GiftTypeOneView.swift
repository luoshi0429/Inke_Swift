//
//  GiftTypeOneView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/6.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class GiftTypeOneView: UIView {
    
    var gift: Gift? {
        didSet {
            guard let g = gift else {
                return
            }
            
            if let url = NSURL(string: g.icon ?? "") {
                SDWebImageManager.sharedManager().downloadWithURL(url, options: .RetryFailed, progress: nil, completed: { (image, error, _, _) in
                    if image == nil || error != nil {
                        return
                    }
                    self.giftImageView.image = image.circleImage()
                })
            }
            
            giftNameLabel.text = "送一个\(g.name ?? "")"
        }
    }
    
    var visitor: Live? {
        didSet {
            if let url = NSURL(string: visitor?.creator?.portrait ?? "") {
                SDWebImageManager.sharedManager().downloadWithURL(url, options: .RetryFailed, progress: nil, completed: { (image, error, _, _) in
                    if image == nil || error != nil {
                        return
                    }
                    self.portraitImageView.image = image.circleImage()
                })
            }
            nickLabel.text = visitor?.creator?.nick ?? ""
        }
    }
    
    var count: Int = -1 {
        didSet {
            countLabel.text = "x\(count)"
        }
    }
    
    private lazy var containerView: UIView = UIView()
    private lazy var portraitImageView = UIImageView()
    private lazy var giftImageView = UIImageView()
    private lazy var nickLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(14)
        lb.textColor = UIColor.whiteColor()
        return lb
    }()
    private lazy var giftNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(13)
        lb.textColor = UIColor(red: 247 / 255.0, green: 228 / 255.0, blue: 23 / 255.0, alpha: 1.0)
        return lb
    }()
    private lazy var countLabel: UILabel = {
        let lb = UILabel()
//        lb.font = UIFont.systemFontOfSize(36)
        lb.font = UIFont.boldSystemFontOfSize(36)
        
        lb.textColor = UIColor(red: 247 / 255.0, green: 228 / 255.0, blue: 23 / 255.0, alpha: 1.0)
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func begin() {
        UIView.animateWithDuration(0.25, animations: {
            self.frame.origin.x = 0
        }) { (_) in
            self.animEnd()
        }

    }
    
    func animEnd() {
        
        UIView.animateWithDuration(0.25, delay: 0.25, options: .CurveLinear, animations: { 
            self.frame.origin.y = self.frame.origin.y - 30
            }) { (_) in
                self.removeFromSuperview()
        }
    }
}

extension GiftTypeOneView {
    private func setupUI() {
        
        let containerViewW: CGFloat = 35
        containerView.layer.cornerRadius = containerViewW / 2
        containerView.layer.masksToBounds = true 
        addSubview(containerView)
        
        let containerBg = UIImageView()
        containerBg.backgroundColor = UIColor.blackColor()
        containerBg.alpha = 0.6
        containerView.addSubview(containerBg)
        
        containerView.addSubview(portraitImageView)
        containerView.addSubview(nickLabel)
        containerView.addSubview(giftNameLabel)

        addSubview(giftImageView)
        addSubview(countLabel)
        
        containerView.snp_makeConstraints { (make) in
            make.leading.equalTo(5)
            make.height.equalTo(containerViewW)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(200)
        }
        
        containerBg.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        portraitImageView.snp_makeConstraints { (make) in
            make.top.leading.equalTo(0)
            make.height.width.equalTo(35)
        }
        
        nickLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(portraitImageView.snp_trailing).offset(10)
            make.top.equalTo(2)
        }
        
        giftNameLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(nickLabel.snp_leading)
            make.bottom.equalTo(2)
        }
        
        giftImageView.snp_makeConstraints { (make) in
            make.trailing.equalTo(containerView.snp_trailing)
            make.centerY.equalTo(self.snp_centerY)
            make.width.height.equalTo(self.snp_height)
        }
        
        countLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(containerView.snp_trailing).offset(10)
            make.centerY.equalTo(self.snp_centerY)
        }
        
    }
}
