//
//  MNSettingTableViewController.swift
//  MNParallaxList
//
//  Created by Motoki on 2015/02/12.
//  Copyright (c) 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class MNSettingTableViewController: UITableViewController {

    @IBOutlet weak var notificationSwitch: UISwitch!
    
    // セル表示順
    private let NofiticationCellSection        = 0
    private let LincesesInformationCellSection = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsに設定されたBool値をswitchへ代入
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let status: Bool = userDefaults.objectForKey("NotificationStatus") as Bool
        self.notificationSwitch.on = status
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    @IBAction func didChangeNotificationSwitch(sender: UISwitch) {
        
        let status: Bool = sender.on
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(status, forKey:"NotificationStatus")
        userDefaults.synchronize()
        
        if (sender.on == false) {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
    }
    

}
