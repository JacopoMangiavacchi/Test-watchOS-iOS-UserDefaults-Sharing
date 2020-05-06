//
//  ContentView.swift
//  TestUserDefaults
//
//  Created by Jacopo Mangiavacchi on 5/5/20.
//  Copyright © 2020 Jacopo Mangiavacchi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var state = 0
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            Stepper(value: self.$state, in: 0...10, label: { Text("State: \(self.state)")})
            HStack {
                Button(action: {
                    self.defaults.set(self.state, forKey: "state")
                }) {
                    Text("Write")
                }
                Button(action: {
                    self.state = self.defaults.integer(forKey: "state")
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
