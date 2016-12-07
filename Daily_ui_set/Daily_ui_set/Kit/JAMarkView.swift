//
//  YQLPinView.swift
//  ShareQ
//
//  Created by Jason on 05/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class JAMarkView: UIView {

    // 标题内容
    @IBInspectable open var content: NSString?
    @IBInspectable open var contentColor: UIColor? = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable open var bgColor: UIColor? = #colorLiteral(red: 0.9266257882, green: 0.4446177781, blue: 0.5246757269, alpha: 1)
    
    open var contentFont: UIFont? = UIFont(name: "Helvetica Neue", size: 9)
    open var contentParaStyle: NSMutableParagraphStyle? = NSMutableParagraphStyle()
    open var contentSkew: CGFloat? = 0.1 // 倾斜度
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor = UIColor.clear
        
        let w : CGFloat = frame.width
        let h : CGFloat = frame.height
    
        let context:CGContext =  UIGraphicsGetCurrentContext()!;
        
        // 抗锯齿设置
        context.setAllowsAntialiasing(true)
        context.setFillColor(bgColor!.cgColor)
        context.beginPath()
        
        context.move(to: CGPoint(x:0,y:0))
        context.addLine(to: CGPoint(x:0,y:h))
        context.addLine(to: CGPoint(x:(w * 0.5),y:(h - 5)))
        context.addLine(to: CGPoint(x:w,y:h))
        context.addLine(to: CGPoint(x:w,y:0))
        context.addLine(to: CGPoint(x:0,y:0))
        
        context.drawPath(using:.fill)
        let fieldColor: UIColor = contentColor!
        let fieldFont = contentFont!
        let paraStyle = contentParaStyle!
        let skew = contentSkew!
        
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: fieldColor,
            NSParagraphStyleAttributeName: paraStyle,
            NSObliquenessAttributeName: skew,
            NSFontAttributeName: fieldFont
        ]
        
        content?.draw(in: CGRect(x:0.0,y:0.0,width:w,height:h), withAttributes: attributes as? [String : Any])
    }
}
