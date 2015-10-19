//
//  JohnCena.swift
//  JohnCenaIntro
//
//  Created by Brian Wang on 10/15/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import UIKit

class JohnCena: CCNode {
    var fireParticles:CCParticleSystem!
    var sparkParticles:CCParticleSystem!
    func didLoadFromCCB() {
        //position in percentages from spritebuilder
        self.position = ccp(0.5, 1.25)
        self.scheduleOnce(Selector("dropDown"), delay: 1.4)
    }
    
    func dropDown() {
        self.scheduleOnce(Selector("shake"), delay: 0.1)
        //create action that makes john cena move to the middle of the screen (position is in percentages from spritebuilder)
        let drop = CCActionMoveTo.init(duration: 0.1, position: ccp(0.5,0.5))
        self.runAction(drop)
    }
    
    func shake() {
        //run the shake sequence from spritebuilder
        self.animationManager.runAnimationsForSequenceNamed("Shake")
    }
}
