//
//  ViewController.swift
//  SlotsGameNew
//
//  Created by Chris Shaughnessy on 11/28/14.
//  Copyright (c) 2014 Webified Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Layout properties
    let kMargin:CGFloat = 2.0
    let kThird:CGFloat = 1.0/3.0
    let kHalf:CGFloat = 1.0/2.0
    let kFifth:CGFloat = 1.0/5.0
    let kSixth:CGFloat = 1.0/6.0
    
    
    // Number of slots
    let kNumberOfSlotColumns = 5
    let kNumberOfSlotRows = 5
    
    // Slot array
    var slotsArray:[[Slot]] = []
    
    // Views
    var titleContainer: UIView!
    var slotsContainer: UIView!
    var creditsContainer: UIView!
    var betContainer: UIView!
    var spinContainer: UIView!
    
    // Credits labels
    var titleLabel: UILabel!
    var creditsCountLabel: UILabel!
    var creditsLabel: UILabel!
    var betCountLabel: UILabel!
    var betLabel: UILabel!
    var winningsCountLabel: UILabel!
    var winningsLabel: UILabel!
    
    // Bet Buttons, reset
    let buttonDiameter = 75
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    // Label Values
    var creditsCount = 0
    var betCount = 0
    var winningsCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupTitleContainer()
        setupCreditsContainer()
        setupBetContainer()
        setupSpinContainer()
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtonPressed (button: UIButton) {
        hardReset()
    }
    
    func betOneButtonPressed (button: UIButton) {
        if creditsCount <= 0 {
            showAlertWithText(header: "Uh oh", message: "You ran out of credits")
        }
        else {
            if betCount < 5 {
                creditsCount -= 1
                betCount += 1
            }
            else {
                showAlertWithText(message: "Max bet exceeded")
            }
        }
        
        updateLabelsText()
    }
    
    func betMaxButtonPressed (button: UIButton) {
        if creditsCount <= 0 {
            showAlertWithText(header: "Uh oh", message: "You ran out of credits")
        }
        else {
            if betCount < 5 {
                var creditsCountMax = 5 - betCount
                creditsCount -= creditsCountMax
                betCount += creditsCountMax
            }
            else {
                showAlertWithText(message: "Max bet exceeded")
            }
        }
        
        updateLabelsText()
    }
    
    func spinButtonPressed (button: UIButton) {
        removeSlotImageViews()
        slotsArray = Factory.createSlots()
        setupSlotsContainer(self.slotsContainer)
        
        var winningsMultiplier = SlotLogic.computeWinnings(slotsArray)
        winningsCount = winningsMultiplier * betCount
        creditsCount += winningsCount
        betCount = 0
        
        updateLabelsText()
        
    }
    
    func setupContainerViews() {
        self.titleContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMargin, y: view.bounds.origin.y, width: self.view.bounds.width - kMargin * 2, height: 80.0))
        self.view.addSubview(titleContainer)
        
        self.slotsContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMargin, y: view.bounds.origin.y + titleContainer.bounds.height, width: self.view.bounds.width - kMargin * 2, height: view.bounds.height * kHalf))
        self.view.addSubview(slotsContainer)
        
        self.creditsContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMargin, y: view.bounds.origin.y + slotsContainer.bounds.height + kMargin + titleContainer.bounds.height, width: self.view.bounds.width - kMargin * 2, height: view.bounds.height * kSixth - 30.0))
        self.view.addSubview(creditsContainer)
        
        self.betContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMargin, y: view.bounds.origin.y + slotsContainer.bounds.height + creditsContainer.bounds.height + (2 * kMargin) + titleContainer.bounds.height, width: self.view.bounds.width - kMargin * 2, height: view.bounds.height * kSixth - 30))
        self.view.addSubview(betContainer)
        
        self.spinContainer = UIView(frame: CGRect(x: view.bounds.origin.x + kMargin, y: view.bounds.origin.y + slotsContainer.bounds.height + creditsContainer.bounds.height + betContainer.bounds.height + (3 * kMargin) + titleContainer.bounds.height, width: self.view.bounds.width - kMargin * 2, height: view.bounds.height * kSixth - (20.0 + kMargin * 4)))
        self.view.addSubview(spinContainer)
        
    }
    
    func setupTitleContainer () {
        self.titleLabel = UILabel(frame: CGRect(x: titleContainer.bounds.origin.x + kMargin, y: titleContainer.bounds.origin.y + kMargin, width: titleContainer.bounds.width - kMargin * 2, height: titleContainer.bounds.height - kMargin * 2))
        self.titleLabel.center = CGPoint(x: titleContainer.bounds.width * kHalf, y: titleContainer.bounds.height * kHalf)
        self.titleLabel.text = "Slot Machine"
        self.titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        self.titleLabel.textColor = UIColor.darkGrayColor()
        self.titleLabel.textAlignment = NSTextAlignment.Center
        titleContainer.addSubview(titleLabel)
    }
    
    func setupSlotsContainer (containerView: UIView) {
        for var slotColumnNumber = 0; slotColumnNumber < kNumberOfSlotColumns; ++slotColumnNumber {
            for var slotRowNumber = 0; slotRowNumber < kNumberOfSlotRows; ++slotRowNumber {
                var slotInstance: Slot
                var slotInstanceImageView = UIImageView()
                
                if slotsArray.count != 0 {
                    let slotColumn = slotsArray[slotColumnNumber]
                    slotInstance = slotColumn[slotRowNumber]
                    slotInstanceImageView.image = slotInstance.image
                }
                else {
                    slotInstanceImageView.image = UIImage(named: "aceSpades")
                }
                slotInstanceImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(slotColumnNumber) * kFifth) + kMargin, y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotRowNumber) * kFifth) + kMargin, width: containerView.bounds.width * kFifth - kMargin * 2, height: containerView.bounds.height * kFifth - kMargin * 2)
                containerView.addSubview(slotInstanceImageView)
            }
        }
        
    }
    
    func setupCreditsContainer () {
//        func createLabel (labelProperty: UILabel, centerWidth: CGFloat, centerHeight: CGFloat, labelText: String) {
//            labelProperty = UILabel(frame: CGRectMake(creditsContainer.bounds.origin.x, creditsContainer.bounds.origin.y, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
//            labelProperty.center = CGPoint(x: creditsContainer.bounds.width * (kFifth * centerHeight), y: creditsContainer.bounds.height * (kThird * centerHeight))
//            labelProperty.text = labelText
//            labelProperty.textColor = UIColor.whiteColor()
//            labelProperty.textAlignment = NSTextAlignment.Center
//            labelProperty.backgroundColor = UIColor.darkGrayColor()
//            creditsContainer.addSubview(labelProperty)
//        }
        
        
        self.creditsCountLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.creditsCountLabel.center = CGPoint(x: creditsContainer.bounds.width * kFifth, y: creditsContainer.bounds.height * kThird)
        self.creditsCountLabel.text = "000000"
        self.creditsCountLabel.textColor = UIColor.whiteColor()
        self.creditsCountLabel.textAlignment = NSTextAlignment.Center
        self.creditsCountLabel.backgroundColor = UIColor.darkGrayColor()
        creditsContainer.addSubview(creditsCountLabel)
        
        self.creditsLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.creditsLabel.center = CGPoint(x: creditsContainer.bounds.width * kFifth, y: creditsContainer.bounds.height * (kThird + kThird))
        self.creditsLabel.text = "Credits"
        self.creditsLabel.textColor = UIColor.darkGrayColor()
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        creditsContainer.addSubview(creditsLabel)
        
        self.betCountLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.betCountLabel.center = CGPoint(x: creditsContainer.bounds.width * (kHalf), y: creditsContainer.bounds.height * kThird)
        self.betCountLabel.text = "000000"
        self.betCountLabel.textColor = UIColor.whiteColor()
        self.betCountLabel.textAlignment = NSTextAlignment.Center
        self.betCountLabel.backgroundColor = UIColor.darkGrayColor()
        creditsContainer.addSubview(betCountLabel)

        self.betLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.betLabel.center = CGPoint(x: creditsContainer.bounds.width * (kHalf), y: creditsContainer.bounds.height * (kThird * 2))
        self.betLabel.text = "Bet"
        self.betLabel.textColor = UIColor.darkGrayColor()
        self.betLabel.textAlignment = NSTextAlignment.Center
        creditsContainer.addSubview(betLabel)
        
        self.winningsCountLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.winningsCountLabel.center = CGPoint(x: creditsContainer.bounds.width * (kFifth * 4), y: creditsContainer.bounds.height * kThird)
        self.winningsCountLabel.text = "000000"
        self.winningsCountLabel.textColor = UIColor.whiteColor()
        self.winningsCountLabel.backgroundColor = UIColor.darkGrayColor()
        self.winningsCountLabel.textAlignment = NSTextAlignment.Center
        creditsContainer.addSubview(winningsCountLabel)
        
        self.winningsLabel = UILabel(frame: CGRectMake(0, 0, creditsContainer.bounds.width * kFifth, creditsContainer.bounds.height * kFifth))
        self.winningsLabel.center = CGPoint(x: creditsContainer.bounds.width * (kFifth * 4), y: creditsContainer.bounds.height * (kThird * 2))
        self.winningsLabel.text = "Winnings"
        self.winningsLabel.textColor = UIColor.darkGrayColor()
        self.winningsLabel.textAlignment = NSTextAlignment.Center
        creditsContainer.addSubview(winningsLabel)
    }
    
    func setupBetContainer () {
        self.resetButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonDiameter, height: buttonDiameter))
        self.resetButton.center = CGPoint(x: betContainer.bounds.width * (kFifth * 1), y: betContainer.bounds.height * kHalf)
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.layer.masksToBounds = true
        self.resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
        self.resetButton.layer.borderWidth = 2
        self.resetButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.resetButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.resetButton.backgroundColor = UIColor.whiteColor()
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        betContainer.addSubview(resetButton)
        
        self.betOneButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonDiameter, height: buttonDiameter))
        self.betOneButton.center = CGPoint(x: betContainer.bounds.width * kHalf, y: betContainer.bounds.height * kHalf)
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor(red:0.16, green:0.51, blue:0.74, alpha:1), forState: UIControlState.Normal)
        self.betOneButton.layer.borderColor = UIColor(red:0.16, green:0.51, blue:0.74, alpha:1).CGColor
        self.betOneButton.layer.masksToBounds = true
        self.betOneButton.layer.borderWidth = 2
        self.betOneButton.layer.cornerRadius = 0.5 * betOneButton.bounds.size.width
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        betContainer.addSubview(betOneButton)
        
        self.betMaxButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonDiameter, height: buttonDiameter))
        self.betMaxButton.center = CGPoint(x: betContainer.bounds.width * (kFifth * 4), y: betContainer.bounds.height * kHalf)
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor(red:0.76, green:0.24, blue:0.18, alpha:1), forState: UIControlState.Normal)
        self.betMaxButton.layer.borderColor = UIColor(red:0.76, green:0.24, blue:0.18, alpha:1).CGColor
        self.betMaxButton.layer.masksToBounds = true
        self.betMaxButton.layer.borderWidth = 2
        self.betMaxButton.layer.cornerRadius = 0.5 * betMaxButton.bounds.size.width
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        betContainer.addSubview(betMaxButton)
        
    }
    
    func setupSpinContainer () {
        self.spinButton = UIButton(frame: CGRect(x: spinContainer.frame.origin.x, y: spinContainer.frame.origin.y + 20.0, width: spinContainer.bounds.width, height: spinContainer.bounds.height - 20.0))
        self.spinButton.center = CGPoint(x: spinContainer.bounds.width * kHalf, y: spinContainer.bounds.height * kHalf)
        self.spinButton.setTitle("SPIN!", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 60)
        self.spinButton.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.6, alpha:1)
        self.spinButton.layer.borderColor = UIColor(red:0.12, green:0.63, blue:0.52, alpha:1).CGColor
        self.spinButton.layer.borderWidth = 2
        self.spinButton.layer.masksToBounds = true
        self.spinButton.layer.cornerRadius = 10
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        spinContainer.addSubview(spinButton)
    }
    
    //Helper Functions
    
    func removeSlotImageViews() {
        if self.slotsContainer != nil {
            let container: UIView? = self.slotsContainer
            let subViews: Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset () {
        removeSlotImageViews()
        slotsArray.removeAll(keepCapacity: true)
        self.setupSlotsContainer(self.slotsContainer)
        creditsCount = 50
        betCount = 0
        winningsCount = 0
        
        updateLabelsText()
    }
    
    func updateLabelsText () {
        self.creditsCountLabel.text = "\(creditsCount)"
        self.betCountLabel.text = "\(betCount)"
        self.winningsCountLabel.text = "\(winningsCount)"
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

