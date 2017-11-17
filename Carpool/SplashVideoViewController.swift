//
//  VideoViewController.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/17/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import Foundation
import UIKit
import AVKit


class SplashVideoViewController: AVPlayerViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let path = Bundle.main.path(forResource: "splash-video", ofType: "mp4")!
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player!.play()
        
        var ref: Any!
        ref = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player!.currentItem!, queue: .main) { note in
            
            // SEGUE TO NEXT VC
            self.performSegue(withIdentifier: "Tab", sender: Any?.self)
            
            
            NotificationCenter.default.removeObserver(ref)
        }
    }
}
