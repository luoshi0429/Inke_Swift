//
//  GiftTypeTwoView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class GiftTypeTwoView: UIView {

    var giftImage: String? {
        didSet {
            guard let url = NSURL(string: giftImage ?? "") else {
                return
            }
            
            giftImageView.sd_setImageWithURL(url)
        }
    }
    var senderNick: String? {
        didSet {
            senderNickLabel.text = senderNick ?? ""
        }
    }

    private var containerView: UIView = UIView()
    private lazy var giftImageView: UIImageView = UIImageView()
    private lazy var senderNickLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFontOfSize(20)
        lb.textColor = UIColor(red: 234 / 255.0, green: 242 / 255.0, blue: 201 / 255.0, alpha: 1.0)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnim() {
        UIView.animateWithDuration(1, animations: {
            self.containerView.frame.origin = CGPoint(x: (ScreenWidth - self.containerView.frame.size.width) / 2, y: (ScreenHeight - self.containerView.frame.size.height) / 2)
            }) { (_) in
            UIView.animateWithDuration(1, delay: 2, options: .CurveLinear, animations: {
                self.containerView.frame.origin = CGPoint(x: ScreenWidth, y: ScreenHeight - 120  )
                }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
    
}

// MARK: - UI
extension GiftTypeTwoView {
    private func setupUI() {
        
        self.frame = ScreenFrame
        
        let containerW:CGFloat = 200
        let containerH: CGFloat = 120
        let top: CGFloat = 120
        containerView.frame = CGRectMake(-containerW,top , containerW, containerH)
        addSubview(containerView)
        
        containerView.addSubview(senderNickLabel)
        containerView.addSubview(giftImageView)
        
        // Constraints
        senderNickLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp_centerX)
            make.top.equalTo(0)
        }
        // 77 40
        giftImageView.snp_makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(154)
            make.centerX.equalTo(self.containerView.snp_centerX)
            make.top.equalTo(self.senderNickLabel.snp_bottom).offset(10)
        }
        
    }
}


