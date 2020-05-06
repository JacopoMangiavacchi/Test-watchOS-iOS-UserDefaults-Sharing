//
//  ContentView.swift
//  TestUserDefaults
//
//  Created by Jacopo Mangiavacchi on 5/5/20.
//  Copyright © 2020 Jacopo Mangiavacchi. All rights reserved.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var settings = Settings()
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            Stepper(value: self.$settings.state, in: 0...10, label: { Text("State: \(self.settings.state)")})
            HStack {
                Button(action: {
                    self.defaults.set(self.settings.state, forKey: "state")
                    self.settings.send()
                }) {
                    Text("Write")
                }
                Button(action: {
                    self.settings.state = self.defaults.integer(forKey: "state")
                }) {
                    Text("Read")
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
