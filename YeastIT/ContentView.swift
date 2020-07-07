//
//  ContentView.swift
//  YeastIt
//
//  Created by utente on 06/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let textDimension : CGFloat = 40
    let imageDimension : CGFloat = 228
    let avatarImageDimension : CGFloat = 499
    @State var quantity: String = "0"
    @State var avatarName: String = ""
    var body: some View {
        
        NavigationView{
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
                        
                        Text("IT")
                            .font(.system(size: textDimension, weight: .light))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 10)
                    
                    
                    ZStack(alignment: .center){
                        Image("RettangoloAvatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageDimension * 1.2 , height: imageDimension * 1.2 )
                        
                        
                        Image("img_avatar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: avatarImageDimension / 3, height: avatarImageDimension / 3)
                            
                    }.aspectRatio(contentMode: .fit)
                        .padding()
                    
                    VStack(alignment: .center){
                        VStack{
                            Text("Scegli un nome per il tuo avatar")
                            TextField("Nome Avatar...",text: $avatarName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: textDimension / 2, weight: .light))
                            .frame(width: avatarImageDimension / 2)
                        }.padding()
                        
                        
                        VStack{
                            Text("Quantità di Lievito (gr)")
                            TextField("Quantità...",text: $quantity)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: avatarImageDimension / 2)
                                .font(.system(size: textDimension / 2, weight: .light))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                                                  
                        }
                  
                        
                        
                        ZStack{
                            Image(uiImage: #imageLiteral(resourceName: "Casella Testo"))
                                .resizable()
                                .frame( height: 100)
                                .padding()
                            VStack(alignment: .center){
                                Text("Ti servono")
                                    .font(.system(size: 23, weight: .bold))
                                Text("\(quantity) gr di farina")
                                    .font(.system(size: 15, weight: .light))
                                Text("\((Int(quantity) ?? 0) / 2) gr di acqua")
                                    .font(.system(size: 15, weight: .light))
                            }
                        }
                        
                        NavigationLink(destination: TimerView()){
                            ZStack{
                                Rectangle()
                                    .frame(width: 299, height: 60, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(25)
                                Text("Inizia a lievitare")
                                    .foregroundColor(Color.orange)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


