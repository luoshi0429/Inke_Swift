//
//  CustomViewController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var items: [UITabBarItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVcs()
        setupTabBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for subV in tabBar.subviews {
            if !subV.self.isKindOfClass(CustomTabBar.self) {
                subV.removeFromSuperview()
            }
        }
    }
}

// MARK: - UI  
// 扩展中不能有存储属性
extension CustomTabBarController {
    
    private func addChildVcs() {
        addOneChildVc("HomeViewController", imageName: "tab_live")
        addOneChildVc("ProfileTableViewController", imageName: "tab_me")
    }
    
    private func addOneChildVc(childVcStr: String, imageName:String) {
                
        // 命名空间
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]  as! String
        //
        let clsName =  namespace + "." + childVcStr
        guard let cls = NSClassFromString(clsName) else {
            return
        }
        
        guard let vcClass = cls as? UIViewController.Type else {
            return
        }
        
        let vc = vcClass.init()
    
        let selectedImageName = imageName + "_p" ;
        vc.tabBarItem.image = UIImage(named:imageName)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        items.append(vc.tabBarItem)
        
        let nav = CustomNavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }
    
    private func setupTabBar() {
        // 去掉tabbar上面的分割线
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        // 添加自定义的tabbar
//        let customTabBar = CustomTabBar(frame: tabBar.bounds)
        let customTabBar = CustomTabBar(frame: CGRect(x: 0,y: 49-tabBarHeight,width: tabBar.bounds.width,height: tabBarHeight))
        customTabBar.barItems = items
        customTabBar.delegate = self
        tabBar.addSubview(customTabBar)
    }
}

extension CustomTabBarController: CustomTarBarDelegate {
    func customTabBarClickedStartShow() {
        let popView = PopChooseView()
        popView.delegate = self
        popView.popView()
    }
    
    func customTabBarClickedBtnAtIndex(index: Int) {
        selectedIndex = index
    }
}

extension CustomTabBarController: PopChooseViewDelegate {
    func popChooseViewDidChooseLive() {
        let myLiveVc = MyLiveViewController()
        presentViewController(myLiveVc, animated: true, completion: nil)
    }
    
    
    func popChooseViewDidChooseVideo() {
        LMLog("短视频...")
    }
}