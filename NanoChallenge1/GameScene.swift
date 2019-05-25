//
//  GameScene.swift
//  NanoChallenge1
//
//  Created by Michael Louis on 18/05/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import Foundation

class GameScene: SKScene ,SKPhysicsContactDelegate {
    let Umbrella = SKSpriteNode(imageNamed: "Umbrella")
    let Text = SKSpriteNode(imageNamed: "Text")
    let fire = SKEmitterNode(fileNamed: "Fire")
    let stone = SKSpriteNode(imageNamed: "Stone")
    let motionManager: CMMotionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    
    override func didMove(to view: SKView) {
        
        motionManager.startAccelerometerUpdates()
        
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let gamebackgroundmusic = SKAudioNode(fileNamed: "RainBGM.mp3")
        SpawnText()
        SpawnStone()
        SpawnUmbrella()
        SpawnFire()
        addChild(gamebackgroundmusic)
        fireOff()
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: .main) {
                (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                
                let currentX = self.Umbrella.position.x
                self.destX = currentX + CGFloat(data.acceleration.x * 500)
            }
        }
        
    }
    
    func fireOff()
    {
        UIView.animate(withDuration: 10.0, animations: {
        
            self.fire?.particleAlpha = 0
            self.fire?.particleLifetime = 0
            
        })
    }
    func NoFire()
    {
        self.fire?.isHidden = true
    }
    
    func FireOn()
    {
        
        UIView.animate(withDuration: 10.0, animations: { self.fire?.alpha = 0.5
            self.fire?.particleAlpha = 1
            self.fire?.particleLifetime = 2.5
        }, completion:{
            (value: Bool) in
            self.fire?.isHidden = false
        })
    }
    func touchDown(atPoint pos : CGPoint) {

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches )
        {
            let location = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches )
        {
              let location = touch.location(in: self)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        for touch in (touches )
        {
              let location = touch.location(in: self)
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        for touch in (touches )
        {
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if(destX > 350 )
        {
            destX = 320
        }
            
        else if(destX < -350)
        {
            destX = -320
        }
        
            let action = SKAction.moveTo(x: destX, duration: 1)
            Umbrella.run(action)
        
        if(Umbrella.position.x <= 60 && Umbrella.position.x >= -60)
        {
            FireOn()
        }
            
        else
        {
            fireOff()
        }
    }
    
    func SpawnUmbrella(){
        
        Umbrella.size = CGSize(width: 100, height: 100)
        Umbrella.alpha = 0.8
        Umbrella.setScale(1.2)
        Umbrella.zPosition = 2
        Umbrella.position = CGPoint(x:130 , y:-550)
        self.addChild(Umbrella)
    }
    func SpawnText()
    {
        Text.size = CGSize(width: 255, height: 77)
        Text.alpha = 0.8
        Text.setScale(1.5)
        Text.zPosition = 2
        Text.position = CGPoint(x:0 , y:200)
        self.addChild(Text)
    }
    func SpawnStone(){

        stone.size = CGSize(width: 133, height: 64)
        stone.alpha = 1
        stone.setScale(0.7)
        stone.zPosition = 0
        stone.position = CGPoint(x: 0 , y:-630)
        self.addChild(stone)

    }
    func SpawnFire(){
        
        fire!.alpha = 0.5
        fire!.setScale(1)
        fire!.zPosition = 1
        fire!.position = CGPoint(x:0 , y:-620)
        self.addChild(fire!)
    }

    
}
