//
//  ContainerViewController.swift
//  Daily_ui_set
//
//  Created by Jason on 11/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    public var sView : UIView?
    public var orderId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let frameVal = ComConfig.shared.dataList[orderId!]["frame"]
        let frameGroup = frameVal?.components(separatedBy: ",")
        var frames = [CGFloat]()
        for v in frameGroup! {
            frames.append(CGFloat((v as NSString).doubleValue))
        }
        sView?.frame = CGRect(x: frames[0], y: frames[1], width: frames[2], height: frames[3])
        view.addSubview(sView!)
        
        if let rgbValue = ComConfig.shared.dataList[orderId!]["bgcolor"] {
            sView?.backgroundColor = UIColor.color(hexVal: Int(rgbValue,radix:16)!)
        }else {
            sView?.backgroundColor = UIColor.clear
        }
                
        if let action = ComConfig.shared.dataList[orderId!]["launch"] {
            /// bla bla bla
            let _ = sView?.perform(NSSelectorFromString(action), with: nil)
            /// bla bla bla
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
