//
//  TimerSettings.swift
//  provaLievito
//
//  Created by utente on 09/07/2020.
//  Copyright © 2020 utente. All rights reserved.
//

import Foundation

class TimerSettings : ObservableObject {

    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}
