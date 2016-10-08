//
//  LiveCreator.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class LiveCreator: NSObject {
    var emotion: String?
    var desc: String?  // description
    var id: Int = -1
    var nick: String?
    var location: String?
    var birth: String?
    var hometown: String?
    var portrait: String? {
        didSet {
            guard let por = portrait else {
                return
            }
            portrait = IK_imagePrefix + por
        }
    }

    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    // 过滤没有对应key的情况
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "description" {
            desc = value as? String
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override var description: String {
        let keys = ["nick","id","location","hometown","desc"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
}
