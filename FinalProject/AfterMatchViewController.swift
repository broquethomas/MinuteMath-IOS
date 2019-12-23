//
//  AfterMatchViewController.swift
//  FinalProject
//
//  Created by Broque on 11/14/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit
import Lottie
import GoogleMobileAds

class AfterMatchViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var gradient: UIViewX!
    @IBOutlet var fireworkAnimation: LOTAnimationView!
    @IBOutlet var winAnimation: LOTAnimationView!
    @IBOutlet weak var infoButton: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var submitOutlet: UIButton!
    var interstitial: GADInterstitial!
    var count = 0
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
            if Utility.sharedInstance.animateBackgroundLocation() == 2{
                self.animateBackground()
            }
        }
    }
    
    //Animate the lottie animation
    func winAnimationActivate(){
        
        if Utility.sharedInstance.getScore() >= 10 && Double(Utility.sharedInstance.getScore()) / Double(Utility.sharedInstance.getQCount()) >= 0.75{
            fireworkAnimation.setAnimation(named: "ribbon")
            fireworkAnimation.play()
            winAnimation.setAnimation(named: "funky_chicken")
            winAnimation.loopAnimation = true
            winAnimation.play()
        }else if Double(Utility.sharedInstance.getScore()) / Double(Utility.sharedInstance.getQCount()) >= 0.5{
            fireworkAnimation.setAnimation(named: "ribbon")
            fireworkAnimation.play()
            winAnimation.setAnimation(named: "happy")
            winAnimation.loopAnimation = false
            winAnimation.play()
        }else{
            winAnimation.setAnimation(named: "crying")
            winAnimation.loopAnimation = true
            winAnimation.play()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Submit player to leaderboard
    @IBAction func submitButton(_ sender: Any) {
        userInput.resignFirstResponder()
        
        if Utility.sharedInstance.getScore() != 0 && Double(Utility.sharedInstance.getScore()) / Double(Utility.sharedInstance.getQCount()) < 0.75{
            infoButton.text = "Score / Possible score too low to record"
        }else{
            if let text = userInput.text , !text.isEmpty{
                
                if Utility.sharedInstance.checkLeaderboard(name: text, score: Utility.sharedInstance.getScore()){
                    
                    infoButton.text = "User score updated."
                    Utility.sharedInstance.addLeader(name: text, score: Utility.sharedInstance.getScore())
                    Utility.sharedInstance.saveUserInfo()
                    Utility.sharedInstance.organize()
                    infoButton.pulsateQuick()
                }else{
                    if Utility.sharedInstance.getScore() != 0{
                        
                        Utility.sharedInstance.addLeader(name: text, score: Utility.sharedInstance.getScore())
                        infoButton.text = "Successfully added " + text
                        
                        Utility.sharedInstance.saveUserInfo()
                        Utility.sharedInstance.organize()
                        infoButton.pulsateQuick()
                        
                    }else{
                        if count == 0 {
                            infoButton.text = "Uhh.. let's not."
                            count += 1
                        }else if count == 1{
                            infoButton.text = "Ugh.. why though?"
                            count += 1
                        }else if count == 2{
                            infoButton.text = "Nah, button's gone now anyway :)"
                            submitOutlet.setTitle("                    ", for: .normal)
                            count += 1
                        }else if count == 3{
                            Utility.sharedInstance.addLeader(name: text, score: Utility.sharedInstance.getScore())
                            infoButton.text = "What..!? Fine.. Added " + text
                            count = 0
                            userInput.resignFirstResponder()
                            Utility.sharedInstance.organize()
                            infoButton.pulsateQuick()
                            submitOutlet.setTitle("Submit to Leaderboard", for: .normal)
                        }
                    }
                }
            }else{
                infoButton.text = "Invalid name."
            }
        }
        
    }
    
    //Player is transfered to the main VC
    @IBAction func endButton(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }else{
            print("not ready")
            Utility.sharedInstance.resetRound()
            Utility.sharedInstance.resetRewards()
            Utility.sharedInstance.resetScore()
            Utility.sharedInstance.resetTime()
            Utility.sharedInstance.toggleMusicStatus()
            if Utility.sharedInstance.getMulliganBool(){
                Utility.sharedInstance.toggleMulligan()
            }
            if Utility.sharedInstance.getSkipBool(){
                Utility.sharedInstance.toggleSkipBool()
            }
            if Utility.sharedInstance.getFiftyBool(){
                Utility.sharedInstance.fiftyToggle()
            }
            Utility.sharedInstance.incCount(num: -Utility.sharedInstance.getQCount())
            self.performSegue(withIdentifier: "done", sender: nil)
        }
        //Transition to Main Menu VC below
        
        
    }
    //Player chooses to play more and is transfered to the reward VC or back to the game depending on score.
    @IBAction func moreButton(_ sender: Any) {
    //Transition to the Reward VC or The Game VC
    //depending on userScore / sharedInstance.questionArray.count
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }else{
            print("not ready")
            Utility.sharedInstance.incRound()
            if Utility.sharedInstance.getScore() < 10 || Double(Utility.sharedInstance.getScore()) / Double(Utility.sharedInstance.getQCount()) < 0.75{
                self.performSegue(withIdentifier: "lowScore", sender: nil)
                Utility.sharedInstance.resetScore()
                Utility.sharedInstance.resetQuestions()
                Utility.sharedInstance.incCount(num: -Utility.sharedInstance.getQCount())
            }else{
                self.performSegue(withIdentifier: "continue", sender: nil)
                Utility.sharedInstance.resetScore()
                Utility.sharedInstance.resetQuestions()
                Utility.sharedInstance.incCount(num: -Utility.sharedInstance.getQCount())
            }
        }
        
    }
    //Set labels for user score
    func setInfo(){
        if Utility.sharedInstance.getScore() == Utility.sharedInstance.getQCount() && Utility.sharedInstance.getScore() != 0{
            userScore.text = "Perfect Score! " + String(Utility.sharedInstance.getScore()) + " points!"
        }else if Utility.sharedInstance.getScore() == Utility.sharedInstance.getQCount() && Utility.sharedInstance.getScore() == 0{
            userScore.text = "Uhhh... You didn't answer..."
        }else{
            userScore.text = String(Utility.sharedInstance.getScore()) + " / " + String(Utility.sharedInstance.getQCount()) + " points earned. "
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        submitOutlet.setTitle("Submit to Leaderboard", for: .normal)
        count = 0
        setInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInput.delegate = self
        
        interstitial = createAndLoadInterstitial()
        //interstitial.delegate = self
        // Do any additional setup after loading the view.
        Utility.sharedInstance.decideBackgroundAnimation(num: 2)
        animateBackground()
        winAnimationActivate()
    }
    
    
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3594079496005269/8383092176")
        
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
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
