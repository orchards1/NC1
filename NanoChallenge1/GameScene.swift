//
//  GameScene.swift
//  NanoChallenge1
//
//  Created by Michael Louis on 18/05/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate {
    let Umbrella = SKSpriteNode(imageNamed: "Umbrella")
    var rainBGM : SKAudioNode!
    
    
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let gamebackgroundmusic = SKAudioNode(fileNamed: "RainBGM.mp3")
        SpawnUmbrella()
        addChild(gamebackgroundmusic)
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

            
            moveUmbrella(location: location)
    
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        for touch in (touches )
        {
            let location = touch.location(in: self)
            
            
            moveUmbrella(location: location)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        for touch in (touches )
        {
            let location = touch.location(in: self)
            
            
            moveUmbrella(location: location)
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        for touch in (touches )
        {
            let location = touch.location(in: self)
            moveUmbrella(location: location)
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func SpawnUmbrella(){
        
        Umbrella.size = CGSize(width: 100, height: 100)
        Umbrella.setScale(1)
        Umbrella.zPosition = 1
        Umbrella.position = CGPoint(x: 90 , y:20)
        self.addChild(Umbrella)
        
    }
    
    func moveUmbrella(location: CGPoint) {
    let UmbrellaSpeed = frame.size.width * 5.0
    let moveDifference = CGPoint(x: location.x - Umbrella.position.x, y: location.y - Umbrella.position.y)
    let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
    let moveDuration = distanceToMove / UmbrellaSpeed
    let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
    Umbrella.run(moveAction)
    }
    
}
