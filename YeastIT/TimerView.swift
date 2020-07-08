//
//  TimerView.swift
//  YeastIT
//
//  Created by utente on 07/07/2020.
//  Copyright © 2020 vittoria. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    let hourInSecond = 172800
    @State var progressValuePercentage: Double = 0.00
    @State var timeRemaining = 10.00
    @State var angle = 0
    @Binding var localName : String
    @State var hoursD = 0.00
    @State var hoursI = 0
    @State var min = 0.00
    @State var minI = 0
    @State var secI = 0
    @State var alert = false
    var imageName : String
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 500
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let timerCL = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack{
            
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                ZStack{
                    Image("RettangoloAvatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageDimension * 1.2 , height: imageDimension * 1.2 )
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: avatarImageDimension / 1.5, height: avatarImageDimension / 1.5)
                        .onReceive(timer){_ in
                            if self.timeRemaining > 0{
                                self.timeRemaining -= 1
                                self.progressValuePercentage = ((self.timeRemaining * 100) / Double(self.hourInSecond)) / 100
                                
                                self.hoursD = self.timeRemaining / 3600.00
                                self.hoursI = Int(self.hoursD)
                                self.min = self.hoursD - Double(self.hoursI)
                                
                                self.minI = Int(self.min * 60)
                                self.secI = Int(self.min * 6000)
                                
                            }else{
                                
                                //notifica watch
                                
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (status, _) in
                                    
                                    
                                    if status{
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = "Notification from Yeast It"
                                        content.body = "Finito!!"
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                        
                                        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: trigger)
                                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                        
                                        return
                                    }
                                    
                                    self.alert.toggle()
                                }
                                
                            }
                    }
                    .alert(isPresented: $alert){
                        return Alert(title: Text("Please Enable Notification Access In Settings Pannel !!!"))
                    }
                }
                
                
                
                
                Text("\(localName)")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .frame(width : 500)
                Spacer()
                    .frame(width:1)
                ZStack{
                    Rectangle().foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                        .overlay(
                            
                            HStack{
                                Spacer()
                                    .frame(width: 35.0)
                                Image("hourglass")
                                    .resizable()
                                    .frame(width: 70, height: 115)
                                    
                                    .rotationEffect(.degrees(Double(self.angle)))
                                    .animation(.spring())
                                
                                
                                
                                Spacer()
                                    .frame(width: 80.0)
                                
                                ProgressBar(progress: self.$progressValuePercentage, hours: self.$hoursI, minutes : self.$minI, seconds : self.$secI)
                                    .frame(width: 150.0, height: 150.0)
                                    
                                    .onReceive(timerCL){ _ in
                                        self.angle += 10
                                }
                            }
                            
                            
                    )
                    
                }
                
                HStack{
                    
                    Button(action: resetValue){
                        Rectangle()
                            .frame(width: 180)
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0))
                            .overlay(
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color.orange)
                                        .opacity(0.7)
                                        .frame(width: 150, height: 50, alignment: .center )
                                        .cornerRadius(15)
                                    
                                    Text("Reset")
                                        .foregroundColor(Color.black)
                                        .font(.title)
                                }
                        )
                    }
                    
                    
                    
                    Button(action: {}){
                        Rectangle()
                            .frame(width: 180)
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0))
                            .overlay(
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color.orange)
                                        .opacity(0.7)
                                        .frame(width: 150, height: 50, alignment: .center )
                                        .cornerRadius(15)
                                    
                                    Text("Check")
                                        .foregroundColor(Color.black)
                                        .font(.title)
                                }
                        )
                    }
                    
                    
                    
                }
                Spacer()
                    .padding(.bottom, 12.0)
                    .frame(height: 51.0)
                
            }
            .frame(width: 13.0)
        }.navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
    }
    func resetValue(){
        progressValuePercentage = 0.0
        angle = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(localName: .constant("nome"), imageName: "femaleAvatar1")
    }
}


struct ProgressBar: View {
    @Binding var progress: Double
    @Binding var hours : Int
    @Binding var minutes : Int
    @Binding var seconds : Int
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            VStack{
                Text("Mancano")
                    .bold()
                HStack{
                    Text("\(hours)")
                    Text(":")
                    Text("\(minutes)")
                    Text(":")
                    Text("\(seconds)")
                }
                
                
            }
            
            
        }
        
    }
}


