//
//  ExScene.swift
//  mogura
//
//  Created by 西島志織 on 2016/09/14.
//  Copyright © 2016年 西島志織. All rights reserved.
//

import SpriteKit
import AVFoundation

class ExScene: SKScene {
    // オーディオ
    var player = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        // BGMの設定
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("high", ofType:"mp3")!)
        player = try! AVAudioPlayer(contentsOfURL: bgm_url, fileTypeHint: "mp3")
        player.play()
    }
}