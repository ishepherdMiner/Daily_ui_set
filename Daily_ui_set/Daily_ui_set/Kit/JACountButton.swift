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
    
    public var prompt_default : String = "发送验证码"
    public var prompt_before : String = "倒计时("
    public var prompt_after : String = ")"
    
    private var timer : Timer?
    private var callback : ((Bool)->())?
        
    public func start(completed:((Bool)->())?){
        if timer == nil {
            callback = completed
            isEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(exec), userInfo: nil, repeats: true)
            timer?.fire()
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func exec() {
        setTitle(prompt_before + String(cycle!) + prompt_after, for: .disabled)
        if cycle == 0 {
            isEnabled = true
            setTitle(prompt_default, for: .normal)
            stop()
            if callback != nil {
                callback!(true)
            }
            
        }
        cycle! -= 1
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            stop()
        }
    }
    
    deinit {
        if timer != nil {
            stop()
        }
    }
}
