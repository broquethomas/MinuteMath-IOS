//
//  labelEffect.swift
//  FinalProject
//
//  Created by Broque on 11/19/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
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
    
    func pulsateEnd() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 2.0
        pulse.fromValue = 0.95
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = 1000
        pulse.initialVelocity = 0.8
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func fadeInOut(){
        self.alpha = 0.0
        UIView.animate(withDuration: 2.0, animations: {
            self.alpha = 1.0
        }) { (finished) in
            // fade out
            UIView.animate(withDuration: 2.0, animations: {
                self.alpha = 0.0
            })
        }
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
