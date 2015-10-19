import Foundation
import AVFoundation

class MainScene: CCNode {
    
    var audioPlayer = AVAudioPlayer()
    var johnCena:JohnCena!
    var johnCenaLabel:JohnCenaLabel!
    var backGroundColor:CCNode!
    
    
    func didLoadFromCCB() {
        setupAudioPlayer()
        playIntro()
        self.scheduleOnce(Selector("explode"), delay: 2)
    }
    
    func setupAudioPlayer() {
        var johnCenaURL = NSURL.init(fileURLWithPath: NSBundle.mainBundle().pathForResource("JohnCenaIntro", ofType: "mp3")!)
        
//        do {
//            try audioPlayer = AVAudioPlayer(contentsOfURL: johnCenaURL)
//        } catch {
//            print("audio didn't work")
//        }
        audioPlayer = AVAudioPlayer(contentsOfURL: johnCenaURL, error: nil)
        
    }
    
    func playIntro() {
        if (audioPlayer.prepareToPlay()) {
            audioPlayer.play()
        }
    }
    
    func explode() {
        var explosion = CCBReader.load("ExplosionParticle")
        explosion.position = johnCena.position
        johnCena.addChild(explosion)
        shakeScreen()
        backGroundColor.visible = true
        johnCena.fireParticles.visible = true
        johnCena.fireParticles.zOrder = -1
        johnCena.sparkParticles.visible = true
        johnCena.sparkParticles.zOrder = -2

        
    }
    
    func shakeScreen() {
        let shake = CCActionMoveBy.init(duration: 0.1, position: ccp(0, 5))
        let shakeBounce = CCActionEaseBounceInOut.init(action: shake)
        let shakeBounceBack = shakeBounce.reverse()
        let sequence = CCActionSequence.init(array:[shakeBounce, shakeBounceBack, shakeBounce, shakeBounceBack])
        self.runAction(sequence)
        
    }
}
