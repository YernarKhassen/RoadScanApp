//
//  UIViewController.swift
//  RoadScan
//
//  Created by Dinmukhamed on 21.04.2023.
//

import UIKit

extension UIViewController {
    func callLocalNotification(descption: String, time: Double) {
        let notification = UNUserNotificationCenter.current()

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "RoadScan"
        content.body = descption
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        notification.add(request) { error in
            print(error?.localizedDescription as Any)
        }
    }
    
    func grantPermission() {
        let alert = UIAlertController(title: "Доступ к местоположению запрещен", message: "Пожалуйста перейдите в настройки своего телефона, чтобы предоставить разрешение на доступ к вашему местоположению", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
