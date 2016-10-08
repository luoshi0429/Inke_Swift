//
//  LoveEmitter.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/4.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class LoveEmitter: NSObject {
    
    func emitterInView(view: UIView) {
        
        let loveWH:CGFloat = 30
        let loveView = LoveView(frame: CGRect(x: 0,y:ScreenHeight,width: loveWH,height: loveWH))
        view.addSubview(loveView)
        
        let randomDuration = arc4random() % 2 == 0 ? 4.0 : 3.0
        
        let keyAnim = CAKeyframeAnimation(keyPath: "position")
        let speed: CGFloat = 60
        keyAnim.duration = randomDuration
        let startX = ScreenWidth * 0.7
        let  startY = ScreenHeight - 50
        let startPoint = CGPoint(x: startX ,y:startY)
        
        let emitDistance: CGFloat = 100
        var currentY = startY - emitDistance
        let emitPoint = CGPoint(x:startX,y: currentY)
        var movePoint: CGPoint
        let delta: CGFloat = 30
        currentY = currentY - speed
        if arc4random() % 2 == 0 {
            movePoint = CGPoint(x: startX - delta, y: currentY )
        } else {
            movePoint = CGPoint(x: startX + delta, y: currentY)
        }
        
        currentY = currentY - speed
        let movePoint2 = CGPoint(x: startX, y: currentY)
        
        currentY = 80
        let endPoint = CGPoint(x: startPoint.x + loveWH, y: currentY )
        keyAnim.values = [NSValue(CGPoint:startPoint),NSValue(CGPoint: emitPoint),NSValue(CGPoint:movePoint),NSValue(CGPoint:movePoint2),NSValue(CGPoint:endPoint)]
        
        loveView.layer.addAnimation(keyAnim, forKey: nil)
        
        UIView.animateWithDuration(randomDuration, animations: { 
            loveView.alpha = 0.0
            }) { (_) in
                loveView.removeFromSuperview()
        }
    }

}


class LoveView: UIView {
    
    var color: UIColor = randomColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
    
        // 由顶部的凹点开始画 距离top 为 0.1*高度
        let beginY = frame.height * 0.1
        let halfW = frame.width * 0.5
        let halfH = frame.height * 0.5
        // 半圆的半径
        let circleRadius = sqrt(2) * (halfW - beginY) * 0.5
        let circleCenterY = halfH / 2 + beginY
        
        let rightCircleCenterX = (halfW - beginY) / 2 + halfW
        let leftCircleCenterX = beginY + (halfW - beginY) / 2
        let rightCircleCenter = CGPoint(x: rightCircleCenterX, y: circleCenterY)
        let leftCircleCenter = CGPoint(x: leftCircleCenterX, y: circleCenterY)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: halfW,y:rect.height))
        path.addLineToPoint(CGPoint(x: rect.width - beginY - 1,y: halfH + beginY))
        path.addArcWithCenter(rightCircleCenter, radius: circleRadius, startAngle: CGFloat(M_PI_4), endAngle: CGFloat(M_PI + M_PI_4), clockwise: false)

        
        path.moveToPoint(CGPoint(x: halfW,y:rect.height))
        path.addLineToPoint(CGPoint(x: beginY + 1,y: halfH + beginY))
        path.addArcWithCenter(leftCircleCenter, radius: circleRadius, startAngle: CGFloat(M_PI_2 + M_PI_4), endAngle: CGFloat(M_PI + M_PI_2 + M_PI_4 ), clockwise: true)
        color.setFill()
        path.fill()
    }
    
}
