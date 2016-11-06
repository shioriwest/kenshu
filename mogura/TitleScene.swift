//
//  TitleScene.swift
//  mogura
//
//  Created by 西島志織 on 2016/08/27.
//  Copyright © 2016年 西島志織. All rights reserved.
//

import SpriteKit
import AVFoundation

/* タイトル画面の設定 */
class TitleScene: SKScene {
    let startLabel = SKLabelNode(fontNamed:"ArialRoundedMTBold")
    let help = SKSpriteNode(imageNamed: "help.png")
    
    // オーディオ
    var player = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        // BGMの設定
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgm", ofType:"mp3")!)
        player = try! AVAudioPlayer(contentsOfURL: bgm_url, fileTypeHint: "mp3")
        player.numberOfLoops = -1 // BGMをくりかえす
        player.play()
        
        // 背景の作成
        let background = SKSpriteNode(imageNamed: "title.jpg")
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.size = CGSize(width: size.width, height: size.height)
        self.addChild(background)
        
        // ゲームスタートラベルの設定
        startLabel.text = "START"
        startLabel.fontSize = 80
        startLabel.position = CGPoint(x: 375, y: 200)
        self.addChild(startLabel)
        
        // ヘルプアイコンの設定
        help.position = CGPoint(x:690, y:1290)
        self.addChild(help)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(location)
            
            // スタートラベルをタッチした場合はゲーム画面に遷移
            if touchNode == startLabel {
                let skView = self.view! as SKView
                let scene = GameScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(scene)
            }
            // ヘルプアイコンをタッチした場合は説明画面に遷移
            if touchNode == help {
                let skView = self.view! as SKView
                let scene = LectureScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(scene)
            }
        }
    }
}
