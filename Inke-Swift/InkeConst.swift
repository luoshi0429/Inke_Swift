//
//  InkeConst.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

/// MARK: 尺寸相关
let ScreenFrame = UIScreen.mainScreen().bounds
let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height

let navBarHeight: CGFloat = 44
let statusBarHeigth: CGFloat = 20
let navHeight: CGFloat = 64

let tabBarHeight: CGFloat = 65

let giftViewHeight: CGFloat = 250
let giftCellHeight: CGFloat = 100
let bottomViewHeight: CGFloat = 50


let LoginOrNotKey = "LoginOrNotKey"

/// MARK: NotificationKey
let LoginNotification = "LoginNotification"


func randomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
}
