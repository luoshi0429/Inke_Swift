//
//  GiftView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/5.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import SnapKit

class GiftView: UIView {
    
    var gifts: [Gift]? {
        didSet {
            
            guard let gs = gifts else{
                return
            }
            
            if gs.count > 0 {
                let pages = gs.count / 8 + 1
                pageControl.numberOfPages = pages
            }
            collectionView.reloadData()
        }
    }

    var sendGiftBlock: (gift: Gift) -> () = {
        gift in
        
    }
    
    private var selectedGift: Gift?
    private var selectedCell: GiftCell?
    private let maxCols = 4

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemW = ScreenWidth / CGFloat(self.maxCols)
        let itemH = giftCellHeight
        layout.itemSize = CGSize(width: itemW,height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.clearColor()
        cv.pagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var bottomView: UIView = UIView()
    private lazy var pageControl = UIPageControl()
    private lazy var sendBtn = UIButton(type: .Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        collectionView.reloadData()
        UIView.animateWithDuration(0.15) {
            self.frame.origin.y = ScreenHeight - self.frame.height
        }
    }
    
    func hide(hideComplition: () -> ()?) {
        UIView.animateWithDuration(0.15, animations: {
            self.frame.origin.y = ScreenHeight
            }) { (_) in
                hideComplition()
        }
    }
    
    @objc private func sendGift(sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "pops_gift_send_bg" ), forState: .Normal)
        
        if let gift = selectedGift {
            LMLog("送礼物...")
            sendGiftBlock(gift: gift)
        } else {
            HeadHud.showHUD("还没有选择礼物哦")
        }
    }
    
    // 截断响应链条
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        LMLog("touchesBegan")
    }
}

// MARK: - UI
extension GiftView {
    private func setupUI() {
        
        let bg = UIImageView()
        bg.backgroundColor = UIColor.blackColor()
        bg.alpha = 0.7
        addSubview(bg)
        
        collectionView.registerNib(UINib(nibName: "GiftCell", bundle: nil), forCellWithReuseIdentifier: "GiftCell")
        addSubview(collectionView)

        addSubview(bottomView)
        
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor =  UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor(red: 53 / 255.0, green: 56 / 255.0, blue: 58 / 255.0, alpha: 1.0)
        bottomView.addSubview(pageControl)
        
        let payBtn = UIButton(type: .Custom)
        payBtn.setTitle("充值:1000000 ", forState: .Normal)
        payBtn.setTitleColor(UIColor(red: 233.0 / 255.0, green: 220.0 / 255.0 , blue: 60.0 / 255.0, alpha: 1.0), forState: .Normal)
        payBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        bottomView.addSubview(payBtn)
        
        sendBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        sendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendBtn.setTitle("发送", forState: .Normal)
        sendBtn.setBackgroundImage(UIImage(named: "pops_gift_send_bg_grey"), forState: .Normal)
        sendBtn.addTarget(self, action: #selector(sendGift), forControlEvents: .TouchUpInside)
        bottomView.addSubview(sendBtn)
        
        // Constraints 
        bg.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        collectionView.snp_makeConstraints { (make) in
            make.top.leading.trailing.equalTo(0)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(0)
            make.height.equalTo(bottomViewHeight)
        }
        
        pageControl.snp_makeConstraints { (make) in
            make.centerX.equalTo(bottomView.snp_centerX)
            make.top.equalTo(0)
            make.width.equalTo(bottomView.snp_width)
            make.height.equalTo(18)
            
        }
        
        payBtn.snp_makeConstraints { (make) in
            make.leading.equalTo(15)
            make.centerY.equalTo(bottomView.snp_centerY)
        }
        
        sendBtn.snp_makeConstraints { (make) in
            make.width.equalTo(73)
            make.height.equalTo(28)
            make.trailing.equalTo(-10)
            make.centerY.equalTo(bottomView.snp_centerY)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GiftView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GiftCell", forIndexPath: indexPath) as! GiftCell
        cell.gift = gifts?[indexPath.row]
        return  cell
    }
}

// MARK: - UICollectionViewDelegate
extension GiftView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let gift = gifts?[indexPath.row] else {
            return
        }
        
        if let currentGift = selectedGift {
            currentGift.isSelected = false
            let currentIndex = gifts!.indexOf(currentGift)!
            if let currentCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: currentIndex, inSection: 0)) as? GiftCell {
                setCellTypeImage(currentGift, cell: currentCell)
            }
            
            if currentIndex == indexPath.item {
                return
            }
        }
        
        gift.isSelected = !gift.isSelected
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GiftCell
        setCellTypeImage(gift, cell: cell)
    }
    
    private func setCellTypeImage(gift: Gift,cell: GiftCell) {
        if gift.isSelected {
            selectedGift = gift
            sendBtn.setBackgroundImage(UIImage(named: "pops_gift_send_bg"), forState: .Normal)
            cell.typeImageView.image = UIImage(named: "gift_selected")
        } else {
            selectedGift = nil
            sendBtn.setBackgroundImage(UIImage(named: "pops_gift_send_bg_grey"), forState: .Normal)
            if gift.type == 1 {
                cell.typeImageView.image = UIImage(named: "pop_gift_lian")
            } else {
                cell.typeImageView.image = UIImage()
            }
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
    }
}
