//
//  SettingsViewController.swift
//  tips
//
//  Created by Bryton Shang on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var defaults = NSUserDefaults.standardUserDefaults()
        settingsTipControl.selectedSegmentIndex = defaults.integerForKey("tipIndex")
    }
    
    @IBAction func settingsTipChanged(sender: AnyObject) {
        var tipIndex = settingsTipControl.selectedSegmentIndex
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
}