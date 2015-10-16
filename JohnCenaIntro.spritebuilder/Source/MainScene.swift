import Foundation
import AVFoundation

class MainScene: CCNode {
    
    var audioPlayer = AVAudioPlayer()
    var johnCena:JohnCena!
    
    func didLoadFromCCB() {
        playIntro()
        self.scheduleOnce(Selector("explode"), delay: 0.5)
    }
    
    func playIntro() {
        var johnCenaURL = NSURL.init(fileURLWithPath: NSBundle.mainBundle().pathForResource("JohnCenaIntro", ofType: "mp3")!)
        do {
            try audioPlayer = AVAudioPlayer.init(contentsOfURL: johnCenaURL)
        } catch {
            print("error")
        }
        
        if (audioPlayer.prepareToPlay()) {
            audioPlayer.play()
        }
    }
    
    func explode() {
        var explosion = CCBReader.load("ExplosionParticle")
        explosion.position = johnCena.position
        johnCena.addChild(explosion)
    }
}
