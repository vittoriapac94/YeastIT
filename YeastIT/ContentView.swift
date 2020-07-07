//
//  ContentView.swift
//  Yeast IT
//
//  Created by utente on 06/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let textDimension : CGFloat = 40
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 499
    @State var quantity: String = ""
    @State var avatarName: String = ""
    
    var body: some View {
        ZStack(alignment: .top){
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
                HStack(alignment: .center) {
                    Text("YEAST")
                        .font(.system(size: textDimension, weight: .bold))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .font(.body)
                    
                    Text("IT")
                        .font(.system(size: textDimension, weight: .light))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                    .padding(20)
                
                ZStack(alignment: .center){
                    Image("RettangoloAvatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageDimension * 1.2 , height: imageDimension )
                        
                        
                    Image("img_avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: avatarImageDimension / 3, height: avatarImageDimension / 3)
                }.aspectRatio(contentMode: .fit)
                
                VStack(alignment: .center){
                    
                    TextField("Nome Avatar...",text: $avatarName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: textDimension / 2, weight: .light))
                        .frame(width: avatarImageDimension / 2)

                        .padding()
                    
                    
                    TextField("Quantità...",text: $quantity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: avatarImageDimension / 2)
                        .font(.system(size: textDimension / 2, weight: .light))
                        .cornerRadius(10)
                        .padding()
                    
                    
                    
                    Button(action: {
                        print("tapped")
                    }){
                        Text("Ciao")
                        .bold()
                        
                    }
                    
                }.padding(70)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//salve a tutti
