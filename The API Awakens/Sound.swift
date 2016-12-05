//
//  Sound.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    let url = Bundle.main.url(forResource: "ImperialMarch", withExtension: "mp3")!
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        guard let player = player else { return }
        
        player.prepareToPlay()
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
}
