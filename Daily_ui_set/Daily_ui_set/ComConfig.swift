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
                "name":"书签视图",
                "view":"JAMarkView",
                "frame":"100,100,20,30"
            ],
        ]
    }()
    
    // http://www.cocoachina.com/swift/20151207/14584.html
    static let shared = ComConfig()
}
