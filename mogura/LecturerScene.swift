//
//  LecturerScene.swift
//  mogura
//
//  Created by 西島志織 on 2016/09/14.
//  Copyright © 2016年 西島志織. All rights reserved.
//

import SpriteKit
import AVFoundation

/* ヘルプ画面の設定 */
class LectureScene: SKScene {
    let returnLabel = SKLabelNode(fontNamed:"ArialRoundedMTBold")
    
    // オーディオ
    var player = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        // BGMの設定
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgm", ofType:"mp3")!)
        player = try! AVAudioPlayer(contentsOfURL: bgm_url, fileTypeHint: "mp3")
        player.numberOfLoops = -1 // くりかえし
        player.play()
        
        // 背景の作成
        let background = SKSpriteNode(imageNamed: "lec.jpg")
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.size = CGSize(width: size.width, height: size.height)
        self.addChild(background)
        
        // リターンラベルの設定
        returnLabel.text = "RETURN"
        returnLabel.fontSize = 70
        returnLabel.position = CGPoint(x: 375, y: 200)
        self.addChild(returnLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(location)
            
            // リターンラベルがタッチされた場合はタイトル画面に遷移
            if touchNode == returnLabel {
                let skView = self.view! as SKView
                let scene = TitleScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(scene)
            }
        }
    }
}
