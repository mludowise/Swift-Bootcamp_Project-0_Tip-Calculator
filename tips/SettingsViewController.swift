//
//  SettingsViewController.swift
//  tips
//
//  Created by Melissa Ludowise on 12/13/15.
//  Copyright © 2015 Mel Ludowise. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var lowPercetageField: UITextField!
    @IBOutlet weak var mediumPercentageField: UITextField!
    @IBOutlet weak var highPercentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        lowPercetageField.text = "\(defaults.integerForKey(kLowValueKey))"
        mediumPercentageField.text = "\(defaults.integerForKey(kMediumValueKey))"
        highPercentageField.text = "\(defaults.integerForKey(kHighValueKey))"
    }
    
    override func viewWillDisappear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(NSString(string: lowPercetageField.text!).integerValue, forKey: kLowValueKey)
        defaults.setInteger(NSString(string: mediumPercentageField.text!).integerValue, forKey: kMediumValueKey)
        defaults.setInteger(NSString(string: highPercentageField.text!).integerValue, forKey: kHighValueKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
