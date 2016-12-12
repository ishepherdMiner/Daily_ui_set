//
//  ComConfig.swift
//  Daily_knowledge_set
//
//  Created by Jason on 08/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ComConfig: NSObject {
    open let moduleName = "Daily_ui_set"
    public lazy var dataList = {
        return [
            [
                "name":"书签",
                "view":"JAMarkView",
                "frame":"100,100,20,30"
            ],
            [
                "name":"倒计时",
                "view":"JACountButton",
                "frame":"100,100,100,30",
                "launch":"startWithCompleted:",
                "bgcolor":"ffe8d0"
            ]
        ]
    }()
    
    // http://www.cocoachina.com/swift/20151207/14584.html
    static let shared = ComConfig()
}

extension UIColor {
    class func color(hexVal:Int) -> UIColor? {
        return UIColor(colorLiteralRed: Float.init((hexVal & 0xFF0000) >> 16)/255.0, green: Float.init((hexVal & 0xFF00) >> 8)/255.0, blue: Float.init(hexVal & 0xFF)/255.0, alpha: 1.0)
    }
}
