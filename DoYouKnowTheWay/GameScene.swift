//
//  GameScene.swift
//  DoYouKnowTheWay
//
//  Created by  on 1/10/18.
//  Copyright © 2018 deku. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let ball: UInt32 = 0b1 // 000000000000000000000000000001
    static let topOrBottom: UInt32 = 0b10 // 000000000000000000000000000010
    static let paddle: UInt32 = 0b100 // 000000000000000000000000000100
    static let aiPaddle: UInt32 = 0b1000 // 00000000000000000000000001000
    static let top: UInt32 = 0b10000
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    
    var myPaddle = SKSpriteNode()
    var ball = SKSpriteNode()
    var block = SKSpriteNode()
    var aiPaddle = SKSpriteNode()
    var bottom = SKSpriteNode()
    var top = SKSpriteNode()
    var playerScoreLabel = SKLabelNode()
    var computerScoreLabel = SKLabelNode()
    var playerScore = 0
    var computerScore = 0
    
    
    override func didMove(to view: SKView) {
        // 1
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // 2
        borderBody.friction = 0
        // 3
        self.physicsBody = borderBody
        // Set the border of the world to the frame
        _ = SKPhysicsBody(edgeLoopFrom: frame)
        
        physicsBody?.friction = 0.0
        physicsBody = borderBody
        
        physicsWorld.gravity = CGVector.zero
        
        // get access to paddle.
        myPaddle = childNode(withName: "paddle") as! SKSpriteNode
        ball = childNode(withName: "ball") as! SKSpriteNode
      
        top = childNode(withName: "top") as! SKSpriteNode
        
        
        
        ball.physicsBody?.categoryBitMask = PhysicsCategory.ball
        myPaddle.physicsBody?.categoryBitMask = PhysicsCategory.paddle
        top.physicsBody?.categoryBitMask = PhysicsCategory.top
        
        
        
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.topOrBottom | PhysicsCategory.top
        physicsWorld.contactDelegate = self
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
      
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.ball && contact.bodyB.categoryBitMask == PhysicsCategory.top) || (contact.bodyB.categoryBitMask == PhysicsCategory.ball && contact.bodyA.categoryBitMask == PhysicsCategory.top) {
            print("ball hit top ")
            
            playerScore += 1
            block.color = #colorLiteral(red: 0.4938244522, green: 0.6815513968, blue: 0.3626080453, alpha: 1)
//            if contact.bodyB.node == top || contact.bodyA.node == top {
//                playerScore += 1
//                block.color = #colorLiteral(red: 0.4938244522, green: 0.6815513968, blue: 0.3626080453, alpha: 1)
//
//            }
        
            if playerScore == 1 {
                // present gameOverScene
                let gameOverScene = GameOverScene(size: self.size)
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                view?.presentScene(gameOverScene, transition: reveal)
            }
            restartBall()
        }
    }
    
    func restartBall() {
        // stop the ball
        ball.physicsBody!.velocity = CGVector.zero
        // wait 1 second
        let wait = SKAction.wait(forDuration: 1.0)
        
        // move to center
        let moveBall = SKAction.run {
            self.ball.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        }
        let pushBall = SKAction.run {
            // push ball again
            let array = [150, 200, 100, -150, -200, -100]
            let randx = Int(arc4random_uniform(UInt32(array.count)))
            let randy = Int(arc4random_uniform(UInt32(array.count)))
            self.ball.physicsBody!.applyImpulse(CGVector(dx: array[randx], dy: array[randy]))
        }
        
        let sequence = SKAction.sequence([wait, moveBall, wait, pushBall])
        
        run(sequence)
    }
    
    
    
    var isFingerOnPaddle = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //  if touch is on paddle... turn bool to true
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: touchLocation) {
            if body.node?.name == "paddle" {
                print("we found the paddle")
                isFingerOnPaddle = true
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // if bool is true, move paddle
        if isFingerOnPaddle == true {
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            myPaddle.position = CGPoint(x: touchLocation.x, y: -3000)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingerOnPaddle = false
    }
    
}

