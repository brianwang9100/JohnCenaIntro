import Foundation
import AVFoundation

class MainScene: CCNode {
    
    var audioPlayer = AVAudioPlayer()
    var johnCena:JohnCena!
    var johnCenaLabel:JohnCenaLabel!
    var backGroundColor:CCNode!
    
    
    func didLoadFromCCB() {
        //setup audio players
        setupAudioPlayer()
        //play music
        playIntro()
        //since the explosion in intro music is delayed by 2 seconds, delay the explosion by 2 seconds as well. 
        //You can also use self.performSelector(...)
        //The Selector() is a reference to the name of the method to be called.
        self.scheduleOnce(Selector("explode"), delay: 2)
    }
    
    func setupAudioPlayer() {
        var johnCenaURL = NSURL.init(fileURLWithPath: NSBundle.mainBundle().pathForResource("JohnCenaIntro", ofType: "mp3")!)
        
        //new as of iOS9, no longer can put nil for error parameter
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: johnCenaURL)
        } catch {
            print("audio didn't work")
        }
        
    }
    
    func playIntro() {
        if (audioPlayer.prepareToPlay()) {
            audioPlayer.play()
        }
    }
    
    func explode() {
        //Load explosion
        var explosion = CCBReader.load("ExplosionParticle")
        
        //Set position to be in the middle of johnCena
        explosion.positionType = CCPositionTypeNormalized //set to percentage relativeness
        explosion.position = ccp(0.5,0.5)
        
        //add explosion to johnCena
        johnCena.addChild(explosion)
        
        //shake the screen simultaneously
        shakeScreen()
        
        backGroundColor.visible = true
        //apparently when you make the fireParticles visible, it screws with the zOrder, so we set the zOrder to be negative to be rendered first, behind johnCena
        johnCena.fireParticles.visible = true
        johnCena.fireParticles.zOrder = -1
        
        //same with the sparkParticles
        johnCena.sparkParticles.visible = true
        johnCena.sparkParticles.zOrder = -2

        
    }
    
    func shakeScreen() {
        //create a ccaction that represents the instructions of moving an object by 0,5 in 0.1 seconds
        let shake = CCActionMoveBy.init(duration: 0.1, position: ccp(0, 5))
        
        //modify the moveby action to have an animation attribute, bounce easeineaseout
        let shakeBounce = CCActionEaseBounceInOut.init(action: shake)
        
        //reverse the bounce modified action
        let shakeBounceBack = shakeBounce.reverse()
        
        //add actions to a sequence to be performed one after another
        let sequence = CCActionSequence.init(array:[shakeBounce, shakeBounceBack, shakeBounce, shakeBounceBack])
        
        //run sequence
        self.runAction(sequence)
        
    }
}
