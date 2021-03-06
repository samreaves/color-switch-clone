//
//  GameScene.swift
//  ColorSwitchClone
//
//  Created by Samuel Reaves on 9/4/21.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor.blue,
        UIColor.red,
        UIColor.yellow,
        UIColor.green
    ]
}

enum SwitchState: Int {
    case blue, red, yellow, green
}

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState: SwitchState = SwitchState.blue
    var currentColorIndex: Int?

    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()
    }

    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }

    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "colorcircle")
        colorSwitch.size = CGSize(width: frame.size.width / 3, height: frame.size.width / 3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        
        addChild(colorSwitch)
        
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        
        spawnBall()
    }

    func spawnBall() {
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1
        ball.name = "ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
        ball.zPosition = ZPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        
        addChild(ball)
    }

    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .blue
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi / 2, duration: 0.25))
    }
    
    func gameOver() {
        UserDefaults.standard.setValue(score, forKey: "lastScore")
        if (score) > UserDefaults.standard.integer(forKey: "highScore") {
            UserDefaults.standard.setValue(score, forKey: "highScore")
        }
        let menuScene = MenuScene(size: view!.bounds.size)
        view?.presentScene(menuScene)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (contactMask == PhysicsCategories.switchCategory | PhysicsCategories.ballCategory) {
            if let ball = contact.bodyA.node?.name == "ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if (currentColorIndex == switchState.rawValue) {
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.score += 1
                        self.scoreLabel.text = "\(self.score)"
                        self.spawnBall()
                    })
                } else {
                    gameOver()
                }
            }
        }
    }
}
