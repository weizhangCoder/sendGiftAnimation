//
//  ZWGifModel.swift
//  GifAnimation
//
//  Created by zhangwei on 16/12/20.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

class ZWGifModel: NSObject {
    var senderName : String = ""
    var senderURL : String = ""
    var giftName : String = ""
    var giftURL : String = ""
    
    init(senderName : String,senderURL : String,giftName : String,giftURL : String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ZWGifModel else {
           return false
        }
        guard object.giftName == giftName && object.senderName == senderName else {
            return false
        }
        
        return true
    }
    

}
