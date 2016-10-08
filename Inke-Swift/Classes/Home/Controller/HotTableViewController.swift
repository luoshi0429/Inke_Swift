//
//  HotTableViewController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

class HotTableViewController: UITableViewController {
    
    private var lives:[Live]?
    private var gifts: [Gift]?
    private lazy var cachedHeights: NSCache = {
        let cache = NSCache()
        cache.countLimit = 5
        cache.totalCostLimit = 20
        return cache
    }()
    
    private lazy var hudView: UIView = {
        let bgView = UIView(frame: ScreenFrame)
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle:.Gray)
        indicatorView.center =  CGPoint(x: ScreenWidth * 0.5, y: ScreenHeight * 0.3)
        bgView.addSubview(indicatorView)
        indicatorView.startAnimating()
        return bgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchLiveData()
        fetchGiftData()
    }
    
    
    @objc private func fetchLiveData() {
        
         NetworkTool.shareNetworkTool.ik_get(IK_HotLive,parameters: nil) { (successInfo,errorInfo) in
            self.tableView.mj_header.endRefreshing()
//            LMLog(successInfo)
            self.hudView.removeFromSuperview()
            if errorInfo != nil || successInfo == nil {
                LMLog("获取热门数据失败")
                return
            }
            guard let livesArr = successInfo!["lives"] as? [[String : AnyObject]] else {
                return
            }
            var tempArr: [Live] = []
            for dict in livesArr {
                let live = Live(dict: dict)
                tempArr.append(live)
            }
            self.lives = tempArr
            self.tableView.reloadData()
            
        }
    }
    
    private func fetchGiftData() {
        NetworkTool.shareNetworkTool.ik_get(IK_giftInfo, parameters: nil) { (successInfo, errorInfo) in
            
            if errorInfo != nil || successInfo == nil {
                LMLog(errorInfo)
                return
            }
            
//            LMLog(successInfo)
            guard let giftArr = successInfo!["gifts"] as? [[String : AnyObject]] else {
                return
            }
            var tempArr: [Gift] = []
            for dict in giftArr {
                let gift = Gift(dict: dict)
                tempArr.append(gift)
            }
            self.gifts = tempArr
            self.tableView.reloadData()
        }
     }
}

// MARK: - Table view data source
extension HotTableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 如果live 的count为空 则返回 0
        return lives?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LiveCell") as! LiveCell
        cell.selectionStyle = .None
        cell.live = lives![indexPath.row]
        return cell
    }
}

/// MARK: - Table View Delegate
extension HotTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         let live = lives![indexPath.row]
        
        if let heigth = cachedHeights.objectForKey(live.id!) as? CGFloat{
            return heigth
        }
        
        let topViewH: CGFloat = 60
        var bottomViewH: CGFloat = 0
        
        if live.name?.characters.count > 0 {
            bottomViewH = 30
        }
        let margin: CGFloat = 2
        let cellHeight = topViewH + ScreenWidth + bottomViewH + margin
        
        cachedHeights.setObject(cellHeight, forKey: live.id!)
        
        return cellHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let live =  lives?[indexPath.row] else {
            HeadHud.showHUD("数据暂未加载完毕")
            return
        }
        let liveVc = LiveViewController()
        liveVc.live = live
        liveVc.gifts = gifts
        navigationController?.pushViewController(liveVc, animated: true)
    }
}

// MARK: - UI
extension HotTableViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        
        tableView.registerNib(UINib(nibName: "LiveCell",bundle: nil), forCellReuseIdentifier: "LiveCell")
        tableView.separatorStyle = .None
        tableView.addSubview(hudView)

        var idleImgs: [UIImage] = []
        var pullImgs: [UIImage] = []
        for i in 1...29 {
            
            let imgName = i < 10 ? "refresh_fly_000\(i)" : "refresh_fly_00\(i)"
            guard let path = NSBundle.mainBundle().pathForResource(imgName, ofType: "png") else {
                continue
            }
            guard let image = UIImage(contentsOfFile: path) else {
                continue
            }
            if i < 11 {
                idleImgs.append(image)
            } else {
                pullImgs.append(image)
            }
        }
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(fetchLiveData))
        header.setImages(pullImgs, forState: .Pulling)
        header.setImages(pullImgs, forState: .Refreshing)
        header.setImages(idleImgs, forState: .Idle)
        header.lastUpdatedTimeLabel.hidden = true
        header.stateLabel.hidden = true
        tableView.mj_header = header
    }
}


