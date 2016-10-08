//
//  MessageViewController.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/4.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purpleColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissViewControllerAnimated(true, completion: nil)
    }



}
