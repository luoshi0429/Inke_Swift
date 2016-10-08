//
//  LMYAlertAction.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class LMYAlertAction: UIView {
    
    var cancelBlock: () -> () = {}
    
    var confirmBlock: () -> () = {}

    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: CGRectZero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(view: UIView = UIApplication.sharedApplication().windows.last!) {
        view.addSubview(self)
        UIView.animateWithDuration(0.25, animations: { 
            self.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (_) in
            self.transform = CGAffineTransformIdentity
        }
    }
    
    private func dismiss() {
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc private func cancel() {
        dismiss()
        cancelBlock()
    }
    
    @objc private func confirm() {
        dismiss()
        confirmBlock()
    }
}

// MARK: - UI
extension LMYAlertAction {
    private func setupUI() {
        
        let height: CGFloat = 150
        let margin: CGFloat = 30
        let width = ScreenWidth - 2 * margin
        let y = (ScreenHeight - height) / 2
        let bottomHeight: CGFloat = 50
        let btnW = width / 2
        let titleHeight = height - bottomHeight
        
        frame = CGRect(x: margin, y: y, width: width, height: height)
        
        let bg = UIImageView()
        bg.image = UIImage.imageWithColor(UIColor.whiteColor(), imageSize: CGSizeMake(width, height)).imageWithCornerRadius(5)
        bg.frame = bounds
        addSubview(bg)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor(red: 28 / 255.0, green: 191 / 255.0, blue: 179 / 255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFontOfSize(18)
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: titleHeight)
        addSubview(titleLabel)
        titleLabel.text = title
        
        let cancelBtn = UIButton(type: .Custom)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.setTitleColor(UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1.0), forState: .Normal)
        cancelBtn.addTarget(self, action: #selector(cancel), forControlEvents: .TouchUpInside)
        cancelBtn.frame = CGRect(x: 0, y: titleHeight, width: btnW, height: bottomHeight)
        addSubview(cancelBtn)
        
        let confirmBtn = UIButton(type: .Custom)
        confirmBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        confirmBtn.setTitle("确定", forState: .Normal)
        confirmBtn.setTitleColor(UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1.0), forState: .Normal)
        confirmBtn.addTarget(self, action: #selector(confirm), forControlEvents: .TouchUpInside)
        confirmBtn.frame = CGRect(x: btnW, y: titleHeight, width: btnW, height: bottomHeight)
        addSubview(confirmBtn)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        separatorView.frame = CGRect(x: 0, y: titleHeight, width: ScreenWidth, height: 1)
        addSubview(separatorView)
        
    }
}
