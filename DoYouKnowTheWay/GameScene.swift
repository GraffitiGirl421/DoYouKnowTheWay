//
//  GameScene.swift
//  DoYouKnowTheWay
//
//  Created by  on 1/10/18.
//  Copyright © 2018 deku. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
     let kidSpeed: CGFloat = 150.0
   
    var kid: SKSpriteNode?
    
    var lastTouch: CGPoint? = nil
    override func didMove(to view: SKView) {
        // Set up physics world's contact delegate
        listener = kid
        physicsWorld.contactDelegate = self as? SKPhysicsContactDelegate
        kid = childNode(withName: "kid") as? SKSpriteNode
        
        }
        
        
        
        // Set up initial camera position
    }


