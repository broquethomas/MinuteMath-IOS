//
//  LeaderboardVC.swift
//  FinalProject
//
//  Created by Broque on 11/10/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var gradient: UIViewX!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var modeSelectionOutlet: UILabel!
    
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
            if Utility.sharedInstance.animateBackgroundLocation() == 4{
                self.animateBackground()
            }
        }
    }
    
    //Transfer player back to Main VC
    @IBAction func backMain(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToMain", sender: nil)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Utility.sharedInstance.getLeader(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Utility.sharedInstance.getLeader(index: row)
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return myTitle
    }
    
    // called when a selection is made
    // recall that the first row is row 0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = "Name: " + Utility.sharedInstance.getLeader(index: row)
        scoreLabel.text = "Score: " + String(Utility.sharedInstance.getLeaderScore(index: row))
    }
    
    // UIPickerViewDataSource protocol methods
    
    // # of components in each row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utility.sharedInstance.getLeaderArrayCount()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        picker.reloadAllComponents()
        modeSelectionOutlet.text = Utility.sharedInstance.getDifficultySetting(index: Utility.sharedInstance.getDifficulty())
        Utility.sharedInstance.organize()
        nameLabel.text = "Name: " + Utility.sharedInstance.getLeader(index: 0)
        scoreLabel.text = "Score: " + String(Utility.sharedInstance.getLeaderScore(index: 0))
        mainButton.flashTwo()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Utility.sharedInstance.decideBackgroundAnimation(num: 4)
        animateBackground()
        // Do any additional setup after loading the view.
    }
    

    

}
