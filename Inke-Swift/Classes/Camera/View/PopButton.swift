//
//  PopButton.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class PopButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor(red: 78 / 255.0,green: 88 / 255.0, blue: 92 / 255.0,alpha: 1.0), forState: .Normal)
        self.titleLabel!.font = UIFont.systemFontOfSize(15)
        
//        imageView?.backgroundColor = UIColor.purpleColor()
//        titleLabel?.backgroundColor = UIColor.yellowColor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 5
        
        imageView?.frame.origin.y = self.frame.height / 2 - (imageView?.frame.height)! * 0.7
        imageView?.center.x = self.frame.width / 2
        titleLabel?.frame.origin.y = CGRectGetMaxY(imageView!.frame) + margin
        titleLabel?.center.x = self.frame.width / 2
        
    }

}
