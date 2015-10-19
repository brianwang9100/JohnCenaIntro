//
//  JohnCenaLabel.swift
//  JohnCenaIntro
//
//  Created by Brian Wang on 10/16/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import UIKit

class JohnCenaLabel: CCNode {
    func didLoadFromCCB() {
        self.position = ccp(0.5, -0.25)
        self.scheduleOnce(Selector("dropDown"), delay: 1.4)
    }
    
    func dropDown() {
        self.scheduleOnce(Selector("shake"), delay: 0.6)
        let drop = CCActionMoveTo.init(duration: 0.1, position: ccp(0.5,0.25))
        self.runAction(drop)
    }
    
    func shake() {
        self.animationManager.runAnimationsForSequenceNamed("Shake")
    }
}
