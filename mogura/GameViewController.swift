//
//  GameViewController.swift
//  mogura
//
//  Created by 西島志織 on 2016/08/27.
//  Copyright (c) 2016年 西島志織. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面サイズをiPhone6に設定
        let scene = TitleScene(size:CGSize(width: 750, height: 1334))
        let skView = self.view as! SKView
        // アプリを起動するデバイスによって画面のサイズを自動で拡大・縮小できるように設定
        scene.scaleMode = .AspectFit
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
