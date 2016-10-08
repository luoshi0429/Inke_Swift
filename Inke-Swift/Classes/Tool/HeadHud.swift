//
//  HeadHud.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/6.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class HeadHud: UIView {
    
    private lazy var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 74 / 255.0, green: 134 / 255.0, blue: 246 / 255.0, alpha: 1.0)
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.whiteColor()
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func showHUD(status: String,view: UIView = UIApplication.sharedApplication().windows.last!) {
        let hud = HeadHud()
        let hudH: CGFloat = 60 ;
        hud.frame = CGRect(x: 0, y: -hudH, width: ScreenWidth, height: hudH)
        
        hud.label.text = status
        hud.label.sizeToFit()
        
        view.addSubview(hud)
        
        UIView.animateWithDuration(0.25, animations: {
            hud.frame.origin.y = 0
            }) { (_) in
            UIView.animateWithDuration(0.25, delay: 0.5, options: .CurveLinear, animations: { 
                hud.frame.origin.y = -hudH
                }, completion: { (_) in
                hud.removeFromSuperview()
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.center = center
    }

}
