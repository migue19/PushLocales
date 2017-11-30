//
//  ViewController.swift
//  EmoTest
//
//  Created by Miguel Mexicano on 30/11/17.
//  Copyright © 2017 Miguel Mexicano. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet weak var responseLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Asked for permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func action(_ sender: Any)
    {
        responseLbl.text = ""
        let answer1 = UNNotificationAction(identifier: "answer1", title: "365", options:  .foreground)
        let answer2 = UNNotificationAction(identifier: "answer2", title: "340", options:  .foreground)
        
        let category = UNNotificationCategory(identifier: "myCategory", actions: [answer1, answer2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        //Created notification
        let content = UNMutableNotificationContent()
        content.title = "How many days are there in one year"
        content.subtitle = "Do you know?"
        content.body = "Do you really know?"
        content.categoryIdentifier = "myCategory"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        //response.notification.request.content.userInfo
        responseLbl.text = response.notification.request.content.title
        print("response push: ",response.notification.request.content.title)
        print("action identifier: ",response.actionIdentifier)
        if response.actionIdentifier == "answer1"
        {
            print ("CORRECT")
        }
        else
        {
            print ("FALSE")
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        completionHandler( [.alert,.sound,.badge])
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
