//
//  ContentView.swift
//  POC Notificações
//
//  Created by Marcus Vinicius Silva de Sousa on 31/08/22.
//

import SwiftUI
import NotificationCenter

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print ("Error: \(error)")
                
            } else {
                print ("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Essa é a nossa primeira notificação"
        content.subtitle = "Pedro Henrique é levado"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40){
            Button("Permissão") {
                
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Notificação") {
                
                NotificationManager.instance.scheduleNotification()
            }
            
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
