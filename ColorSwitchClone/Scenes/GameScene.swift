//
//  GameScene.swift
//  ColorSwitchClone
//
//  Created by Samuel Reaves on 9/4/21.
//

import SpriteKit

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        layoutScene()
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "colorcircle")
        colorSwitch.size = CGSize(width: frame.size.width / 3, height: frame.size.width / 3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        addChild(colorSwitch)
        
        spawnBall()
    }
    
    func spawnBall() {
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 20, height: 20)
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
        addChild(ball)
    }
}
