//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Broque on 11/9/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet var gradient: UIViewX!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    var index = -1
    var colors = Utility.sharedInstance.getColorArray()
    
    //Transfers user to the leaderboard VC
    @IBAction func leaderboardFunc(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLeaderboard", sender: nil)
    }
    
    func animateBackground(){
        overView.layer.cornerRadius = 30
        overView.layer.masksToBounds = true
        //index = 0 if index == length of color array, otherwise index+=1
        index = index == (colors.count-1) ? 0 : index+1
        UIView.transition(with: gradient, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradient.firstColor = self.colors[self.index].color1
            self.gradient.secondColor = self.colors[self.index].color2
            
        }) { (success) in
            if Utility.sharedInstance.animateBackgroundLocation() == 0{
                self.animateBackground()
            }
        }
    }
    
    func animateHeader(){
        var headerColors = Utility.sharedInstance.getColorArray()
        UIView.transition(with: header, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            if Bool.random(){
                self.header.textColor = headerColors[Int.random(in: 0..<headerColors.count)].color2
            }else{
                self.header.textColor = headerColors[Int.random(in: 0..<headerColors.count)].color1
            }
        }) { (success) in
            if Utility.sharedInstance.animateBackgroundLocation() == 0{
                self.animateHeader()
            }
        }
    }
    
    //Animate the clock images
    func animate(image: UIImageView){
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.animationImages = Utility.sharedInstance.sendImages()
        image.animationDuration = 2.0
        image.startAnimating()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Utility.sharedInstance.getDifficultySetting(index: row)
    }
    
    // called when a selection is made
    // recall that the first row is row 0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Utility.sharedInstance.setDifficult(set: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = Utility.sharedInstance.getDifficultySetting(index: row)
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return myTitle
    }
    
    
    
    // UIPickerViewDataSource protocol methods
    
    // # of components in each row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utility.sharedInstance.getDifArrayCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Utility.sharedInstance.getCorrectSound().prepareToPlay()
        Utility.sharedInstance.getClockSound().prepareToPlay()
        Utility.sharedInstance.getMusic().stop()
        Utility.sharedInstance.setDifficult(set: 0)
        Utility.sharedInstance.decideBackgroundAnimation(num: 0)
        Utility.sharedInstance.questionCount = 0
        playButton.pulsate()
        Utility.sharedInstance.resetQuestions()
        
        //Utility.sharedInstance.resetRewards()
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        image.layer.cornerRadius = 10
        animate(image: image)
        playButton.pulsate()
        Utility.sharedInstance.resetRound()
        if Utility.sharedInstance.getMainMusicStatus(){
            
        }else{
            Utility.sharedInstance.toggleMainMusic()
            Utility.sharedInstance.getMenuMusic().play()
        }
        super.viewDidLoad()
        animateBackground()
        animateHeader()
        playButton.pulsate()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

}

