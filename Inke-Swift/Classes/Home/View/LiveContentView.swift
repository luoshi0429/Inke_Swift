//
//  LiveContentView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/4.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SDWebImage

class LiveContentView: UIView {
    
    // 外部属性
    var gifts: [Gift]?
    var live: Live? {
        didSet {

            iconImageView.image = UIImage(named: "default_head")?.circleImage()
            if let url =  NSURL(string: live?.creator?.portrait ?? "") {
                SDWebImageManager.sharedManager().downloadWithURL(url, options: .RetryFailed, progress: nil, completed: { (image, error, _, _) in
                    if error != nil || image == nil {
                        return
                    }
                    self.iconImageView.image = image.circleImage()
                })
            }
            onlineCountLabel.text = "\(live?.online_users ?? 0)"
        }
    }
    var visitors: [Live]? {
        didSet {
            visitorCollectionVIew.reloadData()
        }
    }
    
    var giftViewPopedBlock: () -> ()? = {
        () -> () in
    }
    
    var giftViewHideBlock: () -> ()? = {
        () -> () in
    }
    // 视图属性
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineCountLabel: UILabel!
    @IBOutlet weak var visitorCollectionVIew: UICollectionView!
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var ticketView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var bottonViewHeightCons: NSLayoutConstraint!
    
    // 私有属性
    private var giftViewShowed: Bool = false
    private var currentGift: Gift?
    
    private lazy var giftView: GiftView = {
        let gv = GiftView()
        gv.gifts = self.gifts
        gv.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: giftViewHeight)
        gv.sendGiftBlock = {[unowned self]
            gift in
            
            if gift.type == 1 {
                self.typeOneAnim(gift)
                return
//                guard let currentGift = self.currentGift else {
//                    self.typeOneAnim(gift)
//                    return
//                }
//
//                if gift == currentGift {
//                    
//                }
            }
            
            if gift.type == 2 {
                let giftTwoView = GiftTypeTwoView()
                giftTwoView.giftImage = gift.image
                if let count = self.visitors?.count {
                    if count != 0 {
                        var randomIndex = arc4random_uniform(UInt32((count)))
                        randomIndex = randomIndex == 0 ? 0 : randomIndex - 1
                        giftTwoView.senderNick = self.visitors?[Int(randomIndex)].creator?.nick
                    }
                }
                self.insertSubview(giftTwoView, atIndex: 0)
                giftTwoView.beginAnim()
                
            }
        }
        self.addSubview(gv)
        return gv
    }()
    
    class func contentView() -> LiveContentView {
        let contentView = NSBundle.mainBundle().loadNibNamed("LiveContentView", owner: self, options: nil).last as! LiveContentView
        return contentView
    }
    
    override func awakeFromNib() {
        setupUI()
    }
    
    let giftMargin:  CGFloat = 80
    var giftY: CGFloat = ScreenHeight - giftViewHeight
    private func typeOneAnim(gift: Gift) {
        if giftY > 130 {
            giftY = giftY - giftMargin
        } else {
            giftY = ScreenHeight - giftViewHeight - giftMargin
        }
        
        let giftTypeOneView = GiftTypeOneView()
        let giftW: CGFloat = 250
//        let giftY: CGFloat = 160
        let giftH: CGFloat = 55
        giftTypeOneView.frame = CGRect(x: -giftW, y: giftY, width: giftW, height: giftH)
        giftTypeOneView.gift = gift
        giftTypeOneView.count = 1 
        if let count = visitors?.count {
            if count != 0 {
                var randomIndex = arc4random_uniform(UInt32((count)))
                randomIndex = randomIndex == 0 ? 0 : randomIndex - 1
                giftTypeOneView.visitor = visitors?[Int(randomIndex)]
            }
        }
        
        self.addSubview(giftTypeOneView)
        giftTypeOneView.begin()
    }
}

/// MARK: - action
extension LiveContentView {
    
    @IBAction func ticketClicked(sender: UIButton) {
        LMLog("")
    }
    
    @IBAction func chatClicked(sender: UIButton) {
        LMLog("")
    }
    
    @IBAction func messageClicked(sender: UIButton) {
        LMLog("")
    }
    
    @IBAction func giftClicked(sender: UIButton) {
        
        giftViewShowed = true
        giftViewPopedBlock()
        self.bottomViewBottomCons.constant = -self.bottonViewHeightCons.constant
        UIView.animateWithDuration(0.1, animations: {
            self.bottomView.layoutIfNeeded()
            }) { (_) in
                self.giftView.show()
        }
    }
    
    @IBAction func shareClicked(sender: UIButton) {
        LMLog("")
        
    }
    
    @objc private func iconTapped() {
        LMLog("")
    }
    
    // 点亮
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if giftViewShowed {
            giftViewShowed = false
            giftView.hide({ () -> () in
                self.giftViewHideBlock()
                self.bottomViewBottomCons.constant = 0
                UIView.animateWithDuration(0.1, animations: {
                    self.bottomView.layoutIfNeeded()
                })
            })
        } else {
            LoveEmitter().emitterInView(self)
        }
    }
    
}

// MARK: - UI
extension LiveContentView {
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        iconImageView.addGestureRecognizer(tapGesture)
        
        profileView.layer.cornerRadius = 35 * 0.5
        profileView.layer.masksToBounds = true
        
        ticketView.layer.cornerRadius = 25 * 0.5
        ticketView.layer.masksToBounds = true
        
        visitorCollectionVIew.registerClass(LiveVisitorCell.self, forCellWithReuseIdentifier: "LiveVisitorCell")
    }
}

extension LiveContentView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visitors?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LiveVisitorCell", forIndexPath: indexPath) as! LiveVisitorCell
        let visitor = visitors?[indexPath.row]
        cell.iconUrl = visitor?.creator?.portrait
        return cell
    }
}