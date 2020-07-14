//
//  CheckView.swift
//  provaLievito
//
//  Created by utente on 09/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import SwiftUI

struct CheckView: View {
    var checkAvatarName : String
    var checkImageName : String
    var checkQuantity : String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("bcq")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
            }){
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.black)
                    Text("Back")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.black)
                    
                    Rectangle()
                        .opacity(0)
                    
                }.frame(width: 350, height: 25)
            }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
        
        
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(checkAvatarName: "gino", checkImageName: "maleAvatar1", checkQuantity: "0")
    }
}
