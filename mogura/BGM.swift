//
//  BGM.swift
//  mogura
//
//  Created by 西島志織 on 2016/09/13.
//  Copyright © 2016年 西島志織. All rights reserved.
//

import Foundation
import AVFoundation

class BGM:AVAudioPlayer{
    //使用するBGMファイルのリスト配列を作っときます
    let bgm_list = [
        0: "title_bgm",
        1: "stage_bgm_01",
        2: "stage_bgm_02",
        3: "boss_bgm"
    ]
    init (bgm:Int){
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(bgm_list[bgm], ofType:"mp3")!)
        try! super.init(contentsOfURL: bgm_url, fileTypeHint: "mp3")
    }
}
