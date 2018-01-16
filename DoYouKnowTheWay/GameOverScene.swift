import UIKit
import SpriteKit

class GameOverScene: SKScene {
    override func didMove(to view: SKView){
        let label = SKLabelNode(fontNamed: "Wingdings")
        label.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        label.fontSize = 40
        label.text = "Game Over \nClick Anywhere to Play Again"
        label.fontColor = UIColor.white
        addChild(label)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(fileNamed: "GameScene")
        gameScene?.scaleMode = .aspectFill
        let reveal = SKTransition.doorsOpenHorizontal(withDuration: 2)
        view?.presentScene(gameScene!, transition: reveal)
    }
}

