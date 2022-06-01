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
    
    override func didMove(to view: SKView)
    {
        createBlocks()
        ball = childNode(withName: "ball") as! SKSpriteNode
        paddle = childNode(withName: "paddle") as! SKSpriteNode
        
        let borderBody = SKPhysicsBody(edgeLoopFrom:self.frame)
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        ball.physicsBody?.categoryBitMask = 1
        paddle.physicsBody?.categoryBitMask = 2
        block.physicsBody?.categoryBitMask = 3
        
        ball.physicsBody?.contactTestBitMask = 2 | 3
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3
        {
            print("hit")
            
            contact.bodyB.node!.removeFromParent()
        }
        if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1
        {
            print("hit")
           
            contact.bodyA.node!.removeFromParent()
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
            addChild(block)
            block.physicsBody = SKPhysicsBody(rectangleOf: block.frame.size)
            block.physicsBody?.isDynamic = false
            block.physicsBody?.categoryBitMask = 3
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first!.location(in: self)
        
        paddle.position = CGPoint(x: location.x, y: paddle.position.y)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let location = touches.first!.location(in: self)
        paddle.position = CGPoint(x: location.x, y: paddle.position.y)
    }
   
    
}
