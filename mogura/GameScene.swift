//
//  GameScene.swift
//  mogura
//
//  Created by 西島志織 on 2016/08/27.
//  Copyright (c) 2016年 西島志織. All rights reserved.
//

import SpriteKit
import AVFoundation

/* プレイ中のもろもろを設定するクラス */
class GameScene: SKScene {
    
    // ねこくんを出現させたい位置を指定（x,y）
    let nekoPoint = [[200, 300], [600, 400], [300, 600], [650, 700], [250, 900]]
    
    // ねこくんを入れる配列を用意する
    var nekoArray:[SKSpriteNode] = []
    
    // スコアとスコア表示用ラベルを用意する
    var score = 0
    let scoreLabel = SKLabelNode(fontNamed: "Verdana-bold")
    
    // 残り時間と残り時間表示用ラベルとタイマーを用意する
    var timeCount = 15
    let timeLabel = SKLabelNode(fontNamed: "Verdana-bold")
    var myTimer = NSTimer()
    
    // オーディオを用意する
    var player = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        // BGMの設定
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgm", ofType:"mp3")!) 
        player = try! AVAudioPlayer(contentsOfURL: bgm_url, fileTypeHint: "mp3")
        player.play()
        
        // 背景の作成
        let background = SKSpriteNode(imageNamed: "play.jpg")
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.size = CGSize(width: size.width, height: size.height)
        
        // 背景をゲームシーンに追加する
        self.addChild(background)
        
        // スコアラベルの設定
        scoreLabel.text = "SCORE:\(score)"
        scoreLabel.fontSize = 50
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.position = CGPoint(x: 40, y: 1250)
        self.addChild(scoreLabel)
        
        
        // ランダムに出現するねこくんを５体準備
        for i in 0...4 {
            
            // ねこくんを出現させたい位置に草を５つ準備
            let glass = SKSpriteNode(imageNamed: "glass.png")
            glass.position = CGPoint(x:nekoPoint[i][0], y:nekoPoint[i][1])
            self.addChild(glass)
            
            var neko: SKSpriteNode
            if (i == 0 || i == 1 || i == 4) {
                // ノーマルねこくんが３箇所に出現するように設定
                neko = SKSpriteNode(imageNamed: "neko.png")
                neko.name = "neko"
                neko.position = CGPoint(x:nekoPoint[i][0], y:nekoPoint[i][1])
            } else if (i == 2) {
                // ネクタイねこくんが１箇所に出現するように設定
                neko = SKSpriteNode(imageNamed: "nekutai.png")
                neko.name = "neku"
                neko.position = CGPoint(x:nekoPoint[i][0], y:nekoPoint[i][1])
            } else {
                // リボンねこくんが１箇所に出現するように設定
                neko = SKSpriteNode(imageNamed: "ribon.png")
                neko.name = "ribo"
                neko.position = CGPoint(x:nekoPoint[i][0], y:nekoPoint[i][1])
            }
            self.addChild(neko)
            
            // 位置情報と名前を持ったねこくんを配列に格納
            nekoArray.append(neko)
            
            // ------------------ ねこくんが出現したりしなかったりのアクションを指定 ------------------
            
            // ねこくんを地下(下に1000)に移動する
            let action1 = SKAction.moveToY(-1000, duration: 0.0)
            // 0〜4秒(2秒を中心に前後4秒範囲)ランダムに時間待ち
            let action2 = SKAction.waitForDuration(2.0, withRange: 4.0)
            // ねこくんを草の位置に移動するアクション
            let action3 = SKAction.moveToY(glass.position.y, duration: 0.0)
            // 0~2秒(1秒を中心に前後2秒範囲)でランダムに時間待ち
            let action4 = SKAction.waitForDuration(1.0, withRange: 2.0)
            // action1~action4を順番におこなう
            let actionS = SKAction.sequence([action1, action2, action3, action4])
            // ActionSをずっとくりかえす
            let actionR = SKAction.repeatActionForever(actionS)
            
            // ねこくんに「出現したりしなかったりするアクション」を設定する
            neko.runAction(actionR)
        }
        
        // 残り時間を表示する
        timeLabel.text = "Time:\(timeCount)"
        timeLabel.horizontalAlignmentMode = .Left
        timeLabel.fontSize = 50
        timeLabel.fontColor = SKColor.blackColor()
        timeLabel.position = CGPoint(x: 480, y: 1250)
        self.addChild(timeLabel)
        
        // タイマーをスタートさせる
        myTimer = NSTimer.scheduledTimerWithTimeInterval(
            1.0, target: self, selector: "timeUpdate", userInfo: nil, repeats: true)
        
    }
    
    // タイマーで実行される処理(1.0秒ごとに繰り返し実行)
    func timeUpdate() {
        timeCount--
        timeLabel.text = "Time:\(timeCount)"
        
        // タイムオーバー時の挙動
        if timeCount < 1 {
            myTimer.invalidate()
            
            var next:SKScene

            // 次の画面を設定する
            // 200点以上の場合はハイスコア画面、以下の場合はゲームオーバー画面
            if (score >= 200) {
                next = HighScoreScene(size: self.size)
            } else {
                next = GameOverScene(size: self.size)
            }
            let scene = next
            let skView = self.view as! GameSKView
            skView.score = score
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            // 次の画面に遷移
            skView.presentScene(scene)
        }
    }
    
    // 画面がタッチされたときの処理
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            // タッチした位置にあるものを調べる
            let touchNode = self.nodeAtPoint(location)
            
            for i in 0...4 {
                // ねこくんがタッチされた場合の処理
                if touchNode == nekoArray[i] {
                    var name = ""
                    // タッチされたねこくんによって点数の配分を変更、やられたときの画像を変更
                    if (touchNode.name == "neku") {
                        name = "tobaneku.png"
                        score += 30
                    } else if (touchNode.name == "ribo") {
                        name = "tobaribo.png"
                        score += 20
                    } else {
                        name = "tobaneko.png"
                        score += 10
                    }
                    scoreLabel.text = "SCORE:\(score)"
                    
                    // やられたときの効果音を設定
                    let effect : SKAction = SKAction.playSoundFileNamed("touch.mp3", waitForCompletion: true)
                    
                    // やられたねこくんを表示
                    let neko = SKSpriteNode(imageNamed: name)
                    neko.position = touchNode.position
                    self.addChild(neko)
                    
                    // ------------------ ねこくんに回転しながら上にとびだして消えるアクションを指定 ------------------
                    
                    // ねこくんを一回転させる
                    let action1 = SKAction.rotateByAngle(6.28, duration: 0.3)
                    // ねこくんを上に200移動させる
                    let action2 = SKAction.moveToY(touchNode.position.y + 200, duration: 0.3)
                    // action1とaction2を同時に実行
                    let actionG = SKAction.group([action1, action2])
                    // ねこくんを削除
                    let action3 = SKAction.removeFromParent()
                    // actionGとaction3を同時に実行
                    let actionS = SKAction.sequence([actionG, action3])
                    
                    // ねこくんに「回転しながら消えるアクション」を設定し、同時に効果音を鳴らす
                    self.runAction(effect)
                    neko.runAction(actionS)
                    
                    // ねこくんを地下(下に1000)に移動して消す
                    touchNode.position.y = -1000
                }
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}
