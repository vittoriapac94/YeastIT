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
    @State var timeRemaining = 172800.00
    @State var hoursD = 0.00
    @State var hoursI = 0
    @State var min = 0.00
    @State var minI = 0
    @State var angle = 0
    @State var alert = false
    
    var localName : String
    var imageName : String
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 500
    @ObservedObject var setting = TimerSettings()
    var body: some View {
            ZStack{
                Image("bcq")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                
                
                VStack{
                    
                    ZStack{
                        Image("RettangoloAvatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageDimension  , height: imageDimension)
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: avatarImageDimension / 1.75, height: avatarImageDimension / 1.75)
                            .onReceive(setting.timer){_ in
                                if self.timeRemaining > 0{
                                    self.timeRemaining -= 1
                                    self.progressValuePercentage = ((self.timeRemaining * 100) / Double(self.hourInSecond)) / 100
                                    
                                    self.hoursD = self.timeRemaining / 3600.00
                                    self.hoursI = Int(self.hoursD)
                                    self.min = self.hoursD - Double(self.hoursI)
                                    
                                    self.minI = Int(self.min * 60)
                                    print(self.timeRemaining)
                                    
                                    
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
                    
                    
                    
                    
                    Text("\(localName.uppercased())")
                        .font(.largeTitle)
                        .foregroundColor(Color.black)
                        .frame(width : 500)
                    
                    Spacer()
                        .frame(width:1)
                    ZStack{
                        Rectangle().foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                            .overlay(
                                
                                HStack{
                                
                                    ProgressBar(progress: self.$progressValuePercentage, hours: self.$hoursI, minutes : self.$minI, seconds : self.$timeRemaining)
                                        .frame(width: 150, height: 150.0)
                                        .padding(.trailing)
                                    Spacer()
                                        .frame(width: 50.0)
                                    NavigationLink(destination: CheckView(checkAvatarName: localName, checkImageName: imageName)){
                                        ZStack{
                                            Rectangle()
                                                .frame(width:111, height: 90, alignment: .center)
                                                .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                                .cornerRadius(15)
                                                .overlay(
                                                    VStack{
                                                        Image(systemName: "camera")
                                                            .foregroundColor(Color.white)
                                                        Text("CHECK")
                                                            .bold()
                                                            .foregroundColor(Color.white)
                                                    }

                                            )
                                                .padding(.bottom, 30)

                                        }

                                    }
                                    
                                }
                                
                                
                        )
                        
                    }
                    Button(action: {}){
                        ZStack{
                            
                            Rectangle()
                                .frame(width: 299, height: 60, alignment: .center)
                                .foregroundColor(Color(red: 252 / 255, green: 139 / 255, blue: 86 / 255))
                                .cornerRadius(25)
                               
                            Text("RESET")
                                .foregroundColor(Color.white)
                            .bold()
                            
                        }.padding(.top, 50)
                    }
                    
                    
                }
                .frame(width: 13.0)
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        
        }
    }

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(localName: "nome", imageName: "femaleAvatar1")
    }
}


struct ProgressBar: View {
    @Binding var progress: Double
    @Binding var hours : Int
    @Binding var minutes : Int
    @Binding var seconds : Double
    @State var angle = 0
    let timerCL = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
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
                
                
                Image("hourglass")
                    .resizable()
                    .frame(width:53, height: 77)
                    .rotationEffect(.degrees(Double(self.angle)))
                    .animation(.spring())
                    .onReceive(timerCL){ _ in
                        self.angle += 10
                        
                }
                
            }
            Spacer()
                .frame(height: 13.0)
            HStack{
                
                Text("\(hours) H")
                    .font(.system(size: 15, weight: .bold))
                Text(":")
                Text("\(minutes) M")
                    .font(.system(size: 15, weight: .bold))
                Text(":")
                Text("\(Int(seconds) % 60) S")
                    .font(.system(size: 15, weight: .bold))
                
            }
        }
        
        
    }
}


