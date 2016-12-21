//
//  ZWGifDigitLabel.swift
//  GifAnimation
//
//  Created by zhangwei on 16/12/20.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

class ZWGifDigitLabel: UILabel {

    override func draw(_ rect: CGRect) {
        //1 获取上下文
        let connext = UIGraphicsGetCurrentContext()
        //2 设置属性
        connext?.setLineWidth(5)
        connext?.setLineJoin(.round)
        connext?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        super.drawText(in: rect)
        
        connext?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        
        super.drawText(in: rect)
        
    }
    //如果是逃逸闭包，就用@escaping表示。比如下面的一段代码，complextion在函数执行完后0.25秒才执行，所以是逃逸闭包。延时执行的就是逃逸闭包
    func showDiggitAnimation(_ complextion : @escaping ()->()){
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            //ddKeyframeWithRelativeStartTime中的startTime和relativeDuration都是相对与整个关键帧动画的持续时间（这里是2秒）的百分比，设置成0.5就代表2*0.5＝1（秒）。
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: { 
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
            
        }) { (isFinished) in
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: { 
                 self.transform = CGAffineTransform.identity
                }, completion: { (isFinished) in
                    complextion()
            })
            
        }
        
        
    }
    
    
//    func showDigitAnimation(_ complection : @escaping () -> ()) {
//        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
//                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//            })
//            }, completion: { isFinished in
//                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
//                    self.transform = CGAffineTransform.identity
//                    }, completion: { (isFinished) in
//                        complection()
//                })
//        })
//        
//    }


}
