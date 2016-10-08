//
//  MyLiveEndView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class MyLiveEndView: UIView {
    
    var backToHomeBlock: () -> () = {
        
    }
    
    class func myLiveEndView() -> MyLiveEndView {
        let view = NSBundle.mainBundle().loadNibNamed("MyLiveEndView", owner: self, options: nil).last as! MyLiveEndView
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func backToHome(sender: UIButton) {
        backToHomeBlock()
    }
}
