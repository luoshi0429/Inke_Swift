//
//  Gift.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/5.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class Gift: NSObject {
    var name: String?
    var gold: Int = 0
    var image: String? {  // 显示用图片
        didSet {
            if let im = image {
                image = IK_imagePrefix + im 
            }
        }
    }
    var exp: Int = 0
    var type: Int = 0
    var id: Int = 0
    var icon: String? {
        didSet {
            if let ic = icon {
                icon = IK_imagePrefix + ic
            }
        }
    }
    
    var isSelected: Bool = false 
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    // 过滤没有对应key的情况
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["name","gold","type","id","isSelected"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
}
