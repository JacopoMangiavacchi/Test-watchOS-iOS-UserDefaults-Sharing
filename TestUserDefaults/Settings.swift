//
//  Settings.swift
//  TestUserDefaults
//
//  Created by Jacopo Mangiavacchi on 5/5/20.
//  Copyright © 2020 Jacopo Mangiavacchi. All rights reserved.
//

import Foundation
import WatchConnectivity

class Settings : NSObject, ObservableObject {
    @Published public var state: Int = 0
    var session: WCSession!
    
    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func send() {
        // send a message to the watch if it's reachable
        if (WCSession.default.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            let message = ["state": state]
            session.sendMessage(message, replyHandler: nil)
        }
        else {
            print("watch unreachable")
        }
    }

}

extension Settings : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        #if os(iOS)
        print("ios activationDidCompleteWith")
        #else
        print("watch activationDidCompleteWith")
        #endif
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("ios sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("ios sessionDidDeactivate")
    }
    #endif
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.state = message["state"] as! Int
        }
    }
}
