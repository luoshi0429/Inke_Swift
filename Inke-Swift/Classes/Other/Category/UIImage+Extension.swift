//
//  UIImage+Extension.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/4.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 圆形图片
    func circleImage() -> UIImage {
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: CGPointZero, size: self.size)
        CGContextAddEllipseInRect(ctx, rect)
        CGContextClip(ctx)
        drawInRect(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    // 带圆角的图片
    func imageWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: CGPointZero, size: self.size)
//        CGContextAddEllipseInRect(ctx, rect)
//        CGContextClip(ctx)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.addClip()
        CGContextAddPath(ctx, path.CGPath)
        drawInRect(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    // 生成纯色的图片
    class func imageWithColor(color: UIColor,imageSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(imageSize)
        let ctx = UIGraphicsGetCurrentContext()
        color.setFill()
        CGContextFillRect(ctx, CGRect(origin: CGPointZero, size: imageSize))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
        
    }
    
}
