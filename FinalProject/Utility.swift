//
//  Utility.swift
//  MinuteMath
//
//  Created by Broque on 11/10/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class Utility{
    
    var difficultyArray: [String]
    var leaderArray: [String]
    var leaderArrayEasy: [String]
    var leaderArrayMedium: [String]
    var leaderScoreArray: [Int]
    var leaderScoreArrayEasy: [Int]
    var leaderScoreArrayMedium: [Int]
    var questionArray: [String]
    var questionCount: Int
    var answerArray: [Double]
    var userRewards: [String]
    var availAwards: [String]
    var mulliganBool: Bool
    var skipBool: Bool
    var descriptions: [String]
    var symbols: [String]
    var time: Int
    var userScore: Int
    var roundCount: Int
    var resumeTime: Bool
    var selector: Bool
    var decisionTwoAnswer: Bool
    var overallSelector: Bool
    var fiftyBool: Bool
    var coolimage: [UIImage]
    var images: [UIImage]
    var streak: Int
    var timer: Timer
    var checkX: Bool
    var audioPlayer: AVAudioPlayer!
    var audioPlayerCorrect: AVAudioPlayer!
    var difficulty: Int
    var musicSelector: AVAudioPlayer!
    var mainMenuMusic: AVAudioPlayer!
    var musicIsPlaying: Bool
    var mainMusicPlaying: Bool
    var colors: [(color1: UIColor , color2: UIColor)]
    var homePageAnimate = true
    var homePageAnimation = 0;
    var allQuestionsFromMatch = [Int: (String, Double)]()
    
    
    
    static let sharedInstance = Utility()

    init() {
        leaderArray = ["Hugo Chavez", "Inigo Montoya", "Rick Moranis"]
        leaderArrayEasy = ["Hugo Chavez", "Inigo Montoya", "Rick Moranis"]
        leaderArrayMedium = ["Hugo Chavez", "Inigo Montoya", "Rick Moranis"]
        leaderScoreArray = [25, 30, 18]
        leaderScoreArrayEasy = [13, 20, 8]
        leaderScoreArrayMedium = [20, 25, 14]
        
        questionArray = []
        symbols = ["+", "-", "/", "*"]
        answerArray = []
        userScore = 0 // revert to 0 when testing is finished
        timer = Timer()
        time = 60
        userRewards = []
        availAwards = ["Mulligan", "+10s", "Skip", "50/50"]
        descriptions = ["One free mistake", "Add +10 seconds to the timer", "Skip a difficult problem", "Remove half the answers"]
        roundCount = 1
        resumeTime = false
        mulliganBool = false
        skipBool = false
        selector = true
        overallSelector = true
        fiftyBool = false
        coolimage = []
        images = []
        decisionTwoAnswer = false
        questionCount = 0
        streak = 0
        checkX = false
        difficulty = 0
        difficultyArray = ["Easy", "Medium", "Hard"]
        musicIsPlaying = false
        mainMusicPlaying = false
        
        colors = []
        coolimage = createCoolImageArray()
        images = createImageArray()
        setAudioClock()
        setAudioCLockCorrect()
        setColors()
        loadUserInfo()
    }
    //Set color array for background gradient
    func setColors(){
        let colorA = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        let colorB = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        let colorC = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        let colorD = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        let colorE = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        let colorF = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        let colorG = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        let colorH = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        let colorI = #colorLiteral(red: 0.1933895466, green: 0.3359993638, blue: 1, alpha: 1)
        let colorJ = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        let colorK = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        let colorL = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        let colorM = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        let colorN = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        colors.append((color1: colorA, color2: colorB))
        colors.append((color1: colorC, color2: colorD))
        colors.append((color1: colorE, color2: colorF))
        colors.append((color1: colorG, color2: colorH))
        colors.append((color1: colorI, color2: colorJ))
        colors.append((color1: colorK, color2: colorL))
        colors.append((color1: colorM, color2: colorN))
    }
    
    func saveUserInfo(){
        var leaderboardCollection = [leaderArray, leaderArrayMedium, leaderArrayEasy]
        var leaderboardScores = [leaderScoreArray, leaderScoreArrayMedium, leaderScoreArrayEasy]
        UserDefaults.standard.set(leaderboardCollection, forKey: "leaderNames")
        UserDefaults.standard.set(leaderboardScores, forKey: "leaderScores")
        
    }
    func loadUserInfo(){
        if var tempData = UserDefaults.standard.array(forKey: "leaderNames") as? [[String]] {
            
            leaderArrayEasy = tempData[2]
            leaderArrayMedium = tempData[1]
            leaderArray = tempData[0]
        }
        if var tempDataNums = UserDefaults.standard.array(forKey: "leaderScores") as? [[Int]] {
            
            leaderScoreArrayEasy = tempDataNums[2]
            leaderScoreArrayMedium = tempDataNums[1]
            leaderScoreArray = tempDataNums[0]
        }
    }
    
    
    func toggleHomePageAnimate(){
        homePageAnimate = !homePageAnimate
    }
    
    func animateHomePage() -> Bool{
        return homePageAnimate
    }
    
    func animateBackgroundLocation() -> Int{
        return homePageAnimation
    }
    
    func decideBackgroundAnimation(num: Int){
        homePageAnimation = num
    }
    
    
    //Toggle music
    func toggleMainMusic(){
        mainMusicPlaying = !mainMusicPlaying
    }
    //Check if music playing
    func toggleMusicStatus(){
        musicIsPlaying = !musicIsPlaying
    }
    //Return menu music
    func getMenuMusic() -> AVAudioPlayer{
        
        if Bool.random(){
           
            let audio = Bundle.main.path(forResource: "menu", ofType: "mp3")
            do{
                //mainMenuMusic = AVAudioPlayer()
                mainMenuMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find main audio")
            }
        }else{
            let audio = Bundle.main.path(forResource: "menu", ofType: "mp3")
            do{
                //mainMenuMusic = AVAudioPlayer()
                mainMenuMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find main audio")
            }
        }
        
        mainMenuMusic.numberOfLoops = -1
        return mainMenuMusic
    }
    //Get game music for difficulty.
    func getMusic() -> AVAudioPlayer{
        switch getDifficulty() {
        case 0:
            var audio = Bundle.main.path(forResource: "PurplePlanetMusic-MumbaiMood", ofType: "mp3")
            if(Bool.random()){
                 audio = Bundle.main.path(forResource: "PurplePlanetMusic-MumbaiMood", ofType: "mp3")
            }else{
                 audio = Bundle.main.path(forResource: "mainMusic2", ofType: "mp3")
            }
            
            do{
                //musicSelector = AVAudioPlayer()
                musicSelector = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find correct audio")
            }
        case 1:
            var audio = Bundle.main.path(forResource: "mediumMusic", ofType: "mp3")
            if(Bool.random()){
                 audio = Bundle.main.path(forResource: "bensound-dance", ofType: "mp3")
            }else{
                 audio = Bundle.main.path(forResource: "mediumMusic", ofType: "mp3")
            }
            do{
                //musicSelector = AVAudioPlayer()
                musicSelector = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find correct audio")
            }
        case 2:
            var audio = Bundle.main.path(forResource: "hardMusic", ofType: "mp3")
            if(Bool.random()){
                 audio = Bundle.main.path(forResource: "hardMusic", ofType: "mp3")
            }else{
                 audio = Bundle.main.path(forResource: "jermai", ofType: "mp3")
            }
            do{
                //musicSelector = AVAudioPlayer()
                musicSelector = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find correct audio")
            }
        default:
            let audio = Bundle.main.path(forResource: "hardMusic", ofType: "mp3")
            do{
                //musicSelector = AVAudioPlayer()
                musicSelector = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
            }catch{
                print("Cant find correct audio")
            }
        }
        musicSelector.numberOfLoops = 0
        return musicSelector
    }
    //Set correct sound
    func setAudioCLockCorrect(){
        let audio = Bundle.main.path(forResource: "correct", ofType: "mp3")
        do{
            //audioPlayerCorrect = AVAudioPlayer()
            audioPlayerCorrect = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
        }catch{
            print("Cant find 'correct' audio")
        }
    }
    // set clock sound
    func setAudioClock(){
        let audio = Bundle.main.path(forResource: "clock", ofType: "mp3")
        do{
            //audioPlayer = AVAudioPlayer()
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio!))
        }catch{
            print("Cant find 'clock' audio")
        }
    }
    //Get user selected difficulty
    func getDifficultySetting(index: Int) -> String{
        return difficultyArray[index]
    }
    //Get total difficulty count
    func getDifArrayCount() -> Int{
        return difficultyArray.count
    }
    //Set user difficulty
    func setDifficult(set: Int){
        difficulty = set
    }
    //Get user difficulty
    func getDifficulty() -> Int{
        return difficulty
    }
    //get clock sound
    func getClockSound() -> AVAudioPlayer{
        audioPlayer.volume = 2.5
        return audioPlayer
    }
    //get correct sound
    func getCorrectSound() -> AVAudioPlayer{
        return audioPlayerCorrect
    }
    //get user streak
    func getStreak() -> Int{
        return streak
    }
    //add to streak
    func incStreak(){
        streak += 1
    }
    //reset streak
    func resetStreak(){
        streak = 0
    }
    
    func getQCount() -> Int{
        return questionCount
    }
    
    func incCount(num: Int){
        questionCount += num
    }
    
    func sendX() -> Bool{
        return checkX
    }
    
    func toggleX(boo: Bool){
        checkX = boo
    }
    
    func organize(){
        for x in 0..<leaderArray.count-1{
            if leaderScoreArray[x] < leaderScoreArray[x+1]{
                let y = leaderScoreArray[x+1]
                leaderScoreArray[x+1] = leaderScoreArray[x]
                leaderScoreArray[x] = y
                let z = leaderArray[x+1]
                leaderArray[x+1] = leaderArray[x]
                leaderArray[x] = z
            }
        }
        for x in 0..<leaderArrayEasy.count-1{
            if leaderScoreArrayEasy[x] < leaderScoreArrayEasy[x+1]{
                let y = leaderScoreArrayEasy[x+1]
                leaderScoreArrayEasy[x+1] = leaderScoreArrayEasy[x]
                leaderScoreArrayEasy[x] = y
                let z = leaderArrayEasy[x+1]
                leaderArrayEasy[x+1] = leaderArrayEasy[x]
                leaderArrayEasy[x] = z
            }
        }
        for x in 0..<leaderArrayMedium.count-1{
            if leaderScoreArrayMedium[x] < leaderScoreArrayMedium[x+1]{
                let y = leaderScoreArrayMedium[x+1]
                leaderScoreArrayMedium[x+1] = leaderScoreArrayMedium[x]
                leaderScoreArrayMedium[x] = y
                let z = leaderArrayMedium[x+1]
                leaderArrayMedium[x+1] = leaderArrayMedium[x]
                leaderArrayMedium[x] = z
            }
        }
    }
    
    func toggleDecision(){
        decisionTwoAnswer = Bool.random()
    }
    
    func createImageArray() -> [UIImage]{
        var imageArray: [UIImage] = []
        for x in 1...48{
            let imageIn = "\(x).jpg"
            let theImage = UIImage(named: imageIn)!
            imageArray.append(theImage)
        }
        return imageArray
    }
    
    func createCoolImageArray() -> [UIImage]{
        var imageArray: [UIImage] = []
        for x in 0...179{
            let imageIn = "\(x)spin.jpg"
            let theImage = UIImage(named: imageIn)!
            imageArray.append(theImage)
        }
        return imageArray
    }
    
    func sendImages() -> [UIImage]{
        return images
    }
    
    func sendCoolImages() -> [UIImage] {
        return coolimage
    }
    
    func resetScore(){
        userScore = 0
    }
    
    func decideQuestion(decide: Bool) -> (String, Double){
        if decide{
            return addQuestionThree()
        }else{
            return addQuestionTwo()
        }
    }
    
    func decideEasy(decide: Bool) -> (String, Double){
        if decide{
            return addQuestion()
        }else{
            return addQuestionTwo()
        }
    }
    
    func decideMedium(decide: Bool) -> (String, Double){
        if decide{
            return addQuestionThree()
        }else{
            return decideEasy(decide: decision())
        }
    }
    
    func decideQuestionTwo(decide: Bool) -> (String, Double){
        if decide{
            return addQuestionFour()
        }else{
            return addQuestion()
        }
    }
    
    
    func decision() -> Bool{
        return Bool.random()
    }
    
    func decisionTwo() -> Bool{
        return decisionTwoAnswer
    }
    
    
    func addQuestionFour() -> (String, Double){
        var x = Double(Int.random(in: 1...9))
        var y = Double(Int.random(in: 1...9))
        var z = Double(Int.random(in: 1...9))
        let s = getSymbol()
        var answerForm = doTheMath(a: x, b: y, c: z, sign: s)
        while(answerForm < 1.0 || answerForm > 200.0 || floor(answerForm) != answerForm){
            x = Double(Int.random(in: 1...9))
            y = Double(Int.random(in: 1...9))
            z = Double(Int.random(in: 1...9))
            answerForm = doTheMath(a: x, b: y, c: z, sign: s)
        }
        answerForm = round(answerForm*1000)/1000
        let separate = doMoreMathFour(a: x, b: y, c: z, sign: s)
        allQuestionsFromMatch[allQuestionsFromMatch.count] = (separate.0 + " = " + String(format: "%.1f", answerForm), separate.1)
        return (separate.0 + " = " + String(format: "%.1f", answerForm), separate.1)
    }
    
    func doMoreMathFour(a: Double, b: Double, c:Double, sign: String) -> (String, Double){
        var array = [a, b, c]
        let rand = array[Int.random(in: 0 ..< array.count)]
        switch rand {
        case a:
            return ("x(\(Int(b))\(sign)\(Int(c)))", rand)
        case b:
            return ("\(Int(a))(x\(sign)\(Int(c)))", rand)
        case c:
            return ("\(Int(a))(\(Int(b))\(sign)x)", rand)
        default:
            return ("", 0)
        }
    }
    
    func addQuestionThree() -> (String, Double){
        var x = Double(Int.random(in: 1...9))
        var y = Double(Int.random(in: 1...9))
        var z = Double(Int.random(in: 1...9))
        var s1 = getSymbol()
        var s2 = getSymbol()
        while(s1 == s2 && s1 == "/"){
            s1 = getSymbol()
            s2 = getSymbol()
        }
        var answerForm = doTheMathThree(a: x, b: y, c: z, d: s1, e: s2)
        while(answerForm < 1.0 || answerForm > 200.0 || floor(answerForm) != answerForm){
            x = Double(Int.random(in: 1...9))
            y = Double(Int.random(in: 1...9))
            z = Double(Int.random(in: 1...9))
            answerForm = doTheMathThree(a: x, b: y, c: z, d: s1, e: s2)
        }
        //The above is viewed as : x(y(+-/*)z)
        answerForm = round(answerForm*1000)/1000
        let questionForm = doMoreMathThree(a: x, b: y, c: z, d: s1, e: s2)
        allQuestionsFromMatch[allQuestionsFromMatch.count] = (questionForm, answerForm)
        return (questionForm, answerForm)
        
    }
    
    func doTheMathThree(a: Double, b: Double, c: Double, d: String, e: String) -> Double{
        let n = doTheMathTwo(a: b, b: c, z: e)
        
        switch d {
        case "+":
            return a + n
        case "-":
            return a - n
        case "*":
            let x = a * n
            return Double(String(format: "%.2f", x))!
        case "/":
            let x = a / n
            return Double(String(format: "%.2f", x))!
        default:
            return 0.0
        }
    }
    
    func doMoreMathThree(a: Double, b: Double, c: Double, d: String, e: String) -> String{
        return "\(Int(a))\(d)(\(Int(b))\(e)\(Int(c)))"
    }
    
    func addQuestionTwo() -> (String, Double){
        var x = Double(Int.random(in: 1...9))
        var y = Double(Int.random(in: 1...9))
        let s = getSymbol()
        var answerForm = doTheMathTwo(a: x, b: y, z: s)
        while(answerForm < 1.0 || answerForm > 175.0 || floor(answerForm) != answerForm){
            x = Double(Int.random(in: 1...9))
            y = Double(Int.random(in: 1...9))
            answerForm = doTheMathTwo(a: x, b: y, z: s)
        }
        answerForm = round(answerForm*1000)/1000
        let questionForm = doMoreMathTwo(a: x, b: y, c: s)
        allQuestionsFromMatch[allQuestionsFromMatch.count] = (questionForm, answerForm)
        return(questionForm, answerForm)
    }

    
    func doTheMathTwo(a: Double, b: Double, z: String) -> Double{
        switch z {
        case "+":
            return a + b
        case "-":
            return a - b
        case "*":
            let x = a * b
            return Double(String(format: "%.2f", x))!
        case "/":
            let x = a / b
            return Double(String(format: "%.2f", x))!
        default:
            return 0.0
        }
    }
    
    func doMoreMathTwo(a: Double, b: Double, c: String) -> String{
        return "(\(Int(a))\(c)\(Int(b)))"
    }
    
    func createPuzzleProblem() -> (String, Double){
        var x = Double(Int.random(in: 1...9))
        var y = Double(Int.random(in: 1...9))
        
        var s = getSymbol()
        while(s == "/"){
            s = getSymbol()
        }
        var answerForm = doThePuzzleMath(a: x, b: y, sign: s)
        answerForm = doThePuzzleMath(a: x, b: y, sign: s)
        //The above is viewed as : x(y(+-/*)z)
        answerForm = round(answerForm*1000)/1000
        let questionForm = doMorePuzzleMath(a: x, b: y, sign: s)
        
        return (questionForm, answerForm)
    }
    
    func doMorePuzzleMath(a: Double, b: Double, sign: String) -> String{
        return String(Int(a)) + sign + String(Int(b))
    }
    
    func doThePuzzleMath(a: Double, b: Double, sign: String) -> Double{
        switch sign {
        case "+":
            return a + b
        case "-":
            return a - b
        case "*":
            return a * b
        default:
            return 0
        }
    }
    
  
    // 2(2x3)
    func addQuestion() -> (String, Double){
        //
        var x = Double(Int.random(in: 1...9))
        var y = Double(Int.random(in: 1...9))
        var z = Double(Int.random(in: 1...9))
        let s = getSymbol()
        var answerForm = doTheMath(a: x, b: y, c: z, sign: s)
        while(answerForm < 1.0 || answerForm > 150.0 || floor(answerForm) != answerForm){
            x = Double(Int.random(in: 1...9))
            y = Double(Int.random(in: 1...9))
            z = Double(Int.random(in: 1...9))
            answerForm = doTheMath(a: x, b: y, c: z, sign: s)
        }
        //The above is viewed as : x(y(+-/*)z)
        answerForm = round(answerForm*1000)/1000
        let questionForm = doMoreMath(a: x, b: y, c: z, sign: s)
        allQuestionsFromMatch[allQuestionsFromMatch.count] = (questionForm, answerForm)
        return (questionForm, answerForm)
    }
    
    
    func doMoreMath(a: Double, b: Double, c:Double, sign: String) -> String{
        return "\(Int(a))(\(Int(b))" + sign + "\(Int(c)))"
    }
    
    func doTheMath(a: Double, b: Double, c: Double, sign: String) -> Double{
        switch sign {
        case "+":
            return a * (b + c)
        case "-":
            return a * (b - c)
        case "*":
            let x = (a * (b * c))
            return Double(String(format: "%.2f", x))!
        case "/":
            let x = a * (b / c)
            return Double(String(format: "%.2f", x))!
        default:
            return 0
        }
    }
    
    func toggleSkipBool(){
        skipBool = !skipBool
    }
    
    
    func addScore(number: Int){
        userScore+=number
    }
    
    func addQuestionArray(value: String){
        questionArray.append(value)
    }
    
    func addAnswerArray(value: Double){
        answerArray.append(value)
    }
    
    func addLeader(name: String, score: Int){
        var i = 0
        switch getDifficulty() {
        case 0:
            if leaderArrayEasy.contains(name){
                while i != leaderArrayEasy.count{
                    if name == leaderArrayEasy[i] && score > leaderScoreArrayEasy[i]{
                        leaderScoreArrayEasy[i] = score
                    }
                    i += 1
                }
            }else{
                leaderArrayEasy.append(name)
                leaderScoreArrayEasy.append(score)
            }
        case 1:
            if leaderArrayMedium.contains(name){
                while i != leaderArrayMedium.count{
                    if name == leaderArrayMedium[i] && score > leaderScoreArrayMedium[i]{
                        leaderScoreArrayMedium[i] = score
                    }
                    i += 1
                }
            }else{
                leaderArrayMedium.append(name)
                leaderScoreArrayMedium.append(score)
            }
            
            
        case 2:
            if leaderArray.contains(name){
                while i != leaderArray.count{
                    if name == leaderArray[i] && score > leaderScoreArray[i]{
                        leaderScoreArray[i] = score
                    }
                    i += 1
                }
            }else{
                leaderArray.append(name)
                leaderScoreArray.append(score)
            }
            
        default:
            print("Something went wrong")
        }
    }
    
    
    
    func toggleOverallSelector(){
        overallSelector = Bool.random()
    }
    
    func checkLeaderboard(name: String, score: Int) -> Bool{
        var leader = [leaderArrayEasy, leaderArrayMedium, leaderArray]
        var scores = [leaderScoreArrayEasy, leaderScoreArrayMedium, leaderScoreArray]
        
        for x in 0..<leader[getDifficulty()].count{
            if leader[getDifficulty()][x] == name && scores[getDifficulty()][x] == score{
                return true
            }
        }
        return false
    }
    
    func calcScore() -> Double{
        return Double(Double(userScore) / Double(questionArray.count-1))
    }
    
    func sendReward(index: Int) -> String{
        return availAwards[index]
    }
    
    func rewardDescrip(index: Int) -> String{
        return descriptions[index]
    }
    
    func addreward(index: Int){
        userRewards.append(sendReward(index: index))
    }
    
    func removeReward(reward: String){
        var temp = 0
        for i in 0..<userRewards.count{
            if userRewards[i] == reward{
                temp = i
                break;
            }
        }
        userRewards.remove(at: temp)
    }
    
    func sendUserReward(index: Int) -> String{
        return userRewards[index]
    }
    
    func addTime(add: Int){
        time += add
    }
    
    func incRound(){
        roundCount += 1
    }
    
    func timeToggle(){
        resumeTime = !resumeTime
    }
    
    func timeRunning() -> Bool{
        return resumeTime
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    func getRound() -> Int{
        return roundCount
    }
    
    func incTime(){
        time -= 1
    }
    
    
    func resetRewards(){
        userRewards = []
    }
    
    func resetRound(){
        roundCount = 1
    }
    
    func resetTime(){
        time = 60
    }
    
    func resetQuestions(){
        questionArray = []
        answerArray = []
    }
    
    func skipUsed(){
        questionArray.remove(at: questionArray.count-1)
        answerArray.remove(at: answerArray.count-1)
    }
    
    func fiftyToggle(){
        fiftyBool = !fiftyBool
    }

    
    func toggleSelector(){
        selector = Bool.random()
    }
    
    func getSymbol() -> String{
        return symbols[Int.random(in: 0..<symbols.count)]
    }
    
    func getOverallSelector() -> Bool{
        return overallSelector
    }
    
    func getLeader(index: Int) -> String{
        var boards = [leaderArrayEasy, leaderArrayMedium, leaderArray]
        organize()
        return boards[getDifficulty()][index]
    }
    
    func getFiftyBool() -> Bool{
        return fiftyBool
    }
    
    func getSelector() -> Bool{
        return selector
    }
    
    
    func getMusicStatus() -> Bool{
        return musicIsPlaying
    }
    
    func getColorArray() -> [(color1: UIColor, color2: UIColor)]{
        return colors
    }
    
    func getMainMusicStatus() -> Bool{
        return mainMusicPlaying
    }
    
    func getQuestionCount() -> Int{
        return questionArray.count
    }
    
    func getMulliganBool() -> Bool{
        return mulliganBool
    }
    
    func getLeaderArrayCount() -> Int{
        var boards = [leaderScoreArrayEasy, leaderScoreArrayMedium, leaderScoreArray]
        return boards[getDifficulty()].count
    }
    
    func getLeaderScore(index: Int) -> Int{
        var boards = [leaderScoreArrayEasy, leaderScoreArrayMedium, leaderScoreArray]
        organize()
        return boards[getDifficulty()][index]
    }
    
    func getQuestion(index: Int) -> String{
        return questionArray[index]
    }
    
    func getAnswer(index: Int) -> Double{
        return answerArray[index]
    }
    
    func getUserRewards() -> [String]{
        return userRewards
    }
    
    func toggleMulligan(){
        mulliganBool = !mulliganBool
    }
    
    func getSkipBool() -> Bool{
        return skipBool
    }
    
    
    
    func getScore() -> Int{
        return userScore
    }
    
    func getTime() -> Int{
        return time
    }
    
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

extension UIImage {
    
    func imageRotated(on degrees: CGFloat) -> UIImage {
        // Following code can only rotate images on 90, 180, 270.. degrees.
        let degrees = round(degrees / 90) * 90
        let sameOrientationType = Int(degrees) % 180 == 0
        let radians = CGFloat.pi * degrees / CGFloat(180)
        let newSize = sameOrientationType ? size : CGSize(width: size.height, height: size.width)
        
        UIGraphicsBeginImageContext(newSize)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return self
        }
        
        ctx.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        ctx.rotate(by: radians)
        ctx.scaleBy(x: 1, y: -1)
        let origin = CGPoint(x: -(size.width / 2), y: -(size.height / 2))
        let rect = CGRect(origin: origin, size: size)
        ctx.draw(cgImage, in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? self
    }
    
}

extension Array {
    mutating func rotate(positions: Int, size: Int? = nil) {
        guard positions < count && (size ?? 0) <= count else {
            print("invalid input1")
            return
        }
        reversed(start: 0, end: positions - 1)
        reversed(start: positions, end: (size ?? count) - 1)
        reversed(start: 0, end: (size ?? count) - 1)
    }
    mutating func reversed(start: Int, end: Int) {
        guard start >= 0 && end < count && start < end else {
            return
        }
        var start = start
        var end = end
        while start < end, start != end {
            self.swapAt(start, end)
            start += 1
            end -= 1
        }
    }
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
