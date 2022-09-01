//
//  ContentView.swift
//  POC Notificações
//
//  Created by Marcus Vinicius Silva de Sousa on 31/08/22.
//

import SwiftUI
import UserNotifications
import CoreLocation

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
        
        // Time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        // Calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 16
//        dateComponents.minute = 17
//        // 1 is sunday, 2 is monday...
//        dateComponents.weekday = 5
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        //notifica quando entra ou sai da regiao, nesse exemplo usaremos entrar
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
       
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
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
            Button("Cancelar notificaçao"){
                NotificationManager.instance.cancelNotifications()
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
