//
//  Live.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class Live: NSObject {
    var city: String?
    var id: String?
    var name: String?  // live cell 下面的文字
    var stream_addr: String? // 直播地址
    var online_users: Int = -1
    var image: String?
    var creator: LiveCreator?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    // 过滤掉没有对应key的情况
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "creator" {
            creator = LiveCreator(dict: value as! [String : AnyObject])
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override var description: String {
        let keys = ["creator","name","city","online_users"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
}
