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
    
    var body: some View {
        ZStack{
            Image("bcq")
            
            NavigationLink(destination: TimerView(localName: checkAvatarName, imageName: checkImageName)){
                ZStack{
                    Rectangle()
                        .frame(width: 50, height: 50)
                }
                
            }
        }.navigationBarTitle("")
        .navigationBarHidden(true)

        
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(checkAvatarName: "gino", checkImageName: "femaleAvatar1")
    }
}
