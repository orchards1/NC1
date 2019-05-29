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
    let gamebackgroundmusic = SKAudioNode(fileNamed: "RainBGM.mp3")
    let firemusic = SKAudioNode(fileNamed: "fire.mp3")
    let Umbrella = SKSpriteNode(imageNamed: "Umbrella")
    let Indicator = SKSpriteNode(imageNamed: "Indicator")
    let fire = SKEmitterNode(fileNamed: "Fire")
    let stone = SKSpriteNode(imageNamed: "Stone")
    let retry = SKSpriteNode(imageNamed: "Retry")
    let motionManager: CMMotionManager = CMMotionManager()
    var gameTimer: Timer?
    private let timeleft = SKLabelNode(text: "Timeleft :")
    private var timeremainingcounter = 60 {
        didSet {
            self.timeleft.text = "Timeleft : \(self.timeremainingcounter)"
        }
    }
    private let label = SKLabelNode(text: "0")
    private var counter = 0 {
        didSet {
            self.label.text = String(self.counter)
        }
    }
    var destX:CGFloat  = 0.0
    var shiftX:CGFloat  =  0.0
    
    
    override func didMove(to view: SKView) {
        
        
        self.timeleft.fontSize = 40
        self.timeleft.position = CGPoint(x:-200 , y:450)
        self.addChild(timeleft)
        
        
        self.label.fontSize = 150
        self.label.position = CGPoint(x:0 , y:200)
        self.addChild(label)
        
        motionManager.startAccelerometerUpdates()
        
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
        
        SpawnIndicator()
        SpawnStone()
        SpawnUmbrella()
        SpawnFire()
        SpawnRetry()
        addChild(gamebackgroundmusic)
        addChild(firemusic)
        firemusic.run(SKAction.stop())
        fireOff()
        
        
        
        
        
    }
    
    func fireOff()
    {
        UIView.animate(withDuration: 10.0, animations: {
        
            self.fire?.particleAlpha = 0
            self.fire?.particleLifetime = 0
            self.Indicator.alpha = 1
        })
        firemusic.run(SKAction.stop())
        
    }
    func NoFire()
    {
        self.fire?.isHidden = true
    }
    
    @objc func timer()
    {
        let wait = SKAction.wait(forDuration: 0)
        
            let incrementCounter = SKAction.run { [weak self] in
            self?.timeremainingcounter -= 1
               
            }
        let sequence = SKAction.sequence([wait, incrementCounter])
       
        if(timeremainingcounter>0)
        {
            self.run(sequence)
        }
        
        if(Umbrella.position.x <= 60 && Umbrella.position.x >= -60)
        {
            FireOn()
            
        }
            
        else
        {
            fireOff()
        }
    }
    
    func FireOn()
    {
        
        UIView.animate(withDuration: 10.0, animations: { self.fire?.alpha = 0.9
            self.fire?.particleAlpha = 1
            self.fire?.particleLifetime = 2.5
            self.Indicator.alpha  = 0
        }, completion:{
            (value: Bool) in
            self.fire?.isHidden = false
        })
        firemusic.run(SKAction.play())
    }
    func touchDown(atPoint pos : CGPoint) {

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == retry {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene = GameScene(fileNamed: "GameScene")!
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene, transition: transition)
                    
                }
            }
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
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 0.02
            motionManager.startAccelerometerUpdates(to: .main) {
                (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                
                let currentX = self.Umbrella.position.x
                self.destX = currentX + CGFloat(data.acceleration.x * 500)
            }
        }
        
        if(destX > 350 )
        {
            destX = 320
        }
            
        else if(destX < -350)
        {
            destX = -320
        }
        
            let action = SKAction.moveTo(x: destX, duration: 0.5)
            Umbrella.run(action)
        
        if(Umbrella.position.x <= 60 && Umbrella.position.x >= -60)
        {
            FireOn()
            let wait = SKAction.wait(forDuration: 0)
            
            if(timeremainingcounter == 0 ){
            }
            else{
            let incrementCounter = SKAction.run { [weak self] in
                self?.counter += 1
            }
            
            let sequence = SKAction.sequence([wait, incrementCounter])
            
            self.run(sequence)
            }
        }
        else
        {
         fireOff()
            let wait = SKAction.wait(forDuration: 0)
            
            if(timeremainingcounter == 0 || self.counter < 1 ){
                if(counter < 0)
                {self.counter = 0}
            }
                
            else{
                let incrementCounter = SKAction.run { [weak self] in
                    self?.counter = 0
                }
               
                
                let sequence = SKAction.sequence([wait,  incrementCounter])
                
                self.run(sequence)
            }
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
    func SpawnIndicator()
    {
        Indicator.size = CGSize(width: 40, height: 144)
        Indicator.alpha = 0.7
        Indicator.setScale(0.8)
        Indicator.zPosition = 2
        Indicator.position = CGPoint(x:0 , y:-30)
        self.addChild(Indicator)
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
    
    func SpawnRetry(){
        
        retry.alpha = 0.8
        retry.setScale(1.5)
        retry.zPosition = 1
        retry.position = CGPoint(x:0 , y:80)
        self.addChild(retry)
    }
    
}
