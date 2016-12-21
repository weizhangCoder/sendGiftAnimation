//
//  ZWGifContainerView.swift
//  GifAnimation
//
//  Created by zhangwei on 16/12/20.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit


private let  KChannelCount = 2
private let KChannelViewH :CGFloat = 40

private let KChannelViewMager :CGFloat = 10

class ZWGifContainerView: UIView {

    fileprivate lazy var channelViews:[ZWGifChannelView] = [ZWGifChannelView]()
    fileprivate lazy var cacheModels:[ZWGifModel] = [ZWGifModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}


extension ZWGifContainerView{
    fileprivate func setupUI(){
        
        let w : CGFloat = bounds.width
        let h : CGFloat = KChannelViewH
        let x : CGFloat = 0
        
        for i in 0 ..< KChannelCount {
            let y:CGFloat = (h + KChannelViewMager) * CGFloat(i)
            let channelView = ZWGifChannelView.loadFormNib()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            addSubview(channelView)
            channelView.alpha = 0.0
            channelViews.append(channelView)
            channelView.complectionCallback = { channelView in
                
                //判断数组里面有没有数据
                guard self.cacheModels.count != 0 else {
                    return
                }
                //1 取出缓存中的第一个模型
                let firstGifModel = self.cacheModels.first!
                self.cacheModels.removeFirst()
                //2.让闲置的channelView执行动画
                channelView.giftModel = firstGifModel
                //3 将剩余的和firstGifModel一样的模型放入到channelView的缓存中
                for i in (0..<self.cacheModels.count).reversed()
                {
                    let giftModel = self.cacheModels[i]
                    if giftModel.isEqual(firstGifModel)
                    {
                        channelView.addOnecToCache()
                        self.cacheModels.remove(at: i)
                    }
                }
                
                
            
                
            }
            
        }
    
    
    }
}
extension ZWGifContainerView{
    func showGiftModel(_ giftModel : ZWGifModel)  {
        //1 判断正在忙的channelView 和赠送的新的礼物channelView
        if let channelView = checkUseingChanelView(giftModel) {
            channelView.addOnecToCache()
            return
        }
        
        //2判断有没有闲置的view
        if let channelView = checkIdleChannelView() {
            channelView.giftModel = giftModel
            return
        }
        
        //3.添加数组中
        cacheModels.append(giftModel)
    }
    
    
    //判断是否有闲置的view
    fileprivate func checkIdleChannelView() -> ZWGifChannelView?{
    
        for channelView in channelViews {
            if channelView.ChanleStale == .idle {
                return channelView
            }
        }
        return nil
    
    }
    
    
    //判断是否有正在用的channelView
    fileprivate func checkUseingChanelView(_ giftModel : ZWGifModel) -> ZWGifChannelView?{
        for channelView in channelViews
        {
            if giftModel.isEqual(channelView.giftModel) && channelView.ChanleStale != .endAnimation
            {
                return channelView
            }
        }
        return nil
    
    }

}
