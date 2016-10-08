//
//  CustomTabBar.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

protocol CustomTarBarDelegate: NSObjectProtocol {
    func customTabBarClickedStartShow()
    func customTabBarClickedBtnAtIndex(index: Int)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTarBarDelegate?
    private var selectedBtn: UIButton?
    
    let showBtnW:CGFloat = 80
    var barItems: [UITabBarItem]? {
        didSet {
            var i:CGFloat = 0
            let itemW = (bounds.width - showBtnW) * 0.5
            for item in barItems! {
                let btn = UIButton(type: .Custom)
                btn.setImage(item.image, forState: .Normal)
                btn.setImage(item.selectedImage, forState: .Selected)
                btn.tag = Int(i)
                btn.frame = CGRect(x: i * (itemW + showBtnW) , y: 5, width: itemW, height: bounds.height)
                btn.addTarget(self, action: #selector(btnClicked), forControlEvents: .TouchUpInside)
                addSubview(btn)
                // 默认选择第一个按钮
                if i == 0 {
                    btnClicked(btn)
                }
                i = i + 1
            }
        }
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    @objc func startShow() {
       delegate?.customTabBarClickedStartShow()
    }
    
    @objc func btnClicked(btn: UIButton) {
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: {
            btn.imageView?.transform = CGAffineTransformMakeScale(2, 2)
            }) { (_) in
            btn.imageView?.transform = CGAffineTransformIdentity
        }
        
        selectedBtn?.selected = false
        btn.selected = true
        selectedBtn = btn
        
        delegate?.customTabBarClickedBtnAtIndex(btn.tag)
      
    }
}

// MARK: - UI
extension CustomTabBar {
    private func setupUI() {
        let bgImageView = UIImageView(frame: bounds)
        bgImageView.image = UIImage(named: "tab_bg")
        addSubview(bgImageView)
        
        let showButton = UIButton(type: .Custom)
        showButton.setImage(UIImage(named: "tab_launch"), forState: .Normal)
        showButton.bounds = CGRect(x: 0, y: 0, width: showBtnW, height: showBtnW)
        showButton.center = CGPoint(x: bounds.width * 0.5, y: showBtnW * 0.5 - 15)
        showButton.addTarget(self, action: #selector(startShow), forControlEvents: .TouchUpInside)
        addSubview(showButton)
    }
}
