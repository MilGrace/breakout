//
//  GameScene.swift
//  breakout
//
//  Created by  on 5/25/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var block = SKSpriteNode()
    var ball = SKSpriteNode()
    var paddle = SKSpriteNode()
    var bottom = SKSpriteNode()
    let gameOver = SKLabelNode()
    let replay = SKLabelNode()
    let texture1 = SKTexture(imageNamed: "replayButton")
    let texture2 = SKTexture(imageNamed: "refresh")
    let replayButton = SKSpriteNode()
    let youWon = SKLabelNode()
    var refresh = SKSpriteNode()
    
    
    override func didMove(to view: SKView)
    {
        gameOver.text = "Game Over"
        gameOver.fontSize = 65
        gameOver.fontColor = SKColor.red
        gameOver.position = CGPoint(x: frame.midX, y: frame.midY+70)
        replay.text = "Play Again?"
        replay.fontSize = 65
        replay.fontColor = SKColor.green
        replay.position = CGPoint(x: frame.midX, y: frame.midY)
        replayButton.size = CGSize(width: 150, height: 150)
        replayButton.texture = texture1
        replayButton.position = CGPoint(x: frame.midX, y: frame.midY-110)
        youWon.text = "You Won!"
        youWon.fontSize = 65
        youWon.fontColor = SKColor.green
        youWon.position = CGPoint(x: frame.midX, y: frame.midY+70)
        refresh.size = CGSize(width: 84.31, height: 84.31)
        refresh.texture = texture2
        refresh.position = CGPoint(x: 66.756, y: 639.022)
        addChild(refresh)
        
        createBlocks()
        ball = childNode(withName: "ball") as! SKSpriteNode
        paddle = childNode(withName: "paddle") as! SKSpriteNode
        bottom = childNode(withName: "bottom") as! SKSpriteNode
        
        let borderBody = SKPhysicsBody(edgeLoopFrom:self.frame)
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        ball.physicsBody?.categoryBitMask = 1
        paddle.physicsBody?.categoryBitMask = 2
        block.physicsBody?.categoryBitMask = 3
        bottom.physicsBody?.categoryBitMask = 4
        
        ball.physicsBody?.contactTestBitMask = 2 | 3 | 4
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3
        {
            print("hit")
            
            contact.bodyB.node!.removeFromParent()
            
            checkIfWon()
        }
        if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1
        {
            print("hit")
           
            contact.bodyA.node!.removeFromParent()
            
            checkIfWon()
        }
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 4
        {
            self.removeAllChildren()
            addChild(gameOver)
            addChild(replay)
            addChild(replayButton)
 
        }
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 1
        {
            self.removeAllChildren()
            addChild(gameOver)
            addChild(replay)
            addChild(replayButton)
        }
    }
    
    
    
    func createBlocks()
    {
        var blockCount = 0
        var xPos = 80.048
        var yPos = 1200.489
        
        for i in 0...47
        {
            block = SKSpriteNode(color:UIColor.red, size: CGSize(width: 113.163, height: 40.781))
            
            if blockCount%6 == 0
            {
                xPos = 80.048
                yPos -= 52
            }
            else
            {
                xPos += 118.134
            }
            blockCount += 1
            block.position = CGPoint(x: xPos, y: yPos)
            block.name = "block"
            addChild(block)
            block.physicsBody = SKPhysicsBody(rectangleOf: block.frame.size)
            block.physicsBody?.isDynamic = false
            block.physicsBody?.categoryBitMask = 3
        }
        
    }
    
    func refreshBall()
    {
        if ball.position.y > 285
        {
            ball.position = CGPoint(x: 390.58, y: 610.334)
        }
    }
    
    func checkIfWon()
    {
         if !(children.contains(where: { $0.name?.contains("block") ?? false }))
         {
            gameWon()
         }
    }
    
    func gameWon()
    {
        self.removeAllChildren()
        addChild(youWon)
        addChild(replay)
        addChild(replayButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        let location = touches.first!.location(in: self)
        paddle.position = CGPoint(x: location.x, y: paddle.position.y)
        
        if replayButton.contains(touch.location(in: self))
        {
            createBlocks()
            ball.position = CGPoint(x: 390.58, y: 610.334)
            addChild(ball)
            addChild(bottom)
            addChild(paddle)
            
            gameOver.removeFromParent()
            replay.removeFromParent()
            replayButton.removeFromParent()
            youWon.removeFromParent()
            
        }
        if refresh.contains(touch.location(in: self))
        {
            refreshBall()
        }
            
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first!.location(in: self)
        paddle.position = CGPoint(x: location.x, y: paddle.position.y)
    }
   
    
}
