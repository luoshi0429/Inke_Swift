//
//  LiveViewController.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import IJKMediaFramework
import SDWebImage
import SnapKit
class LiveViewController: UIViewController {
    
    var live:Live?
    var gifts: [Gift]?
        
    private lazy var contentView: LiveContentView = LiveContentView.contentView()
    private var player: IJKFFMoviePlayerController!
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: "mg_room_btn_guan_h"), forState: .Normal)
        let btnWH: CGFloat = 40
        let bottomMargin: CGFloat  = 10
        let leftMargin: CGFloat  = 20
        let btnY: CGFloat  = self.view.frame.height - bottomMargin - btnWH
        let btnX: CGFloat = self.view.frame.width - leftMargin - btnWH
        btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH)
        btn.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // 假装是visitor
        fetchVisitors()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏navBar
        navigationController?.navigationBar.hidden = true
        // 禁止默认的右滑返回
        navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // 显示navBar
        navigationController?.navigationBar.hidden = false
        // 开启右滑返回
        navigationController?.interactivePopGestureRecognizer?.enabled = true
        
        // 停止播放，不然会内存溢出
        player.pause()
        player.stop()
        player.shutdown()
    }
    
    private func fetchVisitors() {
        NetworkTool.shareNetworkTool.ik_get(IK_VisitorInfo, parameters: nil) { (successInfo, errorInfo) in
            if errorInfo != nil || successInfo == nil {
                LMLog(errorInfo)
                return
            }
            
            LMLog(successInfo)
            guard let visitorArr = successInfo!["lives"] as? [[String : AnyObject]] else {
                return
            }
            var tempArr: [Live] = []
            for dict in visitorArr {
                let live = Live(dict: dict)
                tempArr.append(live)
            }
            
            self.contentView.visitors = random() % 2 == 0 ? tempArr : tempArr + tempArr
//            self.contentView.visitors = tempArr
        }
    }

    @objc private func back() {
        navigationController?.popViewControllerAnimated(true)
    }
    
//    @objc private func swipeContentView(swipeGesture: UISwipeGestureRecognizer) {
//        
//    }
}

// MARK: - UI
extension LiveViewController {
    private func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        let url = NSURL(string: (live?.creator?.portrait!)!)
        let coverImageView = UIImageView(frame: view.bounds)
        coverImageView.userInteractionEnabled = true
        coverImageView.contentMode = .ScaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default_room"))
        view.addSubview(coverImageView)
        
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeContentView))
        
        // 创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .Dark)
        // 创建一个承载模糊效果的视图
        let blurEffectView = UIVisualEffectView(frame: view.bounds)
        blurEffectView.effect = blurEffect
        // 添加到需要模糊效果的view上
        coverImageView.addSubview(blurEffectView)
        
        guard let urlStr = live?.stream_addr else {
            return
        }
        player = IJKFFMoviePlayerController(contentURLString: urlStr, withOptions: nil)
        
        // 准备播放
        player.prepareToPlay()
        player.view.frame = view.bounds
        view.addSubview(player.view)
        
        contentView.frame = view.bounds
        contentView.live = live
        contentView.gifts = gifts
        contentView.giftViewPopedBlock = { [unowned self] in
            self.backBtn.hidden = true
        }
        contentView.giftViewHideBlock = { [unowned self] in
            self.backBtn.hidden = false
        }
        view.addSubview(contentView)
        
        // 退出按钮
        view.addSubview(backBtn)
        
    }
}