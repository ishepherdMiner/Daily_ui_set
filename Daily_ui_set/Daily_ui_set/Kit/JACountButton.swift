//
//  JACountButtom.swift
//  Daily_ui_set
//
//  Created by Jason on 12/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class JACountButton: UIButton {
    
    @IBInspectable open var cycle : Int? = 20
    
    public var promptDefault : String = "发送验证码"
    public var promptLeft    : String = "倒计时("
    public var promptRight   : String = ")"
    
    private var timer : Timer?
    private var callback : ((Bool)->())?
    
    public func fire(completed:((Bool)->())?){
        if timer == nil {
            callback = completed
            isEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(exec), userInfo: nil, repeats: true)
            timer?.fire()
        }
    }
    
    public func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func exec() {
        setTitle(promptLeft + String(cycle!) + promptRight, for: .disabled)
        if cycle == 0 {
            isEnabled = true
            setTitle(promptDefault, for: .normal)
            invalidate()
            if callback != nil {
                callback!(true)
            }
            
        }
        cycle! -= 1
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            invalidate()
        }
    }
    
    deinit {
        if timer != nil {
            invalidate()
        }
    }
}
