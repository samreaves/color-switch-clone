//
//  MenuScene.swift
//  ColorSwitchClone
//
//  Created by Samuel Reaves on 9/4/21.
//

import SpriteKit

class MenuScene: SKScene {
    
    let fontName = "AvenirNext-Bold"
    var playLabel: SKLabelNode?

    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        addLogo()
        addLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "playLabel" {
                    startGame()
                }
            }
        }
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "colorcircle")
        logo.size = CGSize(width: frame.width / 4, height: frame.width / 4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height / 4)
        addChild(logo)
    }
    
    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap to Play")
        playLabel.fontName = fontName
        playLabel.fontSize = 50.0
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        playLabel.name = "playLabel"
        self.playLabel = playLabel
        addChild(playLabel)
        
        let highScoreLabel = SKLabelNode(text: "High Score: ")
        highScoreLabel.fontName = fontName
        highScoreLabel.fontSize = 30.0
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height * 4)
        addChild(highScoreLabel)

        let lastScoreLabel = SKLabelNode(text: "Last Score: ")
        lastScoreLabel.fontName = fontName
        lastScoreLabel.fontSize = 30.0
        lastScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - lastScoreLabel.frame.size.height * 2)
        addChild(lastScoreLabel)
    }
    
    func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene)
    }
}
