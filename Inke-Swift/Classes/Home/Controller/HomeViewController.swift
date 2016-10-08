//
//  HomeViewController.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    ///MARK: - 属性
    private lazy var scrollView: UIScrollView = {
        var sv = UIScrollView(frame: self.view.bounds)
        sv.frame.origin.y = navHeight
        sv.frame.size.height = self.view.bounds.size.height - navHeight
        self.view.addSubview(sv)
        sv.delegate = self
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.pagingEnabled = true
        sv.bounces = false
        return sv
    }()
    
    private lazy var navTitleView: NavTitleView = NavTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVcs()
        setupUI()
        setupNav()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 默认选择热门: 第二个
        defaultSelect()
    }
    
    private func addChildVcs() {
        
        let collectVc = CollectTableViewController()
        addChildViewController(collectVc)
        collectVc.toHotBlock = { [unowned self] in
            self.defaultSelect()
        }
        
        let hotVc = HotTableViewController()
        addChildViewController(hotVc)
        
        let nearbyVc = NearbyViewController()
        addChildViewController(nearbyVc)

    }
    
    private func defaultSelect() {
        navTitleView.selectedBtnMoveToIndex(1)
        selectedChildVcAtIndex(1)
        scrollView.setContentOffset(CGPoint(x: ScreenWidth,y:0), animated: false)
    }
}

// MARK: - UI
extension HomeViewController {
    
    private func setupNav() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "title_button_search"), style: .Done, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "title_button_more"), style: .Done, target: self, action: #selector(more))
        
        navTitleView.titles = ["关注","热门","附近"]
        navTitleView.delegate = self
        navTitleView.frame = CGRect(x: 0, y: 0, width: ScreenWidth * 0.8, height: 44)
        navigationItem.titleView = navTitleView
    }
    
    private func setupUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        scrollView.backgroundColor = UIColor.grayColor()
        
        scrollView.contentSize = CGSize(width: CGFloat(self.childViewControllers.count) * ScreenWidth, height: 0)
        
    }
    
    @objc private func search() {
        let searchVc = SearchTableViewController()
        let nav = CustomNavigationController(rootViewController:searchVc)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    @objc private func more() {
        let messageVc = MessageViewController()
        presentViewController(messageVc, animated: true, completion: nil)
    }
    
    private func selectedChildVcAtIndex(index: Int){
        let vc = childViewControllers[index]
        if !vc.isViewLoaded() {
            scrollView.addSubview(vc.view)
        }
        
        vc.view.frame = CGRect(x: CGFloat(index) * ScreenWidth, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
    }
}

extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
    
    // 手动拖拽停止调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        selectedChildVcAtIndex(currentPage)
        navTitleView.selectedBtnMoveToIndex(currentPage)
    }
    
    // 代码设置contentOffset动画结束时调用
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    }
}

extension HomeViewController: NavTitleViewDelegate {
    func navTitleViewClickedAtIndex(index: Int) {
        selectedChildVcAtIndex(index)
        scrollView.setContentOffset(CGPoint(x:CGFloat(index) * ScreenWidth, y:0) , animated: true)
    }
}
