//
//  SettingViewController.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/8.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationItem.title = "设置"
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "title_button_back"), style: .Plain, target: self, action: #selector(back))
        
        let logoutBtn = UIButton(type: .Custom)
        logoutBtn.setTitle("退出登录", forState: .Normal)
        logoutBtn.setTitleColor(UIColor(red: 26 / 255.0, green: 200 / 255.0, blue: 180 / 255.0, alpha: 1.0), forState: .Normal)
        logoutBtn.setBackgroundImage(UIImage(named: "me_button"), forState: .Normal)
        logoutBtn.sizeToFit()
        logoutBtn.center = view.center
        logoutBtn.addTarget(self, action: #selector(logout), forControlEvents: .TouchUpInside)
        view.addSubview(logoutBtn)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let nav = navigationController as! CustomNavigationController
        nav.showFakeBar = true
    }
    
    @objc private func back() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func logout() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: LoginOrNotKey)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: LoginNotification, object: false))
    }

}
