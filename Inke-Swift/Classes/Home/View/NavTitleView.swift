//
//  NavTitleView.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

protocol NavTitleViewDelegate: NSObjectProtocol {
    func navTitleViewClickedAtIndex(index: Int)
}

class NavTitleView: UIView {
    
    /// MARK: - 外部属性
    weak var delegate: NavTitleViewDelegate?
    var titles: [String]? {
        didSet {
            guard let ts = titles else {
                return
            }
            
            if ts.count % 2 != 0 && ts.count >= 2{
                arrowIndex = ts.count / 2
            }
            
            var i = 0
            for title in ts {
                let btn = UIButton(type: .Custom)
                btn.tag = i
                btn.setTitle(title, forState: .Normal)
                btn.titleLabel?.font = UIFont.systemFontOfSize(15)
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                btn.setTitleColor(UIColor(red: 0,green: 0,blue: 0,alpha: 0.3), forState: .Highlighted)
                btn.sizeToFit()
                btn.addTarget(self, action: #selector(btnClick), forControlEvents: .TouchUpInside)
                addSubview(btn)
                titleBtnArray.append(btn)
                i = i + 1
            }
        }
    }
    
    /// MARK: 私有属性
    private lazy var bottomLineView: UIImageView = UIImageView()
    private var arrowIndex: Int = 0
    private var titleBtnArray: [UIButton] = []
    private let bottomMargin: CGFloat = 6
    private let bottomLineHeight: CGFloat = 2
    private let bottomArrowHeight: CGFloat = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    @objc private func btnClick(btn: UIButton) {
        bottomViewAnim(btn)
        delegate?.navTitleViewClickedAtIndex(btn.tag)
       
    }
    
    private func bottomViewAnim(btn: UIButton) {
        if arrowIndex != 0 && arrowIndex == btn.tag{
            bottomLineView.image = UIImage(named: "live_area_drop")
            bottomLineView.backgroundColor = UIColor.clearColor()
            let arrowW: CGFloat = 12
            let arrowH: CGFloat = 6
            let arrowX = btn.frame.minX + btn.frame.width * 0.5 - arrowW * 0.5
            bottomLineView.frame.size = CGSize(width: arrowW,height: arrowH)
            UIView.animateWithDuration(0.15, animations: {
                self.bottomLineView.frame.origin.x = arrowX
            })
            
        } else {
            bottomLineView.image = UIImage()
            bottomLineView.backgroundColor = UIColor.whiteColor()
            bottomLineView.frame.size = CGSize(width: btn.frame.width, height: bottomLineHeight)
            UIView.animateWithDuration(0.15, animations: {
                self.bottomLineView.frame.origin.x = btn.frame.minX
            })
        }
    }
    
    /// MARK: - 外部方法
    func selectedBtnMoveToIndex(index:Int) {
        bottomViewAnim(titleBtnArray[index])
    }
}

// MARK: - UI
extension NavTitleView {
    private func setupUI() {        
        bottomLineView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomLineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let firstBtn = titleBtnArray.first else {
            return
        }
        
        bottomLineView.frame.origin.y =  firstBtn.frame.maxY
        
        let btnW = frame.width / CGFloat(titleBtnArray.count)
        let btnY = (frame.height - bottomMargin) * 0.5
        for (index,btn) in titleBtnArray.enumerate() {
            btn.center = CGPoint(x: btnW * CGFloat(index) + btnW * 0.5, y: btnY)
        }
    }
}
