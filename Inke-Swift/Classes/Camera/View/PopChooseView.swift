//
//  PopChooseView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

protocol PopChooseViewDelegate: NSObjectProtocol {
    func popChooseViewDidChooseLive()
    func popChooseViewDidChooseVideo()
}

class PopChooseView: UIView {
    
    weak var delegate: PopChooseViewDelegate?
    
    private lazy var containerView = UIView()
    private lazy var leftPopBtn: PopButton = PopButton(type: .Custom)
    private lazy var rightPopBtn: PopButton = PopButton(type: .Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func popView() {
        UIApplication.sharedApplication().windows.last!.addSubview(self)
        self.containerView.frame.origin.y = ScreenHeight - containerH

        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .CurveLinear, animations: {
            self.leftPopBtn.frame.origin.y = 0
            self.rightPopBtn.frame.origin.y = 0
            }, completion: nil)
    }
    
    @objc private func hide() {
        UIView.animateWithDuration(0.25, animations: { 
            self.containerView.frame.origin.y = ScreenHeight
            }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hide()
    }
    
    @objc private func chooseLive() {
        hide()
        delegate?.popChooseViewDidChooseLive()
    }

    @objc private func chooseVideo() {
        hide()
        delegate?.popChooseViewDidChooseVideo()
    }
}

// MARK: - UI
let containerH = (ScreenHeight - statusBarHeigth) / 3
extension PopChooseView {
    private func setupUI() {
        
        frame = ScreenFrame
        
        let closeBtnH: CGFloat = 49
        
        let topBtnH: CGFloat = containerH - closeBtnH
        let topBtnW = ScreenWidth / 2
        
        containerView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, containerH)
        containerView.backgroundColor = UIColor(red: 237 / 255.0, green: 231 / 255.0, blue: 229 / 255.0, alpha: 1.0)
        addSubview(containerView)
        
        let closeBtn = UIButton(type: .Custom)
        closeBtn.backgroundColor = UIColor.whiteColor()
        closeBtn.frame = CGRectMake(0, containerH - closeBtnH, ScreenWidth, closeBtnH)
        closeBtn.setImage(UIImage(named: "shortvideo_launch_close") , forState: .Normal)
        closeBtn.addTarget(self , action: #selector(hide), forControlEvents: .TouchUpInside)
        containerView.addSubview(closeBtn)
        
        let popBtnY = containerH - closeBtnH
        leftPopBtn.setTitle("直播", forState: .Normal)
        leftPopBtn.setImage(UIImage(named: "shortvideo_main_live"), forState: .Normal)
        leftPopBtn.frame = CGRectMake(0, popBtnY,topBtnW, topBtnH)
        leftPopBtn.addTarget(self, action: #selector(chooseLive), forControlEvents: .TouchUpInside)
        containerView.addSubview(leftPopBtn)
        
        rightPopBtn.setTitle("短视频", forState: .Normal)
        rightPopBtn.setImage(UIImage(named: "shortvideo_main_video"), forState: .Normal)
        rightPopBtn.frame = CGRectMake(topBtnW, popBtnY,topBtnW, topBtnH)
        rightPopBtn.addTarget(self, action: #selector(chooseVideo), forControlEvents: .TouchUpInside)
        containerView.addSubview(rightPopBtn)
    }
}
