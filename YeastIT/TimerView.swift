//
//  TimerView.swift
//  YeastIT
//
//  Created by utente on 07/07/2020.
//  Copyright © 2020 vittoria. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var progressValue: Float = 0.0
    @State var angle = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let timerCL = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
       ZStack{
           Image("bg")
               .resizable()
               .frame(height: 1000)
               .edgesIgnoringSafeArea(.all)
           
           Text("Antonello")
               .bold()
               .foregroundColor(Color.white)
               
           
               
           
           VStack{
               
               ZStack{
                   
                   Circle()
                       .foregroundColor(Color.white)
                       .frame(width: 344.0)
                       .cornerRadius(25)
                       .padding(.top, 98.0)
                   Image("hourglass")
                       .resizable()
                       .frame(width: 250.0, height: 250)
                       .padding(.top, 98)
                       .cornerRadius(3)
                       .onReceive(timer){ _ in
                           self.progressValue += 0.01
                   }
                   
               }.frame(height: 500)
               
               
               
               ZStack{
                   Rectangle().foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                       .overlay(
                           HStack{
                               Spacer()
                                   .padding()
                               Image("hourglass")
                                   .resizable()
                                   .frame(width: 70, height: 115)
                                   .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                   .rotationEffect(.degrees(Double(self.angle)))
                                   .animation(.spring())
                               
                               Spacer()
                                   .frame(width: 30
                               )
                               
                               ProgressBar(progress: self.$progressValue)
                                   .frame(width: 150.0, height: 150.0)
                                   .padding(.leading, 39.0)
                                   .onReceive(timerCL){ _ in
                                       self.angle += 10
                               }
                           }
                           
                           
                   )
                   
               }
               
               HStack{
                   
                   Button(action: resetValue){
                       Rectangle()
                           .frame(width: 200)
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
                           .frame(width: 200)
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
       }
    }
    func resetValue(){
        progressValue = 0.0
        angle = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}


struct ProgressBar: View {
    @Binding var progress: Float
    
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
                Text("23 ore")
            }
            
            
        }
        
    }
}


