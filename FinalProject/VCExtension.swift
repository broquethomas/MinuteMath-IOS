//
//  VCExtension.swift
//  FinalProject
//
//  Created by Broque on 11/20/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func fadeInNew() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
        fadeOut()
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
