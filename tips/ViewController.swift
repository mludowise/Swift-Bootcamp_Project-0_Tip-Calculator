//
//  ViewController.swift
//  tips
//
//  Created by Mel Ludowise on 10/5/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

let kLowValueKey = "percetageLow"
let kMediumValueKey = "percentageMedium"
let kHighValueKey = "percentageHigh"

let kBillAmountKey = "billAmount"
let kSelectedPercentKey = "selectedPercent"
let kTimeDismissedKey = "timeDismissed"

class ViewController: UIViewController {
    
    // Tip percentages
    private var lowPercentage = 0
    private var mediumPercentage = 0
    private var highPercentage = 0
    
    // To help us format for all currencies internationally
    private var currencyFormatter = NSNumberFormatter()

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize currencyFormatter to be in the format of $0.00
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        initializeView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initializeView()
    }
    
    func initializeView() {
        // Set up percentages
        lowPercentage = defaults.integerForKey(kLowValueKey)
        mediumPercentage = defaults.integerForKey(kMediumValueKey)
        highPercentage = defaults.integerForKey(kHighValueKey)
        
        tipControl.setTitle("\(lowPercentage)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(mediumPercentage)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(highPercentage)%", forSegmentAtIndex: 2)
        
        // Update bill amount
        let billAmount = defaults.objectForKey(kBillAmountKey)
        let timeDismissed = defaults.objectForKey(kTimeDismissedKey) as? NSDate
        print("Time since dismissed \(timeDismissed?.timeIntervalSinceNow)");
        
        if (billAmount != nil && (timeDismissed == nil || timeDismissed?.timeIntervalSinceNow < -10)) {
            billField.text = billAmount as? String
        }
        
        // Update amounts
        calculateTip()
    }
    
    override func viewWillDisappear(animated: Bool) {
        defaults.setObject(billField.text, forKey: kBillAmountKey)
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: kSelectedPercentKey)
        defaults.setObject(NSDate(), forKey: kTimeDismissedKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateTip()
    }

    func calculateTip() {
        // Get the values
        let tipPercentage = Double(tipControl.selectedSegmentIndex == 0 ? lowPercentage :
            tipControl.selectedSegmentIndex == 1 ? mediumPercentage :
            highPercentage) / 100
        
        let billAmount = NSString(string: billField.text!).doubleValue
        
        // Do the math
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        // Display the tip & total
        setDisplayValues(tip, total:total)
    }
    
    // Clears keyboard when touching anywhere on the screen
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // Formats the tip and total to the specified values
    func setDisplayValues(tip: Double, total: Double) {
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
    }
}

