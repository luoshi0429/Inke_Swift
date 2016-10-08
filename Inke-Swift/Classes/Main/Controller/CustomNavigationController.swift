//
//  CustonNavigationController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    var showFakeBar: Bool? {
        didSet {
            if showFakeBar == true {
                self.navigationBar.hidden = true
                
                guard let lastVc = childViewControllers.last else {
                    return
                }
                fakeBar.popNavigationItemAnimated(false)
                fakeBar.pushNavigationItem(navigationItem, animated: true)
                lastVc.view.addSubview(fakeBar)
            }
        }
    }
    private lazy var fakeBar: UINavigationBar = {
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: navHeight))
        bar.barTintColor = self.navigationBar.barTintColor
        bar.tintColor = self.navigationBar.tintColor
        return bar
    }()

    private var popDelegate: AnyObject? = nil
  
    override class func initialize() {
        let bar = UINavigationBar.appearance()
        
        bar.tintColor = UIColor.whiteColor()
        bar.barTintColor = UIColor(red: 26 / 255.0, green: 200 / 255.0, blue: 180 / 255.0, alpha: 1.0)
        
        bar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),NSFontAttributeName : UIFont.boldSystemFontOfSize(17)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //恢复系统自带的右滑功能
        popDelegate = interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0  {
             viewController.hidesBottomBarWhenPushed = true
        }

        super.pushViewController(viewController, animated: animated)
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == childViewControllers[0] {
            interactivePopGestureRecognizer?.delegate = popDelegate as? UIGestureRecognizerDelegate
        } else {
            interactivePopGestureRecognizer?.delegate = nil
            
        }
    }
}
