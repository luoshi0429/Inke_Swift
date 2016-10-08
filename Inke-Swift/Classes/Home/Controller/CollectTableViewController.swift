//
//  CollectTableViewController.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class CollectTableViewController: UITableViewController {
    
    var toHotBlock: () -> () = {}
    
    private lazy var noCollectionView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "live_empty_bg"))
        imageView.center.x = self.tableView.center.x
        imageView.frame.origin.y =  30
        v.addSubview(imageView)
        
        let toHotBtn = UIButton(type: .Custom)
        toHotBtn.setTitle("去看看最新精彩直播", forState: .Normal)
        toHotBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        toHotBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        toHotBtn.setBackgroundImage(UIImage(named: "default_button"), forState: .Highlighted)
        toHotBtn.addTarget(self, action: #selector(toHotVc), forControlEvents: .TouchUpInside)
        toHotBtn.sizeToFit()
        toHotBtn.frame.size.width = toHotBtn.frame.width + 40
        toHotBtn.center.x = imageView.center.x
        toHotBtn.frame.origin.y = CGRectGetMaxY(imageView.frame) + 30
        v.addSubview(toHotBtn)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = .None
        
        noCollectionView.frame = tableView.bounds
        tableView.addSubview(noCollectionView)
    }
    
    @objc private func toHotVc() {
        toHotBlock()
    }
}
