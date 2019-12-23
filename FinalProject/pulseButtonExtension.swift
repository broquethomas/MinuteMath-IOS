//
//  pulseButtonExtension.swift
//  FinalProject
//
//  Created by Broque on 11/17/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


extension UIButton{
    
    
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 4.0
        pulse.fromValue = 0.95
        pulse.toValue = 1.05
        pulse.autoreverses = true
        pulse.repeatCount = 1000
        pulse.initialVelocity = 0.4
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func pulsateQuick() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 0.95
        pulse.toValue = 1.05
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.8
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    func flashTwo() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1.0
        flash.fromValue = 1
        flash.toValue = 0.2
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = Float.infinity
        
        layer.add(flash, forKey: nil)
    }
    
    func flashPlus() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 0.0
        flash.toValue = 0.8
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 0
        
        layer.add(flash, forKey: nil)
    }

}
