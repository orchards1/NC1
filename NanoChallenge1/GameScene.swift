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
    let Awan = SKSpriteNode(imageNamed: "Awan")
    let fire = SKEmitterNode(fileNamed: "Fire")
    let motionManager: CMMotionManager = CMMotionManager()
    
    var timer = Timer()
    
    func move(){
        var number = Int.random(in: 10 ... 50)
        let rightorleft = Bool.random()
        if(rightorleft == true)
        {
            moveright(asd: number)
        }
        else
        {
            moveleft(asd: number)
        }
    }
    
    var rainBGM : SKAudioNode!
    func moveleft(asd: Int)
    {
        let UmbrellaSpeed = frame.size.width * 5.0
        let distanceToMove = CGFloat(asd)
        let moveDuration = distanceToMove / UmbrellaSpeed
        let moveleft = SKAction.moveTo(x: Umbrella.position.x - distanceToMove, duration: TimeInterval(moveDuration))
        
        Umbrella.run(moveleft)
    }
    func moveright(asd: Int)
    {
        let UmbrellaSpeed = frame.size.width * 5.0
        
        let distanceToMove = CGFloat(asd)
        let moveDuration = distanceToMove / UmbrellaSpeed
         let moveright = SKAction.moveTo(x: Umbrella.position.x + distanceToMove, duration: TimeInterval(moveDuration))
        Umbrella.run(moveright)
    }
    override func didMove(to view: SKView) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            // do something here
//            self?.move()
            print()
        }
        motionManager.startAccelerometerUpdates()
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let gamebackgroundmusic = SKAudioNode(fileNamed: "RainBGM.mp3")
        
        // Get node of object to move
        let paddle = Umbrella
        
        // Get MotionManager data
        if let data = motionManager.accelerometerData {
            
            // Only get use data if it is "tilt enough"
            if (fabs(data.acceleration.x) > 0.2) {
                
                // Apply force to the moving object
                paddle.physicsBody!.applyForce(CGVector( dx: 40 *  CGFloat(data.acceleration.x),dy: 0))
                
            }
        }
        
        SpawnUmbrella()
        SpawnFire()
        addChild(gamebackgroundmusic)
        fireOff()
        
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
        
        UIView.animate(withDuration: 10.0, animations: { self.fire?.alpha = 1
            self.fire?.particleAlpha = 1
            self.fire?.particleLifetime = 2.5
        }, completion:{
            (value: Bool) in
            self.fire?.isHidden = false
        })
    }
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//
//            self.addChild(n)
//        }
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        for touch in (touches )
        {
            let location = touch.location(in: self)
            
            if(location.x < 0 )
            {
                moveleft(asd: 10)
            }
            else
            {
                moveright(asd: 10)
            }
         
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
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
            
//            if(location.x <= 70.0 && location.x >= -70)
//            {
//                fire?.isHidden = false
//            }
//            else{
//                fire?.isHidden = true
//            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        for touch in (touches )
        {
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(Umbrella.position.x <= 60 && Umbrella.position.x >= -60)
        {
            FireOn()
        }
//        else if((Umbrella.position.x > 60 && Umbrella.position.x <= 65 ) || Umbrella.position.x >= -65 && Umbrella.position.x < -60)
//        {
//            if(fire?.isHidden == true)
//            {
//                NoFire()
//            }
//            else
//            {
//                fireOff()
//            }
//        }
        else
        {
            fireOff()
        }
    }
    
    func SpawnUmbrella(){
        
        Umbrella.size = CGSize(width: 100, height: 100)
        Umbrella.alpha = 0.5
        Umbrella.setScale(1)
        Umbrella.zPosition = 2
        Umbrella.position = CGPoint(x:130 , y:-600)
        self.addChild(Umbrella)
    }
//    func SpawnAwan(){
//
//        Awan.size = CGSize(width: 200, height: 100)
//        Awan.alpha = 0.5
//        Awan.setScale(1)
//        Awan.zPosition = 1
//        Awan.position = CGPoint(x: 110 , y:400)
//        self.addChild(Awan)
//
//    }
    func SpawnFire(){
        
        fire!.alpha = 0.5
        fire!.setScale(1)
        fire!.zPosition = 1
        fire!.position = CGPoint(x:0 , y:-650)
        self.addChild(fire!)
    }
   
    
    
//    func moveFire(location: CGPoint) {
//        let fireSpeed = frame.size.width * 5.0
//        let moveDifference = CGPoint(x: location.x - fire!.position.x, y: location.y - fire!.position.y)
//        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
//        let moveDuration = distanceToMove / fireSpeed
//        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
//        fire!.run(moveAction)
//    }
    func moveUmbrella(location: CGPoint)
    {
    
//    let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
//
 
       
    }
//

    
}
