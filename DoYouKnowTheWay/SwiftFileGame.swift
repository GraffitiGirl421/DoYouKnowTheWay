import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let GameMessageName = "gameMessage"


class gameScene: SKScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        //
    }
    
    
}

