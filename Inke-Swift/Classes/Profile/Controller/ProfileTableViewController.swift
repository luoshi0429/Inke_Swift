//
//  ProfileTableViewController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileTableViewController: UITableViewController {
    
    private lazy var headerImageView = UIImageView()
    private lazy var profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false 
    }
}

// MARK: - UI
extension ProfileTableViewController {
    private func setupUI() {
        
        view.frame = ScreenFrame
        tableView.backgroundColor = UIColor(red: 244 / 255.0, green: 249 / 255.0 , blue: 250 / 255.0, alpha: 1.0)
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: headerHeight)
        tableView.tableHeaderView = headerView
        
        headerImageView.contentMode = .ScaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.sd_setImageWithURL(NSURL(string: "http://wx.qlogo.cn/mmopen/C9QznKczMm3UpNPVFRfFlGFpQnkg3qcfsWEmQlBa9Ua0GecGptYdmnC7qgnzY5wn4A9JvH6T9eNKicicqMJjuaRTdAE1t0fJ7ia/0"))
        headerImageView.frame = headerView.bounds
        headerView.addSubview(headerImageView)
        
        SDWebImageManager.sharedManager().downloadImageWithURL(NSURL(string: "http://wx.qlogo.cn/mmopen/C9QznKczMm3UpNPVFRfFlGFpQnkg3qcfsWEmQlBa9Ua0GecGptYdmnC7qgnzY5wn4A9JvH6T9eNKicicqMJjuaRTdAE1t0fJ7ia/0"), options: .RetryFailed, progress: nil, completed: { (image, error, _, _, _) in
            if error != nil || image == nil {
                return
            }
            self.profileImageView.image = image.circleImage()
        })
        profileImageView.frame.size = CGSize(width: 60, height: 60)
        profileImageView.center = headerView.center
        headerView.addSubview(profileImageView)
    }
}

// MARK: - UITableViewDelegate
extension ProfileTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 2 {
            navigationController?.pushViewController(SettingViewController(), animated: true)
        } 
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY >= 20 {
            headerImageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: headerHeight)
            return
        }
        
        headerImageView.frame = CGRect(x:offsetY , y: offsetY, width: ScreenWidth - 2 * offsetY , height: headerHeight - offsetY )
    }
}