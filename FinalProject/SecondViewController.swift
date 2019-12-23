//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Broque on 11/9/18.
//  Copyright © 2018 SOU. All rights reserved.

// All music copyright / royalty free from Purple-planet.com, Youtube.com
//

import UIKit
import Lottie
import GoogleMobileAds
import iosMath


class SecondViewController: UIViewController, GADRewardBasedVideoAdDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UICollisionBehaviorDelegate {
    
    
    var indexColor = -1
    var colors = Utility.sharedInstance.getColorArray()
    @IBOutlet weak var gradient: UIViewX!
    @IBOutlet weak var overView: UIView!
    @IBOutlet var streakAnimation: LOTAnimationView!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    //buildEquationView
    @IBOutlet var buildEquationView: UIView!
    @IBOutlet weak var buildEquationAnswerLabel: UILabel!
    @IBOutlet weak var buildEquationUserAnswerLabel: UILabel!
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var midPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    @IBOutlet weak var buildEquationInnerView: UIView!
    
    @IBOutlet weak var buildEquationGradientView: UIViewX!
    
    var buildEquationAnswerArray = [String()]
    var buildEquationUserAnswerArray = ["?", "?", "?"]
    var inBuildEquationView = false
    var leftArray = [String()]
    var midArray = [String()]
    var rightArray = [String()]
    //end buildEquationView
    
    //rotationPuzzleView
    @IBOutlet var rotationPuzzleView: UIView!
    @IBOutlet weak var rotationTopAnswer: UILabel!
    @IBOutlet weak var rotationRightAnswer: UILabel!
    
    @IBOutlet weak var rotationInnerCircle: UIImageView!
    @IBOutlet weak var rotationOuterCircle: UIImageView!
    @IBOutlet weak var rotationMidCircle: UIImageView!
    
    @IBOutlet weak var rotationOuterOne: UILabel!
    @IBOutlet weak var rotationOuterTwo: UILabel!
    @IBOutlet weak var rotationOuterThree: UILabel!
    @IBOutlet weak var rotationOuterFour: UILabel!
    
    @IBOutlet weak var rotationMidOne: UILabel!
    @IBOutlet weak var rotationMidTwo: UILabel!
    @IBOutlet weak var rotationMidThree: UILabel!
    @IBOutlet weak var rotationMidFour: UILabel!
    
    @IBOutlet weak var rotationInnerOne: UILabel!
    @IBOutlet weak var rotationInnerTwo: UILabel!
    @IBOutlet weak var rotationInnerThree: UILabel!
    @IBOutlet weak var rotationInnerFour: UILabel!
    
    @IBOutlet weak var rotationInnerLeftRotation: UIButton!
    @IBOutlet weak var rotationInnerRightRotation: UIButton!
    @IBOutlet weak var rotationOutterLeftRotation: UIButton!
    @IBOutlet weak var rotationOuterRightRotation: UIButton!
    
    @IBOutlet weak var rotationInnerBackgroundView: UIViewX!
    
    @IBOutlet weak var rotationBottomView: UIView!
    
    @IBOutlet weak var rotationBackgroundView: UIView!
    
    
    var inRotationPuzzleView = false
    var innerCircleDegree = 0.0
    var outerCircleDegree = 0.0
    var outerPuzzleArray = [Int()]
    var innerPuzzleArray = [Int()]
    var midPuzzleArray = [String()]
    //end rotationPuzzleView
    
    //fallingGameView
    @IBOutlet var fallingGameView: UIView!
    
    @IBOutlet weak var fallingGameInnerView: UIView!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var gravity: UIGravityBehavior!
    var inFallingPuzzle = false
    var buttonCreations = [UIButton()]
    var fallingGameUserSelections = [String()]
    var fallingPuzzleUserScore = 0
    var fallingPuzzleTimerHelper = false
    @IBOutlet weak var fallingPuzzleUserScoreLabel: UILabel!
    //end fallingGameView
    
    //advancedEquationsView
    
    
    @IBOutlet weak var advancedEquationQuestion1: MTMathUILabel!
    
    @IBOutlet var advancedEquationView: UIView!
    
    
    @IBOutlet weak var rewardBorderView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    var effect: UIVisualEffect!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet var theView: UIView!
    
    @IBOutlet var correctSymbol: LOTAnimationView!
    @IBOutlet weak var streak: UILabel!
    @IBOutlet weak var actualAnswer: UILabel!
    @IBOutlet weak var fiftyOutlet: UIButton!
    @IBOutlet weak var skipOutlet: UIButton!
    @IBOutlet weak var pauseOutlet: UIButton!
    
    @IBOutlet weak var timePlus: UILabel!
    @IBOutlet weak var scorePlus: UILabel!
    
    @IBOutlet weak var currentScorePauseLabel: UILabel!
    
    @IBOutlet weak var gifView: UIImageView!
    
    
    @IBOutlet weak var pauseBorder: UIView!
    @IBOutlet weak var miniMulligan: UIButton!
    @IBOutlet weak var miniTime: UIButton!
    @IBOutlet weak var miniSkip: UIButton!
    @IBOutlet weak var miniFifty: UIButton!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    @IBOutlet weak var optionFive: UIButton!
    @IBOutlet weak var optionSix: UIButton!
    @IBOutlet weak var optionSeven: UIButton!
    @IBOutlet weak var optionEight: UIButton!
    
    
    @IBOutlet weak var actualScoreInPauseMenu: UILabel!
    
    @IBOutlet weak var GADBannerView: GADBannerView!
    
    @IBOutlet var danceAvatar: LOTAnimationView!
    
    @IBOutlet weak var videoAd: UIButton!
    
    var backgroundColor = UIColor()
    
    
    
    //Visual display of a score increase using a label.
    func moreScore(score: Int){
        scorePlus.textColor = UIColor.white
        scorePlus.text = "+\(score)"
        scorePlus.fadeInOut()
        setCorrectSymbol()
    }
    //Correct animation
    func setCorrectSymbol(){
        correctSymbol.setAnimation(named: "checked_done_")
        correctSymbol.play()
        
    }
    //Streak Animation
    func streakAnimationPlay(){
        streakAnimation.setAnimation(named: "confetti")
        streakAnimation.play()
    }
    //Visual display of time increase using a label.
    func moreTime(time: Int){
        pulseBackground()
        timePlus.textColor = UIColor.white
        timePlus.text = "+\(time)"
        timePlus.fadeInOut()
    }
    
    //Skip button was used.
    @IBAction func useSkip(_ sender: UIButton) {
        sender.flashTwo()
        sender.isEnabled = false
        sender.isHidden = true
        miniSkip.layer.removeAllAnimations()
        Utility.sharedInstance.skipUsed()
        Utility.sharedInstance.toggleSkipBool()
        setButtons()
    }
    //Player got a streak
    func streakBonus(){
        Utility.sharedInstance.addTime(add: 10)
        
        streak.text = "Nice! +10s"
        if Utility.sharedInstance.getStreak() == 20{
            streak.text = "Ooo! Makin' this look easy!"
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
        }
        if Utility.sharedInstance.getStreak() == 40{
            streak.text = "Get it! Get it! Get it!"
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
        }
        if Utility.sharedInstance.getStreak() == 60{
            streak.text = "*Intensity Intensifies*"
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
        }
        if Utility.sharedInstance.getStreak() == 80{
            streak.text = "Do I have enough rewards for this?"
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
        }
        if Utility.sharedInstance.getStreak() == 100{
            streak.text = "You Animal!"
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
            Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
        }
        moreTime(time: 10)
        streak.pulsateQuick()
        streakAnimationPlay()
    }
    //helper function to modify time and score.
    func checkHelper(score: Int, time: Int){
        moreScore(score: score)
        moreTime(time: time)
        Utility.sharedInstance.addScore(number: score)
        Utility.sharedInstance.incCount(num: score)
        Utility.sharedInstance.addTime(add: time)
    }
    
    //Check player answer in hard mode
    func hardCheck(sender: UIButton){
        
        if Utility.sharedInstance.sendX(){
            if Utility.sharedInstance.getSelector(){
                actualAnswer.text = Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1)
                if sender.titleLabel!.text! == Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1){
                    Utility.sharedInstance.incStreak()
                    Utility.sharedInstance.getCorrectSound().play()
                    if Utility.sharedInstance.getStreak() % 5 == 0{
                        streakBonus()
                    }
                    self.theView.fadeInNew()
                    if (Utility.sharedInstance.decisionTwo()){
                        checkHelper(score: 3, time: 6)
                        
                    }else{
                        checkHelper(score: 2, time: 4)
                    }
                    userScoreLabel.pulsateQuick()
                    setButtons()
                }else if sender.titleLabel!.text! !=
                    Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && Utility.sharedInstance.getMulliganBool(){
                    sender.setTitle("Oops!", for: .normal)
                    miniMulligan.layer.removeAllAnimations()
                    sender.shake()
                    Utility.sharedInstance.toggleMulligan()
                }else{
                    if Utility.sharedInstance.decisionTwo(){
                        Utility.sharedInstance.incCount(num: 3)
                    }else{
                        Utility.sharedInstance.incCount(num: 2)
                    }
                    pulseBackgroundLose()
                    Utility.sharedInstance.resetStreak()
                    setButtons()
                }
            }else{
                actualAnswer.text = "x = " + String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1))
                if sender.titleLabel?.text == "x = " + String(format: "%.0f", Utility.sharedInstance.getAnswer(index:
                    Utility.sharedInstance.getQuestionCount()-1)){
                    Utility.sharedInstance.incStreak()
                    Utility.sharedInstance.getCorrectSound().play()
                    if Utility.sharedInstance.getStreak() % 5 == 0{
                        streakBonus()
                    }
                    self.theView.fadeInNew()
                    if Utility.sharedInstance.decisionTwo(){
                        checkHelper(score: 3, time: 6)
                    }else{
                        checkHelper(score: 2, time: 4)
                    }
                    Utility.sharedInstance.toggleX(boo: false)
                    userScoreLabel.pulsateQuick()
                    setButtons()
                }else if sender.titleLabel!.text! != "x = " + String(Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)) && Utility.sharedInstance.getMulliganBool(){
                    sender.setTitle("Oops!", for: .normal)
                    miniMulligan.layer.removeAllAnimations()
                    sender.shake()
                    Utility.sharedInstance.toggleMulligan()
                }else{
                    if Utility.sharedInstance.decisionTwo(){
                        Utility.sharedInstance.incCount(num: 3)
                    }else{
                        Utility.sharedInstance.incCount(num: 2)
                    }
                    pulseBackgroundLose()
                    Utility.sharedInstance.toggleX(boo: false)
                    Utility.sharedInstance.resetStreak()
                    setButtons()
                }
            }
        }else{
            if Utility.sharedInstance.getSelector(){
                actualAnswer.text = Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1)
                if sender.titleLabel!.text! == Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1){
                    Utility.sharedInstance.incStreak()
                    Utility.sharedInstance.getCorrectSound().play()
                    if Utility.sharedInstance.getStreak() % 5 == 0{
                        streakBonus()
                    }
                    self.theView.fadeInNew()
                    if (Utility.sharedInstance.decisionTwo()){
                        checkHelper(score: 3, time: 6)
                    }else{
                        checkHelper(score: 1, time: 2)
                    }
                    userScoreLabel.pulsateQuick()
                    setButtons()
                }else if sender.titleLabel!.text! !=
                    Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && Utility.sharedInstance.getMulliganBool(){
                    sender.setTitle("Oops!", for: .normal)
                    miniMulligan.layer.removeAllAnimations()
                    sender.shake()
                    Utility.sharedInstance.toggleMulligan()
                }else{
                    if Utility.sharedInstance.decisionTwo(){
                        Utility.sharedInstance.incCount(num: 3)
                    }else{
                        Utility.sharedInstance.incCount(num: 1)
                    }
                    pulseBackgroundLose()
                    Utility.sharedInstance.resetStreak()
                    setButtons()
                }
            }else{
                actualAnswer.text = String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1))
                if sender.titleLabel?.text == String(format: "%.0f", Utility.sharedInstance.getAnswer(index:
                    Utility.sharedInstance.getQuestionCount()-1)){
                    Utility.sharedInstance.incStreak()
                    Utility.sharedInstance.getCorrectSound().play()
                    if Utility.sharedInstance.getStreak() % 5 == 0{
                        streakBonus()
                    }
                    self.theView.fadeInNew()
                    if Utility.sharedInstance.decisionTwo(){
                        checkHelper(score: 3, time: 6)
                    }else{
                        checkHelper(score: 1, time: 2)
                    }
                    userScoreLabel.pulsateQuick()
                    setButtons()
                }else if sender.titleLabel!.text! != String(Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)) && Utility.sharedInstance.getMulliganBool(){
                    sender.setTitle("Oops!", for: .normal)
                    miniMulligan.layer.removeAllAnimations()
                    sender.shake()
                    Utility.sharedInstance.toggleMulligan()
                }else{
                    if Utility.sharedInstance.decisionTwo(){
                        Utility.sharedInstance.incCount(num: 3)
                    }else{
                        Utility.sharedInstance.incCount(num: 1)
                        
                    }
                    pulseBackgroundLose()
                    Utility.sharedInstance.resetStreak()
                    setButtons()
                }
            }
        }
    }
    //Check player answer in medium mode
    func mediumCheck(sender: UIButton){
        if Utility.sharedInstance.getSelector(){
            actualAnswer.text = Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1)
            if sender.titleLabel!.text! == Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1){
                Utility.sharedInstance.incStreak()
                Utility.sharedInstance.getCorrectSound().play()
                if Utility.sharedInstance.getStreak() % 5 == 0{
                    streakBonus()
                }
                self.theView.fadeInNew()
                if (Utility.sharedInstance.decisionTwo()){
                    checkHelper(score: 3, time: 6)
                }else{
                    if Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1).count <= 5{
                        checkHelper(score: 1, time: 2)
                    }else{
                        checkHelper(score: 2, time: 4)
                    }
                }
                userScoreLabel.pulsateQuick()
                setButtons()
            }else if sender.titleLabel!.text! !=
                Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && Utility.sharedInstance.getMulliganBool(){
                sender.setTitle("Oops!", for: .normal)
                miniMulligan.layer.removeAllAnimations()
                sender.shake()
                Utility.sharedInstance.toggleMulligan()
            }else{
                if Utility.sharedInstance.decisionTwo(){
                    Utility.sharedInstance.incCount(num: 3)
                    
                }else{
                    if Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1).count <= 5{
                        Utility.sharedInstance.incCount(num: 1)
                        
                    }else{
                    Utility.sharedInstance.incCount(num: 2)
                        
                    }
                }
                pulseBackgroundLose()
                Utility.sharedInstance.resetStreak()
                setButtons()
            }
        }else{
            actualAnswer.text = String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1))
            if sender.titleLabel?.text == String(format: "%.0f", Utility.sharedInstance.getAnswer(index:
                Utility.sharedInstance.getQuestionCount()-1)){
                Utility.sharedInstance.incStreak()
                Utility.sharedInstance.getCorrectSound().play()
                if Utility.sharedInstance.getStreak() % 5 == 0{
                    streakBonus()
                }
                self.theView.fadeInNew()
                if Utility.sharedInstance.decisionTwo(){
                    checkHelper(score: 3, time: 6)
                }else{
                    if Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1).count <= 5{
                        checkHelper(score: 1, time: 2)
                    }else{
                        checkHelper(score: 2, time: 4)
                    }
                }
                userScoreLabel.pulsateQuick()
                setButtons()
            }else if sender.titleLabel!.text! != String(Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)) && Utility.sharedInstance.getMulliganBool(){
                sender.setTitle("Oops!", for: .normal)
                miniMulligan.layer.removeAllAnimations()
                sender.shake()
                Utility.sharedInstance.toggleMulligan()
            }else{
                if Utility.sharedInstance.decisionTwo(){
                    Utility.sharedInstance.incCount(num: 3)
                    
                }else{
                    if Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1).count <= 5{
                        Utility.sharedInstance.incCount(num: 1)
                        
                    }else{
                        Utility.sharedInstance.incCount(num: 2)
                        
                    }
                }
                pulseBackgroundLose()
                Utility.sharedInstance.resetStreak()
                setButtons()
            }
        }
    }
    //Check player answer in easy mode
    func easyCheck(sender: UIButton){
        let test = false
        if test{
            actualAnswer.text = Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1)
            if sender.titleLabel!.text! == Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1){
                
                Utility.sharedInstance.incStreak()
                Utility.sharedInstance.getCorrectSound().play()
                if Utility.sharedInstance.getStreak() % 5 == 0{
                    streakBonus()
                }
                self.theView.fadeInNew()
                if (Utility.sharedInstance.decisionTwo()){
                    checkHelper(score: 2, time: 4)
                }else{
                    checkHelper(score: 1, time: 2)
                }
                userScoreLabel.pulsateQuick()
                setButtons()
            }else if sender.titleLabel!.text! !=
                Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && Utility.sharedInstance.getMulliganBool(){
                sender.setTitle("Oops!", for: .normal)
                miniMulligan.layer.removeAllAnimations()
                sender.shake()
                Utility.sharedInstance.toggleMulligan()
            }else{
                if Utility.sharedInstance.decisionTwo(){
                    Utility.sharedInstance.incCount(num: 2)
                    
                }else{
                    Utility.sharedInstance.incCount(num: 1)
                    
                }
                pulseBackgroundLose()
                Utility.sharedInstance.resetStreak()
                setButtons()
            }
        }else{
            actualAnswer.text = String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1))
            if sender.titleLabel?.text == String(format: "%.0f", Utility.sharedInstance.getAnswer(index:
                Utility.sharedInstance.getQuestionCount()-1)){
                Utility.sharedInstance.incStreak()
                Utility.sharedInstance.getCorrectSound().play()
                if Utility.sharedInstance.getStreak() % 5 == 0{
                    streakBonus()
                }
                self.theView.fadeInNew()
                if Utility.sharedInstance.decisionTwo(){
                    checkHelper(score: 2, time: 4)
                }else{
                    checkHelper(score: 1, time: 2)
                }
                userScoreLabel.pulsateQuick()
                setButtons()
            }else if sender.titleLabel!.text! != String(Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)) && Utility.sharedInstance.getMulliganBool(){
                sender.setTitle("Oops!", for: .normal)
                miniMulligan.layer.removeAllAnimations()
                sender.shake()
                Utility.sharedInstance.toggleMulligan()
            }else{
                if Utility.sharedInstance.decisionTwo(){
                    Utility.sharedInstance.incCount(num: 2)
                }else{
                    Utility.sharedInstance.incCount(num: 1)
                }
                pulseBackgroundLose()
                Utility.sharedInstance.resetStreak()
                setButtons()
            }
        }
    }
    //Player selected an answer
    @IBAction func selectionMade(_ sender: UIButton){
        
        switch Utility.sharedInstance.getDifficulty() {
            case 0:
                easyCheck(sender: sender)
            case 1:
                mediumCheck(sender: sender)
            case 2:
                hardCheck(sender: sender)
            default:
                hardCheck(sender: sender)
            }
        
        
    }
   
    //Set buttons for hard mode difficulty
    func hardMode(){
        Utility.sharedInstance.toggleOverallSelector()
        var buttonArray = [optionOne, optionTwo, optionThree, optionFour, optionFive, optionSix, optionSeven, optionEight]
        
        var check = true
        let count = buttonArray.count
        var answer = 0.0
        
        if Utility.sharedInstance.getOverallSelector(){
            if Utility.sharedInstance.getSelector(){
                while buttonArray.count != 0{
                    var y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                    while Int(y.1) % 2 != 0{
                        y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                    }
                    if check{
                        check = false
                        answer = y.1
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(y.0, for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        if count == buttonArray.count && y.0.count > 7{
                            questionLabel.text = "x = " + String(format: "%.0f", Double(y.1))
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }else if count == buttonArray.count{
                            questionLabel.text = String(format: "%.0f", Double(y.1))
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }else{
                        while y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                            y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                        }
                        
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(y.0, for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        
                        
                        if count == buttonArray.count{
                            questionLabel.text = String(format: "%.0f", Double(y.1))
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }
                }
            }else{
                while buttonArray.count != 0{
                    var y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                    while Int(y.1) % 2 != 0{
                        y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                    }
                    if check{
                        
                        check = false
                        answer = y.1
                        if Utility.sharedInstance.decisionTwo(){
                            Utility.sharedInstance.toggleX(boo: true)
                            let index = Int.random(in: 0..<buttonArray.count)
                            buttonArray[index]!.setTitle("x = " + String(format: "%.0f",(y.1)), for: .normal)
                            buttonArray[index]?.layer.removeAllAnimations()
                            buttonArray[index]!.layer.cornerRadius = 10.0
                            buttonArray[index]!.fadeIn()
                            
                            if count == buttonArray.count{
                                questionLabel.text = y.0
                                Utility.sharedInstance.addQuestionArray(value: y.0)
                                Utility.sharedInstance.addAnswerArray(value: y.1)
                            }
                            buttonArray.remove(at: index)
                        }else{
                            let index = Int.random(in: 0..<buttonArray.count)
                            buttonArray[index]!.setTitle(String(format: "%.0f",(y.1)), for: .normal)
                            buttonArray[index]?.layer.removeAllAnimations()
                            buttonArray[index]!.layer.cornerRadius = 10.0
                            buttonArray[index]!.fadeIn()
                            
                            if count == buttonArray.count{
                                questionLabel.text = y.0
                                Utility.sharedInstance.addQuestionArray(value: y.0)
                                Utility.sharedInstance.addAnswerArray(value: y.1)
                            }
                            buttonArray.remove(at: index)
                        }
                        
                    }else{
                        while y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                            y = Utility.sharedInstance.decideQuestionTwo(decide: Utility.sharedInstance.decisionTwo())
                        }
                        if Utility.sharedInstance.decisionTwo(){
                            Utility.sharedInstance.toggleX(boo: true)
                            let index = Int.random(in: 0..<buttonArray.count)
                            buttonArray[index]!.setTitle("x = " + String(format: "%.0f",(y.1)), for: .normal)
                            buttonArray[index]?.layer.removeAllAnimations()
                            buttonArray[index]!.layer.cornerRadius = 10.0
                            buttonArray[index]!.fadeIn()
                            
                            if count == buttonArray.count{
                                questionLabel.text = y.0
                                Utility.sharedInstance.addQuestionArray(value: y.0)
                                Utility.sharedInstance.addAnswerArray(value: y.1)
                            }
                            buttonArray.remove(at: index)
                        }else{
                            let index = Int.random(in: 0..<buttonArray.count)
                            buttonArray[index]!.setTitle(String(format: "%.0f",(y.1)), for: .normal)
                            buttonArray[index]?.layer.removeAllAnimations()
                            buttonArray[index]!.layer.cornerRadius = 10.0
                            buttonArray[index]!.fadeIn()
                            
                            if count == buttonArray.count{
                                questionLabel.text = y.0
                                Utility.sharedInstance.addQuestionArray(value: y.0)
                                Utility.sharedInstance.addAnswerArray(value: y.1)
                            }
                            buttonArray.remove(at: index)
                        }
                    }
                }
            }
        }else{
            if Utility.sharedInstance.getSelector(){
                while buttonArray.count != 0{
                    var y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                    while y.1 == Double.infinity || y.1 == 0 || Int(y.1) % 2 != 0{
                        y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                    }
                    if check{
                        
                        check = false
                        answer = y.1
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(y.0, for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        
                        if count == buttonArray.count{
                            questionLabel.text = String(format: "%.0f", Double(y.1))
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }else{
                        while y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                            y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                        }
                        
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(y.0, for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        
                        if count == buttonArray.count{
                            questionLabel.text = String(format: "%.0f", Double(y.1))
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }
                }
            }else{
                while buttonArray.count != 0{
                    var y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                    
                    while y.1 == Double.infinity || y.1 == 0.0 || Int(y.1) % 2 != 0{
                        
                        y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                    }
                    if check{
                        
                        check = false
                        answer = y.1
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(String(format: "%.0f",(y.1)), for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        
                        if count == buttonArray.count{
                            questionLabel.text = y.0
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }else{
                        while y.1 == Double.infinity || y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                            y = Utility.sharedInstance.decideQuestion(decide: Utility.sharedInstance.decisionTwo())
                        }
                        let index = Int.random(in: 0..<buttonArray.count)
                        buttonArray[index]!.setTitle(String(format: "%.0f", (y.1)), for: .normal)
                        buttonArray[index]?.layer.removeAllAnimations()
                        buttonArray[index]!.layer.cornerRadius = 10.0
                        buttonArray[index]!.fadeIn()
                        
                        if count == buttonArray.count{
                            questionLabel.text = y.0
                            Utility.sharedInstance.addQuestionArray(value: y.0)
                            Utility.sharedInstance.addAnswerArray(value: y.1)
                        }
                        buttonArray.remove(at: index)
                    }
                }
            }
        }
    }
    //Set buttons for medium mode difficulty
    func mediumMode(){
        var buttonArray = [optionOne, optionTwo, optionThree, optionFour, optionFive, optionSix, optionSeven, optionEight]
        
        var check = true
        let count = buttonArray.count
        var answer = 0.0
        
        if Utility.sharedInstance.getSelector(){
            while buttonArray.count != 0{
                var y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                while y.1 == Double.infinity || y.1 == 0 || Int(y.1) % 2 != 0{
                    y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                }
                if check{
                    check = false
                    answer = y.1
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(y.0, for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    
                    if count == buttonArray.count{
                        questionLabel.text = String(format: "%.0f", Double(y.1))
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }else{
                    while y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                        y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                    }
                    
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(y.0, for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    
                    if count == buttonArray.count{
                        questionLabel.text = String(format: "%.0f", Double(y.1))
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }
            }
        }else{
            while buttonArray.count != 0{
                var y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                
                while y.1 == Double.infinity || y.1 == 0.0 || Int(y.1) % 2 != 0{
                    
                    y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                }
                if check{
                    check = false
                    answer = y.1
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(String(format: "%.0f",(y.1)), for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    
                    if count == buttonArray.count{
                        questionLabel.text = y.0
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }else{
                    while y.1 == Double.infinity || y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                        y = Utility.sharedInstance.decideMedium(decide: Utility.sharedInstance.decisionTwo())
                    }
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(String(format: "%.0f", (y.1)), for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    
                    if count == buttonArray.count{
                        questionLabel.text = y.0
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }
            }
        }
    }
    //Set buttons easy mode difficulty
    func easyMode(){
        var buttonArray = [optionOne, optionTwo, optionThree, optionFour, optionFive, optionSix, optionSeven, optionEight]
       
        var check = true
        let count = buttonArray.count
        var answer = 0.0
        let test = false
        if test{
            while buttonArray.count != 0{
                print("uno")
                var y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                while y.1 == Double.infinity || y.1 == 0 || Int(y.1) % 2 != 0{
                    y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                    print("first")
                }
                if check{
                    check = false
                    answer = y.1
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(y.0, for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    slideIn(sender: buttonArray[index]!)
                    if count == buttonArray.count{
                        questionLabel.text = String(format: "%.0f", Double(y.1))
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }else{
                    while y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                        y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                        print("second")
                    }
                    
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(y.0, for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    slideIn(sender: buttonArray[index]!)
                    if count == buttonArray.count{
                        questionLabel.text = String(format: "%.0f", Double(y.1))
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }
            }
        }else{
            while buttonArray.count != 0{
                var y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                
                while y.1 == Double.infinity || y.1 == 0.0 || Int(y.1) % 2 != 0{
                    y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                }
                if check{
                    check = false
                    answer = y.1
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(String(format: "%.0f",(y.1)), for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    slideIn(sender: buttonArray[index]!)
                    if count == buttonArray.count{
                        questionLabel.text = y.0
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }else{
                    while y.1 == Double.infinity || y.1 == answer || Int(y.1) % 2 != 0 || y.1 - answer > 50 || answer - y.1 > 50{
                        print("second")
                        y = Utility.sharedInstance.decideEasy(decide: Utility.sharedInstance.decisionTwo())
                    }
                    let index = Int.random(in: 0..<buttonArray.count)
                    buttonArray[index]!.setTitle(String(format: "%.0f", (y.1)), for: .normal)
                    buttonArray[index]?.layer.removeAllAnimations()
                    buttonArray[index]!.layer.cornerRadius = 10.0
                    buttonArray[index]!.fadeIn()
                    slideIn(sender: buttonArray[index]!)
                    if count == buttonArray.count{
                        questionLabel.text = y.0
                        Utility.sharedInstance.addQuestionArray(value: y.0)
                        Utility.sharedInstance.addAnswerArray(value: y.1)
                    }
                    buttonArray.remove(at: index)
                }
            }
        }
    }
    
    func setStandardMathQuestions(){
        Utility.sharedInstance.toggleSelector()
        Utility.sharedInstance.toggleDecision()
        switch Utility.sharedInstance.getDifficulty() {
        case 0:
            easyMode()
        case 1:
            mediumMode()
        case 2:
            hardMode()
        default:
            mediumMode()
        }
    }
    
    //Func that chooses which button difficulty to set.
    func setButtons(){
        if Utility.sharedInstance.getSkipBool(){
            skipOutlet.isHidden = false
            skipOutlet.isEnabled = true
        }
        if Utility.sharedInstance.getFiftyBool(){
            fiftyOutlet.isHidden = false
            fiftyOutlet.isEnabled = true
        }
        let questionType = Int.random(in: 0..<18)
        setStandardMathQuestions()
        switch questionType {
        case 7:
            openFallingPuzzle()

        case 8:
            openRotationPuzzleView()
        case 9:
            setupBuildEquationView()
        default:
            print("hola")
            
        }
        
        
    }
    
    //Tied with the 50/50 reward to remove half of the incorrect answers.
    func removeHalf(){
        var buttonArray = [optionOne, optionTwo, optionThree, optionFour, optionFive, optionSix, optionSeven, optionEight]
        let max = 4
        var count = 0
        if Utility.sharedInstance.checkX{
            
            for x in 0...buttonArray.count{
                if buttonArray[x]?.titleLabel?.text != Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && buttonArray[x]?.titleLabel?.text != "x = " + String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)){
                    if count == max{
                        break
                    }
                    buttonArray[x]?.setTitle("NOPE!", for: .normal)
                    buttonArray[x]?.pulsateQuick()
                    buttonArray[x]?.flashTwo()
                    count += 1
                }
            }
        }else {
            for x in 0...buttonArray.count{
                if buttonArray[x]?.titleLabel?.text != Utility.sharedInstance.getQuestion(index: Utility.sharedInstance.getQuestionCount()-1) && buttonArray[x]?.titleLabel?.text != String(format: "%.0f", Utility.sharedInstance.getAnswer(index: Utility.sharedInstance.getQuestionCount()-1)){
                    if count == max{
                        break
                    }
                    buttonArray[x]?.setTitle("NOPE!", for: .normal)
                    buttonArray[x]?.pulsateQuick()
                    buttonArray[x]?.flashTwo()
                    count += 1
                }
            }
        }
    }
    // 50/50 reward was used
    @IBAction func fiftyUsed(_ sender: UIButton) {
        sender.flashTwo()
        sender.isEnabled = false
        sender.isHidden = true
        miniFifty.layer.removeAllAnimations()
        Utility.sharedInstance.fiftyToggle()
        removeHalf()
    }
    
    
    
    //Player chooses to quit the game from pause menu
    @IBAction func quitButton(_ sender: Any) {
        Utility.sharedInstance.resetRewards()
        Utility.sharedInstance.stopTimer()
        Utility.sharedInstance.resetTime()
        Utility.sharedInstance.resetScore()
        Utility.sharedInstance.toggleMusicStatus()
        Utility.sharedInstance.timer = Timer()
        Utility.sharedInstance.toggleHomePageAnimate()
    }
    
    //Mulligan is activated by the player
    @IBAction func oopsButton(_ sender: UIButton) {
        var check = false
        if Utility.sharedInstance.getMulliganBool(){
            viewLabel.text = "Mulligan active."
            sender.shake()
        }else{
            if Utility.sharedInstance.userRewards.count != 0{
                for i in 0..<Utility.sharedInstance.userRewards.count{
                    if Utility.sharedInstance.sendUserReward(index: i) == "Mulligan"{
                        Utility.sharedInstance.toggleMulligan()
                        Utility.sharedInstance.removeReward(reward: "Mulligan")
                        check = true
                        viewLabel.text = "Mulligan activated."
                        miniMulligan.pulsate()
                        sender.flash()
                        break;
                    }
                }
                
            }
            if check == false{
                viewLabel.text = "No mulligan available."
                sender.shake()
            }
        }
        
    }
    //Time modifer is activated by the player
    @IBAction func timeButton(_ sender: UIButton) {
        var check = false
        if Utility.sharedInstance.userRewards.count != 0{
            
            for i in 0..<Utility.sharedInstance.userRewards.count{
                if Utility.sharedInstance.sendUserReward(index: i) == "+10s"{
                    Utility.sharedInstance.addTime(add: 10)
                    Utility.sharedInstance.removeReward(reward: "+10s")
                    check = true
                    viewLabel.text = "Time modifier used successfully."
                    sender.flash()
                    break;
                }
            }
        }
        if check == false{
            viewLabel.text = "No time modifer available."
            sender.shake()
        }
    }
    //Skip button is activated.
    @IBAction func skipButton(_ sender: UIButton) {
        var check = false
        if Utility.sharedInstance.getSkipBool(){
            viewLabel.text = "Skip already active."
            sender.shake()
        }else{
            if Utility.sharedInstance.userRewards.count != 0{
                for i in 0..<Utility.sharedInstance.userRewards.count{
                    if Utility.sharedInstance.sendUserReward(index: i) == "Skip"{
                        skipOutlet.isEnabled = true
                        skipOutlet.isHidden = false
                        Utility.sharedInstance.removeReward(reward: "Skip")
                        Utility.sharedInstance.toggleSkipBool()
                        check = true
                        viewLabel.text = "Skip button unlocked."
                        sender.flash()
                        break;
                    }
                }
            }
            if check == false{
                viewLabel.text = "No skip available."
                sender.shake()
            }
        }
        
    }
    //50/50 button is activated.
    @IBAction func fiftyButton(_ sender: UIButton) {
        var check = false
        if Utility.sharedInstance.getFiftyBool(){
            viewLabel.text = "50/50 already active."
            sender.shake()
        }else{
            if Utility.sharedInstance.userRewards.count != 0{
                for i in 0..<Utility.sharedInstance.userRewards.count{
                    if Utility.sharedInstance.sendUserReward(index: i) == "50/50"{
                        Utility.sharedInstance.fiftyToggle()
                        fiftyOutlet.isEnabled = true
                        fiftyOutlet.isHidden = false
                        Utility.sharedInstance.removeReward(reward: "50/50")
                        check = true
                        viewLabel.text = "50/50 unlocked."
                        sender.flash()
                        break;
                    }
                }
            }
            if check == false{
                viewLabel.text = "No 50/50 available."
                sender.shake()
            }
        }
        
    }
    
    //Player resumes the game from pause menu
    @IBAction func resumeButton(_ sender: Any) {
        Utility.sharedInstance.musicSelector . volume = 1.0

        if Utility.sharedInstance.timeRunning(){
            unPause()
            runTimer()
            Utility.sharedInstance.timeToggle()
            viewLabel.text = "Rewards"
        }else{
            Utility.sharedInstance.stopTimer()
            Utility.sharedInstance.timeToggle()
        }
        
    }
    //Player pauses the game
    @IBAction func pauseButton(_ sender: Any) {
        Utility.sharedInstance.musicSelector . volume = 0.5
        
        actualScoreInPauseMenu.text = "Current Score: " + String(Utility.sharedInstance.getScore())
        Utility.sharedInstance.timeToggle()
        Utility.sharedInstance.stopTimer()
        pause()
    }
    //Called when timerlabel == 0. Game is over
    func gameOver(){
        if inBuildEquationView{
            closeBuildEquationView()
        }
        if inFallingPuzzle{
            closeFallingPuzzle()
        }
        if inRotationPuzzleView{
            closeRotationPuzzleView()
        }
        Utility.sharedInstance.getClockSound().stop()
        Utility.sharedInstance.timer.invalidate()
        Utility.sharedInstance.musicSelector.volume = 1.0
        Utility.sharedInstance.resetTime()
        //Transition to Leaderboard VC
        self.performSegue(withIdentifier: "endRound", sender: nil)
    }
    //Func that starts the timer which starts the game.
    func begin(){
        runTimer()
    }
    //Func that checks the status of buttons that should be enabled or disabled.
    func checkButtons(){
        var skip = false
        var time = false
        var mull = false
        var fifty = false
    
        if Utility.sharedInstance.getUserRewards().contains("Mulligan") || Utility.sharedInstance.getMulliganBool(){
            mull = true
        }
        if Utility.sharedInstance.getUserRewards().contains("Skip") || Utility.sharedInstance.getSkipBool(){
            skip = true
        }
        if Utility.sharedInstance.getUserRewards().contains("+10s"){
            time = true
        }
        if Utility.sharedInstance.getUserRewards().contains("50/50") || Utility.sharedInstance.getFiftyBool(){
            fifty = true
        }
        
        miniSkip.isHidden = !skip
        miniTime.isHidden = !time
        miniMulligan.isHidden = !mull
        miniFifty.isHidden = !fifty
        if Utility.sharedInstance.getSkipBool(){
            skipOutlet.isHidden = false
            miniSkip.pulsate()
        }
        if Utility.sharedInstance.getMulliganBool(){
            miniMulligan.pulsate()
        }
        if Utility.sharedInstance.getFiftyBool(){
            fiftyOutlet.isHidden = false
            miniFifty.pulsate()
        }
        if Utility.sharedInstance.getFiftyBool() != true{
            fiftyOutlet.isHidden = true
        }
        if correctSymbol.isAnimationPlaying{
            
        }else{
            correctSymbol.stop()
        }
    }
    //Func that updates the timer as well as calls other helper functions like setButtons
    @objc func updateTimer() {
        if inFallingPuzzle{
            if fallingPuzzleTimerHelper{
                fallingPuzzleUserScore -= 1
                fallingPuzzleUserScoreLabel.text = String(fallingPuzzleUserScore)
                fallingPuzzleTimerHelper = !fallingPuzzleTimerHelper
            }else{
                fallingPuzzleTimerHelper = !fallingPuzzleTimerHelper
            }
            
        }
        if Utility.sharedInstance.musicSelector.isPlaying{
        }else{
            Utility.sharedInstance.getMusic().play()
        }
        Utility.sharedInstance.incTime()
        currentScorePauseLabel.text = String(Utility.sharedInstance.getScore()) + " / " + String(Utility.sharedInstance.getQCount()) + " points earned."
        checkButtons()
        streak.text = "Streak: \(Utility.sharedInstance.getStreak())"
        
        //This acts as the countdown notification
        timerLabel.text = String(Utility.sharedInstance.getTime())
        userScoreLabel.text = "Score: \(Utility.sharedInstance.getScore())"
        if Utility.sharedInstance.getTime() <= 10{
            Utility.sharedInstance.musicSelector.volume = 0.30
            Utility.sharedInstance.getClockSound().play()
            timerLabel.textColor = UIColor.red
            timerLabel.pulsateEnd()
        }
        if Utility.sharedInstance.getTime() > 10{
            Utility.sharedInstance.getClockSound().stop()
            Utility.sharedInstance.musicSelector.volume = 1.0
            timerLabel.textColor = UIColor.white
        }
        if skipOutlet.isEnabled{
            if skipOutlet.isHidden{
                skipOutlet.isHidden = false
            }
        }
        if skipOutlet.isEnabled == false{
            skipOutlet.isHidden = true
        }
        if fiftyOutlet.isEnabled{
            if fiftyOutlet.isHidden{
                fiftyOutlet.isHidden = false
            }
        }
        if fiftyOutlet.isEnabled == false{
            fiftyOutlet.isHidden = true
        }
        if Utility.sharedInstance.time == 0{
            gameOver()
        }
        
    }
    //The timer, the core of the game.
    func runTimer() {
        Utility.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(SecondViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    //Pulse the background if the player answered correctly
    func pulseBackground(){
        
        UIView.transition(with: self.overView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.overView.backgroundColor = UIColor.black
        }) { (success) in
            UIView.transition(with: self.overView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.overView.backgroundColor = self.backgroundColor
                //self.performSegue(withIdentifier: "endround", sender: nil)
            }, completion: nil)
        }
        /*
       UIView.animate(withDuration: 0.25, animations: {
        self.overView.backgroundColor = UIColor.cyan
        UIView.animate(withDuration: 0.25, animations: {
            self.overView.backgroundColor = UIColor.white
        })
       })
    */
    }
    //Pulse the background if the player answered incorrectly
    func pulseBackgroundLose(){
        
        UIView.transition(with: self.overView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.overView.backgroundColor = UIColor.darkGray
        }) { (success) in
            UIView.transition(with: self.overView, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.overView.backgroundColor = self.backgroundColor
            }, completion: nil)
        }
        
        /*
        UIView.animate(withDuration: 0.25, animations: {
            //self.view.backgroundColor = UIColor.yellow
            self.overView.backgroundColor = UIColor.yellow
            UIView.animate(withDuration: 0.25, animations: {
                self.overView.backgroundColor = UIColor.white
            })
        })
         */
    }
    
    func animateBackground(){
        
        overView.layer.cornerRadius = 30
        overView.layer.masksToBounds = true
        indexColor = indexColor == (colors.count-1) ? 0 : indexColor+1
        UIView.transition(with: gradient, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradient.firstColor = self.colors[self.indexColor].color1
            self.gradient.secondColor = self.colors[self.indexColor].color2
            self.optionOne.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionThree.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionFive.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionSeven.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionTwo.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionFour.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionSix.layer.borderColor = self.colors[self.indexColor].color1.cgColor
            self.optionEight.layer.borderColor = self.colors[self.indexColor].color1.cgColor
        }) { (success) in
            if Utility.sharedInstance.animateBackgroundLocation() == 1{
                self.animateBackground()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var buttonArray = [optionOne, optionTwo, optionThree, optionFour, optionFive, optionSix, optionSeven, optionEight]
        for all in buttonArray{
            all?.layer.borderWidth = 1
        }
        timerLabel.pulsate()
        Utility.sharedInstance.resetStreak()
        pauseOutlet.flashTwo()
        miniSkip.isEnabled = false
        miniTime.isEnabled = false
        miniFifty.isEnabled = false
        miniMulligan.isEnabled = false
        roundLabel.text = "Round: " + String(Utility.sharedInstance.getRound())
        setButtons()
        
        if Utility.sharedInstance.getSkipBool(){
            skipOutlet.isHidden = false
            miniSkip.pulsate()
        }
        if Utility.sharedInstance.getMulliganBool(){
            miniMulligan.pulsate()
        }
        if Utility.sharedInstance.getFiftyBool(){
            fiftyOutlet.isHidden = false
            miniFifty.pulsate()
        }
    }
    //Slide in animation for the answer buttons
    func slideIn(sender: UIButton){
        sender.center.x = self.view.frame.width + (60)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: ({
            
            sender.center.x = self.view.frame.width / 2
            
        }), completion: nil)
    }
    
    
  
    
    
    override func viewDidLoad() {
        animator = UIDynamicAnimator(referenceView: fallingGameInnerView)
        fallingGameView.layer.cornerRadius = 20
        fallingGameView.layer.masksToBounds = true
        fallingGameInnerView.layer.cornerRadius = 20
        fallingGameInnerView.layer.masksToBounds = true
        rotationBottomView.layer.cornerRadius = 20
        
        var x = Utility.sharedInstance.addQuestionThree()
        
        advancedEquationQuestion1.latex = "x = " + x.0
        advancedEquationQuestion1.textColor = .white
        
        buildEquationInnerView.layer.cornerRadius = 20
        buildEquationInnerView.layer.masksToBounds = true
        rotationInnerBackgroundView.layer.cornerRadius = 20
        rotationInnerBackgroundView.layer.masksToBounds = true
        rotationBackgroundView.layer.cornerRadius = 20
        rotationBackgroundView.layer.masksToBounds = true
        buildEquationView.layer.cornerRadius = 20
        buildEquationView.layer.masksToBounds = true
        rotationPuzzleView.layer.cornerRadius = 20
        rotationPuzzleView.layer.masksToBounds = true
        leftPicker.delegate = self
        leftPicker.dataSource = self
        midPicker.delegate = self
        midPicker.dataSource = self
        rightPicker.delegate = self
        rightPicker.dataSource = self
        pauseBorder.layer.cornerRadius = 20
        questionLabel.layer.cornerRadius = 10
        actualAnswer.layer.cornerRadius = 10
        actualAnswer.layer.masksToBounds = true
        questionLabel.layer.masksToBounds = true
        rewardBorderView.layer.cornerRadius = 5
        backgroundColor = overView.backgroundColor!
        Utility.sharedInstance.decideBackgroundAnimation(num: 1)
        //roundLabel.text = "Round: " + String(Utility.sharedInstance.getRound())
        videoAd.isHidden = false
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        
        
        Utility.sharedInstance.toggleHomePageAnimate()
        animateBackground()
        Utility.sharedInstance.mainMusicPlaying = false
        Utility.sharedInstance.getMenuMusic().stop()
        if Utility.sharedInstance.getMusicStatus(){
            
        }else{
            Utility.sharedInstance.toggleMusicStatus()
            Utility.sharedInstance.getMusic().play()
        }
        begin()
        skipOutlet.isHidden = false
        skipOutlet.isHidden = false
        super.viewDidLoad()
        effect = visualEffect.effect
        visualEffect.effect = nil
        theView.layer.cornerRadius = 20
        GADBannerView.adUnitID = "ca-app-pub-3594079496005269/7538173546"
        GADBannerView.rootViewController = self
        GADBannerView.load(GADRequest())
        //openAdvancedEquationView()
        
    }
    
    func pause(){
        self.view.addSubview(theView)
        Utility.sharedInstance.stopTimer()
        Utility.sharedInstance.getClockSound().stop()
        theView.center = self.view.center
        theView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        theView.alpha = 0
        if Bool.random(){
            danceAvatar.setAnimation(named: "techno_penguin")
            danceAvatar.loopAnimation = true
            danceAvatar.play()
        }else{
            danceAvatar.setAnimation(named: "deadpool")
            danceAvatar.loopAnimation = true
            danceAvatar.play()
        }
        
        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.theView.alpha = 1
            self.theView.transform = CGAffineTransform.identity
            
        }
    }
    //Player unpauses the game
    func unPause(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.theView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.theView.alpha = 0
            self.visualEffect.effect = nil
            if self.inFallingPuzzle || self.inBuildEquationView || self.inRotationPuzzleView{
                
            }else{
                self.setButtons()
            }
            
        }) {(success:Bool) in
            self.theView.removeFromSuperview()
        }
    }
    
    
    @IBAction func videoAdAction(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            videoAd.isHidden = true
        }
    }
    
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        Utility.sharedInstance.addreward(index: Int.random(in: 0..<4))
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3594079496005269/5335639890")
        var rando = Int.random(in: 0..<4)
        Utility.sharedInstance.addreward(index: rando)
        viewLabel.text = "Video reward: " + Utility.sharedInstance.availAwards[rando]
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
    func setBuildQuestionUserLabel(){
        buildEquationUserAnswerLabel.text = buildEquationUserAnswerArray[0] + buildEquationAnswerArray[1] +  buildEquationAnswerArray[2] + buildEquationUserAnswerArray[1] + buildEquationAnswerArray[4] + buildEquationUserAnswerArray[2] + buildEquationAnswerArray[6]
        
        
        if getSymbols() == Double(buildEquationAnswerLabel.text!)!{
            //succeeded
            closeBuildEquationView()
            checkHelper(score: 5, time: 12)
            Utility.sharedInstance.getCorrectSound().play()
            Utility.sharedInstance.incStreak()
            Utility.sharedInstance
            if Utility.sharedInstance.streak % 5 == 0{
                streakBonus()
            }
            buildEquationAnswerArray.removeAll()
            
            setButtons()
        }
        
        
    }
    
    func getSymbols() -> Double{
        var firstNum = 0.0
        var endNum = 0.0
        if buildEquationUserAnswerArray.contains("?"){
            
        }else{
            
            switch buildEquationAnswerArray[4] {
            case "+":
                firstNum = Double(buildEquationUserAnswerArray[1])! + Double(buildEquationUserAnswerArray[2])!
            case "-":
                firstNum = Double(buildEquationUserAnswerArray[1])! - Double(buildEquationUserAnswerArray[2])!
            case "/":
                firstNum = Double(buildEquationUserAnswerArray[1])! / Double(buildEquationUserAnswerArray[2])!
            case "*":
                firstNum = Double(buildEquationUserAnswerArray[1])! * Double(buildEquationUserAnswerArray[2])!
            default:
                print("what?")
            }
            switch buildEquationAnswerArray[1] {
            case "+":
                endNum = Double(buildEquationUserAnswerArray[0])! + firstNum
            case "-":
                endNum = Double(buildEquationUserAnswerArray[0])! - firstNum
            case "/":
                endNum = Double(buildEquationUserAnswerArray[0])! / firstNum
            case "*":
                endNum = Double(buildEquationUserAnswerArray[0])! * firstNum
            default:
                print("how?")
            }
        }
        
        return endNum
    }
    
    
    
    func setupBuildEquationView(){
        var question = Utility.sharedInstance.decideMedium(decide: true)
        while question.1 > 125{
            question = Utility.sharedInstance.decideMedium(decide: true)
        }
        moreTime(time: 5)
        buildEquationAnswerArray = []
        buildEquationUserAnswerArray = ["?", "?", "?"]
        buildEquationUserAnswerLabel.text = ""
        buildEquationAnswerLabel.text = ""
        leftArray = []
        midArray = []
        rightArray = []
        var x = question.0.replacingOccurrences(of: " ", with: "")
        for chars in x{
            buildEquationAnswerArray.append(String(chars))
            
        }
        if buildEquationAnswerArray[0].isEmpty{
            buildEquationAnswerArray.remove(at: 0)
        }
        
        buildEquationAnswerLabel.text = String(question.1)
        
        
        for index in 0...1{
            var randNo = String(Int.random(in: 0..<10))
            while leftArray.contains(randNo) || randNo == buildEquationAnswerArray[0]{
                randNo = String(Int.random(in: 0..<10))
            }
            leftArray.append(randNo)
            randNo = String(Int.random(in: 0..<10))
            while midArray.contains(randNo) || randNo == buildEquationAnswerArray[3]{
                randNo = String(Int.random(in: 0..<10))
            }
            midArray.append(randNo)
            randNo = String(Int.random(in: 0..<10))
            while rightArray.contains(randNo) || randNo == buildEquationAnswerArray[5]{
                randNo = String(Int.random(in: 0..<10))
            }
            rightArray.append(randNo)
            
        }
        
        //leftArray.remove(at: 0)
        if leftArray[0].isEmpty{
            leftArray.remove(at: 0)
        }
        if midArray[0].isEmpty{
            midArray.remove(at: 0)
        }
        if rightArray[0].isEmpty{
            rightArray.remove(at: 0)
        }
        
        
        //midArray.remove(at: 0)
        //rightArray.remove(at: 0)
        leftArray.insert(buildEquationAnswerArray[0], at: Int.random(in: 0...leftArray.count))
        midArray.insert(buildEquationAnswerArray[3], at: Int.random(in: 0...midArray.count))
        rightArray.insert(buildEquationAnswerArray[5], at: Int.random(in: 0...rightArray.count))
        if Utility.sharedInstance.getDifficulty() == 0{
            var setup = [leftArray, midArray, rightArray]
            var helper = [buildEquationAnswerArray[0], buildEquationAnswerArray[3], buildEquationAnswerArray[5]]
            var index = Int.random(in: 0..<setup.count)
            switch setup[index]{
            case leftArray:
                buildEquationUserAnswerArray[index] = buildEquationAnswerArray[0]
                leftArray[0] = buildEquationAnswerArray[0]
                leftArray[1] = buildEquationAnswerArray[0]
                leftArray[2] = buildEquationAnswerArray[0]
            
            case midArray:
                buildEquationUserAnswerArray[index] = buildEquationAnswerArray[3]
                midArray[0] = buildEquationAnswerArray[3]
                midArray[1] = buildEquationAnswerArray[3]
                midArray[2] = buildEquationAnswerArray[3]
            
            case rightArray:
                buildEquationUserAnswerArray[index] = buildEquationAnswerArray[5]
                rightArray[0] = buildEquationAnswerArray[5]
                rightArray[1] = buildEquationAnswerArray[5]
                rightArray[2] = buildEquationAnswerArray[5]
            default:
                print("how?")
            
            }
        }
        setBuildQuestionUserLabel()
        leftPicker.reloadAllComponents()
        midPicker.reloadAllComponents()
        rightPicker.reloadAllComponents()
        self.view.addSubview(buildEquationView)
        inBuildEquationView = true
        buildEquationView.center = self.view.center
        buildEquationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        buildEquationView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.buildEquationView.alpha = 1
            self.buildEquationView.transform = CGAffineTransform.identity
            
        }
    }
    
    @IBAction func skipBuildEquation(_ sender: Any) {
        Utility.sharedInstance.resetStreak()
        closeBuildEquationView()
    }
    func closeBuildEquationView(){
        inBuildEquationView = false
        UIView.animate(withDuration: 0.3, animations: {
            self.buildEquationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.buildEquationView.alpha = 0
        }) {(success:Bool) in
            self.buildEquationView.removeFromSuperview()
        }
    }
    
    func setPuzzleLabels(){
        if midPuzzleArray[0] == ""{
            midPuzzleArray.remove(at: 0)
        }
        
        var inner =  [rotationInnerOne, rotationInnerTwo, rotationInnerThree, rotationInnerFour]
        var mid = [rotationMidOne, rotationMidTwo, rotationMidThree, rotationMidFour]
        var outer = [rotationOuterOne, rotationOuterTwo, rotationOuterThree, rotationOuterFour]
        for total in 0..<inner.count{
            inner[total]?.text = String(innerPuzzleArray[total])
            outer[total]?.text = String(outerPuzzleArray[total])
            mid[total]?.text = String(midPuzzleArray[total])
            
        }
        
    }
    
    func checkPuzzleAnswer(){
        
        if solveEquation(equation: [String(innerPuzzleArray[1]), midPuzzleArray[1], String(outerPuzzleArray[1])]) == Int(rotationTopAnswer.text!) && solveEquation(equation: [String(innerPuzzleArray[2]), midPuzzleArray[2], String(outerPuzzleArray[2])]) == Int(rotationRightAnswer.text!){
            checkHelper(score: 10, time: 20)
            Utility.sharedInstance.getCorrectSound().play()
            Utility.sharedInstance.incStreak()
            Utility.sharedInstance
            if Utility.sharedInstance.streak % 5 == 0{
                streakBonus()
            }
            
            puzzleWinAnimation()
        }
    }
    
    
    func animateInner(){
        
    }
    
    func animateOuter(){
        hideAllLabels(num: 0)
        hideAllLabels(num: 2)
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [], animations: {
            self.outerCircleDegree += 270
            self.rotateArrayLeft(side: true)
            self.rotationOuterCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.outerCircleDegree * .pi)/180.0)))
            self.innerCircleDegree -= 270
            self.rotateArrayRight(side: false)
            self.rotationInnerCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.innerCircleDegree * .pi)/180.0)))
            self.setPuzzleLabels()
            
            
            
        }, completion: { (finished: Bool) in
            self.showAllLabels(num: 0)
            self.showAllLabels(num: 2)
            self.closeRotationPuzzleView()
        })
    }
    
    
    
    func puzzleWinAnimation(){
        animateInner()
        animateOuter()
        
        
    }
    
    func solveEquation(equation: [String]) -> Int{
        var answer = 0
        switch equation[1]{
        case "+":
            answer =  Int(equation[0])! + Int(equation[2])!
        case "-":
            answer =  Int(equation[0])! - Int(equation[2])!
        case "*":
            answer =  Int(equation[0])! * Int(equation[2])!
        default:
            print("Okay...")
        }
        return answer
    }
    
    
    func setupRotationPuzzle(){
        let question1 = Utility.sharedInstance.createPuzzleProblem()
        let question2 = Utility.sharedInstance.createPuzzleProblem()
        print("here")
        print(question1.0)
        print(question2.0)
        innerPuzzleArray = []
        midPuzzleArray = []
        outerPuzzleArray = []
        rotationRightAnswer.text = String(Int(question1.1))
        rotationTopAnswer.text = String(Int(question2.1))
        let decideIndex = Int.random(in: 0..<4)
        let decideIndexTwo = Int.random(in: 0..<4)
        for number in 0..<4{
            innerPuzzleArray.append(Int.random(in: 0...9))
            outerPuzzleArray.append(Int.random(in: 0...9))
            var temp = Utility.sharedInstance.getSymbol()
            while temp == "/"{
                temp = Utility.sharedInstance.getSymbol()
            }
            midPuzzleArray.append(temp)
        }
        //symbols could be made random too
        midPuzzleArray[1] = String(question2.0[1])
        midPuzzleArray[2] = String(question1.0[1])
        
        switch decideIndex{
        case 0:
            innerPuzzleArray[0] = Int(String(question1.0[0]))!
            innerPuzzleArray[3] = Int(String(question2.0[0]))!
        case 1:
            innerPuzzleArray[1] = Int(String(question1.0[0]))!
            innerPuzzleArray[0] = Int(String(question2.0[0]))!
        case 2:
            innerPuzzleArray[2] = Int(String(question1.0[0]))!
            innerPuzzleArray[1] = Int(String(question2.0[0]))!
        case 3:
            innerPuzzleArray[3] = Int(String(question1.0[0]))!
            innerPuzzleArray[2] = Int(String(question2.0[0]))!
        default:
            print("Elaborate?")
        }
        switch decideIndexTwo{
        case 0:
            outerPuzzleArray[0] = Int(String(question1.0[2]))!
            outerPuzzleArray[3] = Int(String(question2.0[2]))!
        case 1:
            outerPuzzleArray[1] = Int(String(question1.0[2]))!
            outerPuzzleArray[0] = Int(String(question2.0[2]))!
        case 2:
            outerPuzzleArray[2] = Int(String(question1.0[2]))!
            outerPuzzleArray[1] = Int(String(question2.0[2]))!
        case 3:
            outerPuzzleArray[3] = Int(String(question1.0[2]))!
            outerPuzzleArray[2] = Int(String(question2.0[2]))!
        default:
            print("Elaborate?")
        }
        setPuzzleLabels()
    }
    
    func rotateArrayLeft(side: Bool){
        var tempArray = [Int()]
        if side{
            tempArray = [outerPuzzleArray[1], outerPuzzleArray[2], outerPuzzleArray[3], outerPuzzleArray[0]]
            outerPuzzleArray = tempArray
            
        }else{
            tempArray = [innerPuzzleArray[1], innerPuzzleArray[2], innerPuzzleArray[3], innerPuzzleArray[0]]
            innerPuzzleArray = tempArray
        }
    }
    
    func rotateArrayRight(side: Bool){
        var tempArray = [Int()]
        if side{
            tempArray = [outerPuzzleArray[3], outerPuzzleArray[0], outerPuzzleArray[1], outerPuzzleArray[2]]
            outerPuzzleArray = tempArray
        }else{
            tempArray = [innerPuzzleArray[3], innerPuzzleArray[0], innerPuzzleArray[1], innerPuzzleArray[2]]
            innerPuzzleArray = tempArray
        }
    }
    
    func openRotationPuzzleView(){
        setupRotationPuzzle()
        self.view.addSubview(rotationPuzzleView)
        moreTime(time: 10)
        inRotationPuzzleView = true
        rotationPuzzleView.center = self.view.center
        rotationPuzzleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        rotationPuzzleView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.rotationPuzzleView.alpha = 1
            self.rotationPuzzleView.transform = CGAffineTransform.identity
            
        }
    }
    
    func hideAllLabels(num: Int){
        var inner =  [rotationInnerOne, rotationInnerTwo, rotationInnerThree, rotationInnerFour]
        var mid = [rotationMidOne, rotationMidTwo, rotationMidThree, rotationMidFour]
        var outer = [rotationOuterOne, rotationOuterTwo, rotationOuterThree, rotationOuterFour]
        
        var container = [inner, mid, outer]
        for all in container[num]{
            all?.isHidden = true
        }
        
    }
    
    func showAllLabels(num: Int){
        var inner =  [rotationInnerOne, rotationInnerTwo, rotationInnerThree, rotationInnerFour]
        var mid = [rotationMidOne, rotationMidTwo, rotationMidThree, rotationMidFour]
        var outer = [rotationOuterOne, rotationOuterTwo, rotationOuterThree, rotationOuterFour]
        
        var container = [inner, mid, outer]
        for all in container[num]{
            all?.isHidden = false
            all?.fadeIn()
        }
    }
    func closeRotationPuzzleView(){
        innerCircleDegree = 0.0
        outerCircleDegree = 0.0
        inRotationPuzzleView = false
        UIView.animate(withDuration: 0.3, animations: {
            self.rotationPuzzleView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.rotationPuzzleView.alpha = 0
        }) {(success:Bool) in
            self.rotationPuzzleView.removeFromSuperview()
        }
    }
    
    
    @IBAction func rotateInnerCircleLeft(_ sender: UIButton) {
        sender.flashPlus()
        hideAllLabels(num: 0)
        UIView.animate(withDuration: 1.25, delay: 0.0, options: [], animations: {
            self.innerCircleDegree += 90
            self.rotateArrayLeft(side: false)
            self.rotationInnerCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.innerCircleDegree * .pi)/180.0)))
            self.setPuzzleLabels()
            
        }, completion: { (finished: Bool) in
            self.showAllLabels(num: 0)
            self.checkPuzzleAnswer()
            
        })
    }
    
    @IBAction func rotateInnerCircleRight(_ sender: UIButton) {
       sender.flashPlus()
        hideAllLabels(num: 0)
        UIView.animate(withDuration: 1.25, delay: 0.0, options: [], animations: {
            self.innerCircleDegree -= 90
            self.rotateArrayRight(side: false)
            self.rotationInnerCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.innerCircleDegree * .pi)/180.0)))
            self.setPuzzleLabels()
            
        }, completion: { (finished: Bool) in
            self.showAllLabels(num: 0)
            self.checkPuzzleAnswer()
        })
    }
    
    @IBAction func rotateOuterCircleLeft(_ sender: UIButton) {
        sender.flashPlus()
        hideAllLabels(num: 2)
        UIView.animate(withDuration: 1.25, delay: 0.0, options: [], animations: {
            self.outerCircleDegree += 90
            self.rotateArrayLeft(side: true)
            self.rotationOuterCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.outerCircleDegree * .pi)/180.0)))
            
            self.setPuzzleLabels()
            
        }, completion: { (finished: Bool) in
            self.showAllLabels(num: 2)
            self.checkPuzzleAnswer()
        })
    }
    
    @IBAction func rotateOuterCircleRight(_ sender: UIButton) {
        sender.flashPlus()
        hideAllLabels(num: 2)
        UIView.animate(withDuration: 1.25, delay: 0.0, options: [], animations: {
            self.outerCircleDegree -= 90
            self.rotateArrayRight(side: true)
            self.rotationOuterCircle.transform = CGAffineTransform(rotationAngle: (CGFloat(-1*(self.outerCircleDegree * .pi)/180.0)))
            
            self.setPuzzleLabels()
            
        }, completion: { (finished: Bool) in
            self.showAllLabels(num: 2)
            self.checkPuzzleAnswer()
        })
    }
    func setupFallingPuzzle(){
        createButtonForFallingPuzzle()
    }
    
    
    
    func createButtonForFallingPuzzle(){
        
        var algebra = ["+"]
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            let button = UIButton(frame: CGRect(x: Int.random(in: 0..<Int(self.fallingGameInnerView.frame.width-40)), y: 0, width: 55, height: 45))
            button.backgroundColor = .clear
            //old decision
            
            //end old decision
            button.setTitle(algebra[Int.random(in: 0..<algebra.count)] + String(Int.random(in: 1..<10)), for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
            var x = String((button.titleLabel?.text!)!)
            if x[0] == "+"{
                button.setTitleColor(.cyan, for: .normal)
            }else{
                button.setTitleColor(.red, for: .normal)
            }
            
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
            self.buttonCreations.append(button)
            self.fallingGameInnerView.addSubview(button)
            
            self.collision = UICollisionBehavior(items: [button])
            self.collision.translatesReferenceBoundsIntoBoundary = true
            self.collision.collisionDelegate = self
            self.gravity = UIGravityBehavior(items: [button])
            self.gravity.magnitude = 0.1
            
            
            self.animator.addBehavior(self.gravity)
            self.animator.addBehavior(self.collision)
        }) { (success) in
            if self.inFallingPuzzle{
                if self.buttonCreations.count > 6{
                    self.buttonCreations[0].removeFromSuperview()
                    self.buttonCreations.remove(at: 0)
                    self.animator.removeBehavior(self.animator.behaviors[0])
                    self.animator.removeBehavior(self.animator.behaviors[1])
                }
                self.createButtonForFallingPuzzle()
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        print(sender.titleLabel!.text)
        var x = sender.titleLabel!.text!
        if x[0] == "+"{
            fallingPuzzleUserScore += Int(x[1])!
        }else{
            fallingPuzzleUserScore -= Int(x[1])!
        }
        
        fallingGameUserSelections.append(sender.titleLabel!.text!)
        
        sender.removeFromSuperview()
        if fallingPuzzleUserScore > 21{
            var y = fallingPuzzleUserScore - 21
            fallingPuzzleUserScore = y
        }
        UIView.animate(withDuration: 0.25) {
            self.fallingPuzzleUserScoreLabel.text = String(self.fallingPuzzleUserScore)
        }
        
        if fallingPuzzleUserScore == 21{
            closeFallingPuzzle()
            
            checkHelper(score: 5, time: 12)
            Utility.sharedInstance.getCorrectSound().play()
            Utility.sharedInstance.incStreak()
            Utility.sharedInstance
            if Utility.sharedInstance.streak % 5 == 0{
                streakBonus()
            }
            //buildEquationAnswerArray.removeAll()
            
            
            setButtons()
        }
        
        
        
    }
    
    
    
    func removeAllButtons(){
        for all in  buttonCreations{
            all.removeFromSuperview()
        }
        buttonCreations = []
    }
    
    func openFallingPuzzle(){
        fallingPuzzleUserScore = 0
        inFallingPuzzle = true
        setupFallingPuzzle()
        self.view.addSubview(fallingGameView)
        moreTime(time: 10)
        fallingGameView.center = self.view.center
        fallingGameView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        fallingGameView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.fallingGameView.alpha = 1
            self.fallingGameView.transform = CGAffineTransform.identity
            
        }
    }
    
    func closeFallingPuzzle(){
        inFallingPuzzle = false
        animator.removeAllBehaviors()
        removeAllButtons()
        UIView.animate(withDuration: 0.3, animations: {
            self.fallingGameView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.fallingGameView.alpha = 0
        }) {(success:Bool) in
            self.fallingGameView.removeFromSuperview()
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           endedContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?){
        //ehhh
    }
    
    
    func openAdvancedEquationView(){
        self.view.addSubview(advancedEquationView)
        moreTime(time: 10)
        advancedEquationView.center = self.view.center
        advancedEquationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        advancedEquationView.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.advancedEquationView.alpha = 1
            self.advancedEquationView.transform = CGAffineTransform.identity
            
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case leftPicker:
            return leftArray.count
        case midPicker:
            return midArray.count
        case rightPicker:
            return midArray.count
        default:
            return 1
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView{
        case leftPicker:
            print(leftArray)
            return leftArray[row]
        case midPicker:
            print(midArray)
            return midArray[row]
        case rightPicker:
            print(rightArray)
            return rightArray[row]
        default:
            return "error"
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView{
        case leftPicker:
            buildEquationUserAnswerArray[0] = leftArray[row]
            setBuildQuestionUserLabel()
        case midPicker:
            buildEquationUserAnswerArray[1] = midArray[row]
            setBuildQuestionUserLabel()
        case rightPicker:
            buildEquationUserAnswerArray[2] = rightArray[row]
            setBuildQuestionUserLabel()
        default:
            print("yes")
        }
    }
    
    
}

