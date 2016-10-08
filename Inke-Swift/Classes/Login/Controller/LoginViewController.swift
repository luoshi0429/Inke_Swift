//
//  LoginViewController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topCloundLeftCons: NSLayoutConstraint!
    @IBOutlet weak var middleCloudLeftCons: NSLayoutConstraint!
    @IBOutlet weak var bottomCloudLeftCons: NSLayoutConstraint!
    
    @IBOutlet weak var bottomCloudView: UIImageView!
    @IBOutlet weak var middleCloudView: UIImageView!
    @IBOutlet weak var topCloudView: UIImageView!
    
    private var timer: NSTimer? = nil
    private lazy var hudView: UIView = {
        let bgView = UIView(frame: ScreenFrame)
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle:.Gray)
        indicatorView.center =  CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.5)
        bgView.addSubview(indicatorView)
        indicatorView.startAnimating()
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    @IBAction func qqLogin(sender: UIButton) {
        login()
    }
    
    @IBAction func sinaLogin(sender: UIButton) {
        login()
    }

    @IBAction func wechatLogin(sender: UIButton) {
        login()
    }
    
    @IBAction func mobileLogin(sender: UIButton) {
        login()
    }
    
    private func login() {
        view.addSubview(hudView)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.hudView.removeFromSuperview()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: LoginOrNotKey)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: LoginNotification, object: nil))
        }
    }
}

// MARK: - UI
extension LoginViewController {
    private func setupUI() {
        
        bottomCloudLeftCons.constant = ScreenWidth
        middleCloudLeftCons.constant = ScreenWidth
        topCloundLeftCons.constant = ScreenWidth
        view.layoutIfNeeded()
        
        beginAnim()
    }
    
    // 开始动画
    private func beginAnim() {
        
        let topCloudWidth: CGFloat = 230
        
        let topAnim = CABasicAnimation(keyPath: "position.x")
        topAnim.fromValue = ScreenWidth + topCloudWidth
        topAnim.toValue = -topCloudWidth
        topAnim.duration = 22.0
        topAnim.repeatCount = MAXFLOAT
        topCloudView.layer.addAnimation(topAnim, forKey: nil)
        
        let middleAnim = CABasicAnimation(keyPath: "position.x")
        middleAnim.fromValue = ScreenWidth + topCloudWidth
        middleAnim.toValue = -topCloudWidth
        middleAnim.duration = 18.0
        middleAnim.repeatCount = MAXFLOAT
        middleCloudView.layer.addAnimation(middleAnim, forKey: nil)
        
        let bottomAnim = CABasicAnimation(keyPath: "position.x")
        bottomAnim.fromValue = ScreenWidth + topCloudWidth
        bottomAnim.toValue = -topCloudWidth
        bottomAnim.duration = 15.0
        bottomAnim.repeatCount = MAXFLOAT
        bottomCloudView.layer.addAnimation(bottomAnim, forKey: nil)
    }
}
