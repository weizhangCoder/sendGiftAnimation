//
//  ZWGifChannelView.swift
//  GifAnimation
//
//  Created by zhangwei on 16/12/20.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

enum ZWGiftChannelStale {
    case idle
    case animating
    case willEnd
    case endAnimation
    
}

class ZWGifChannelView: UIView {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: ZWGifDigitLabel!
    
    var ChanleStale :ZWGiftChannelStale = .idle
    
    var complectionCallback :((ZWGifChannelView) -> Void)?
    
    //同一个人，同一个礼物记录
    fileprivate var cacheNumber : Int = 0
    //礼物当前的个数
    fileprivate var currentNumber : Int = 0
    
    
    
    var giftModel : ZWGifModel?{
        
        didSet{
            guard let giftModel = giftModel else {
                return
            }
            iconImageView.image = UIImage(named: giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物 : 【\(giftModel.giftName)】"
            giftImageView.image = UIImage(named: giftModel.giftURL)
            
            ChanleStale = .animating
            performAninatiom()
            
        }
    }
    
    
    


}

// MARK:- 前提是判断是否为同一人，同一个礼物  然后当动画即将消失的时候 再次展示X2
extension ZWGifChannelView{
    func addOnecToCache(){
        if ChanleStale == .willEnd {
         performDigitAnimation()
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        }else{
         cacheNumber += 1
        }

    }
    
    
    class func loadFormNib() -> ZWGifChannelView {
        return Bundle.main.loadNibNamed("ZWGifChannelView", owner: nil, options: nil)?.first as! ZWGifChannelView
    }
}
// MARK:- 开始执行动画
extension ZWGifChannelView{
    
    fileprivate func performAninatiom(){
        digitLabel.text = " x1 "
        digitLabel.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: { 
            self.alpha = 1.0
            self.frame.origin.x = 0
            
            }) { isFinished in
             
             self.performDigitAnimation()
        }
    
    }
    
    
    fileprivate func  performDigitAnimation(){
        currentNumber += 1
        digitLabel.text = " x\(currentNumber) "
        digitLabel.showDiggitAnimation{
            
            //文字展示完这里要判断缓存中是否有一样的
            if self.cacheNumber > 0{
               self.cacheNumber -= 1
               self.performDigitAnimation()
            }else{
            self.ChanleStale = .willEnd
            self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
                
            }
    
        }
    
    
    }
    
    
   //动画3秒后结束
    @objc fileprivate func performEndAnimation(){
    
        ChanleStale = .endAnimation
        
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
            
        }) { (isfinished) in
            
            self.cacheNumber = 0
            self.giftModel = nil
            self.frame.origin.x = -self.frame.width
            self.digitLabel.alpha = 0
            self.ChanleStale = .idle
            self.currentNumber = 0
            
            if let complectionCallback = self.complectionCallback{
                 complectionCallback(self)
            }
            
        }
    
    }

}


extension ZWGifChannelView{

    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }

}
