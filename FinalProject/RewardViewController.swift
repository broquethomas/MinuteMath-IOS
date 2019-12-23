//
//  RewardViewController.swift
//  FinalProject
//
//  Created by Broque on 11/14/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit
import Lottie

class RewardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var tempAnswer = 0;
    
    @IBOutlet weak var gradient: UIViewX!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var rewardAnswer: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var chicken: LOTAnimationView!
    
    @IBOutlet weak var submitOutlet: UIButton!
    var colors = Utility.sharedInstance.getColorArray()
    var index = -1
    
    
    func animateBackground(){
        overView.layer.cornerRadius = 30
        overView.layer.masksToBounds = true
        index = index == (colors.count-1) ? 0 : index+1
        UIView.transition(with: gradient, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradient.firstColor = self.colors[self.index].color1
            self.gradient.secondColor = self.colors[self.index].color2
        }) { (success) in
            if Utility.sharedInstance.animateBackgroundLocation() == 3{
                self.animateBackground()
            }
        }
    }
    //Player submits their answer and is transferred to the game VC
    @IBAction func submitButton(_ sender: Any) {
        
        Utility.sharedInstance.addreward(index: tempAnswer)
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Utility.sharedInstance.sendReward(index: row)
    }
    
    // called when a selection is made
    // recall that the first row is row 0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rewardAnswer.text = Utility.sharedInstance.rewardDescrip(index: row)
        tempAnswer = row
        //submitOutlet.pulsate()
    }
    
    // UIPickerViewDataSource protocol methods
    
    // # of components in each row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utility.sharedInstance.availAwards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Utility.sharedInstance.sendReward(index: row)
        tempAnswer = row
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return myTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        picker.selectedRow(inComponent: 0)
        submitOutlet.pulsate()
        if Utility.sharedInstance.getStreak() / 20 > 0{
            rewardAnswer.text = "Nice Streak! " + String(Utility.sharedInstance.getStreak() / 20) + " extra reward(s)."
            for x in 0..<Utility.sharedInstance.getStreak() / 20{
                Utility.sharedInstance.sendReward(index: Int.random(in: 0..<4))
            }
        }
    }
    //Start the chicken animation
    func startChicken(){
        chicken.setAnimation(named: "newAnimation")
        chicken.loopAnimation = false
        chicken.play()
    }
    
    
    override func viewDidLoad() {
        picker.selectedRow(inComponent: 0)
        submitOutlet.pulsate()
        super.viewDidLoad()
        startChicken()
        Utility.sharedInstance.decideBackgroundAnimation(num: 3)
        animateBackground()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
