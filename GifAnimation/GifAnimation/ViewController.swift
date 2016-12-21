//
//  ViewController.swift
//  GifAnimation
//
//  Created by zhangwei on 16/12/20.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var giftContainerView:ZWGifContainerView = ZWGifContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        giftContainerView.frame = CGRect(x: 0, y: 100, width: 250, height: 100)
        
        view.addSubview(giftContainerView)
        giftContainerView.backgroundColor = UIColor.lightGray
        
        
    }
    @IBAction func gift1(_ sender: UIButton) {
        let gift1 = ZWGifModel(senderName: "快手", senderURL: "icon4", giftName: "火箭", giftURL: "gift1")
        giftContainerView.showGiftModel(gift1)
    }
  
  
    @IBAction func gitf2(_ sender: UIButton) {
        let gift2 = ZWGifModel(senderName: "斗鱼", senderURL: "icon3", giftName: "飞机", giftURL: "gift2")
        giftContainerView.showGiftModel(gift2)
    }


    @IBAction func gift3(_ sender: UIButton) {
        let gift3 = ZWGifModel(senderName: "熊猫TV", senderURL: "icon2", giftName: "皇冠", giftURL: "gift3")
        giftContainerView.showGiftModel(gift3)
    }
  


}

