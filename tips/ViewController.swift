//
//  ViewController.swift
//  tips
//
//  Created by Bryton Shang on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var defaultTipIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaultTipIndex = defaults.integerForKey("tipIndex")
        var lastBill = defaults.doubleForKey("lastBill")
        var lastBillDate = defaults.doubleForKey("lastBillEpochTime")
        
        tipControl.selectedSegmentIndex = defaultTipIndex
        
        var currentEpochTime = NSDate().timeIntervalSince1970 - 10 * 60 // Ten minutes ago
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        if(lastBillDate > currentEpochTime) {
            billField.text = String(lastBill)
        } else {
            billField.text = ""
        }
        
        updateTipPercentages()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.becomeFirstResponder()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipIndex = defaults.integerForKey("tipIndex")
        
        if(tipIndex != defaultTipIndex) {
            defaultTipIndex = tipIndex
            tipControl.selectedSegmentIndex = defaultTipIndex
            
            updateTipPercentages()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTipPercentages() {
        print("Updating Tip Percentages")
        
        var tipPercentages  = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text! as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onBillChanged(sender: AnyObject) {
        var billAmount = (billField.text! as NSString).doubleValue
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: "lastBill")
        defaults.setDouble(NSDate().timeIntervalSince1970, forKey: "lastBillEpochTime")
        defaults.synchronize()
        
        updateTipPercentages()
    }
    
    @IBAction func OnTipControlChanged(sender: AnyObject) {
        updateTipPercentages()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

