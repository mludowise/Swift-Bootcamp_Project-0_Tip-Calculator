//
//  ViewController.swift
//  tips
//
//  Created by Mel Ludowise on 10/5/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // These should match the percentage options in the UI
    private let tipPercentages = [0.18, 0.20, 0.25]
    
    // To help us format for all currencies internationally
    private var currencyFormatter = NSNumberFormatter()

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize currencyFormatter to be in the format of $0.00
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        // Initialize tip & total to 0
        setDisplayValues(0, total: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        // Get the values
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = NSString(string: billField.text).doubleValue
        
        // Do the math
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
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

