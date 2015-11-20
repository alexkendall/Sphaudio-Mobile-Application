//
//  PlayButton.swift
//  Sphaudio
//
//  Created by Alex Harrison on 11/14/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer


class PlayButton:UIButton
{
    var audio_player:MPMusicPlayerController = MPMusicPlayerController();
    var is_playing:Bool = false;
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        // show play logo
        if(!is_playing)
        {
            let path = UIBezierPath();
            path.moveToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
            path.addLineToPoint(CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + (rect.height * 0.5)));
            path.addLineToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height));
            path.addLineToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
            UIColor.whiteColor().setFill();
            path.fill();
        }
            
        // show pause logo
        else
        {
            UIColor.whiteColor().setStroke();
            let path = UIBezierPath();
            path.lineWidth = 8.0;
            
            // draw first pause line
            path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.2) , y: rect.origin.y));
            path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.2), y: rect.origin.y + rect.height));
            
            // draw second pause line
            path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.8) , y: rect.origin.y));
            path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.8), y: rect.origin.y + (rect.height)));
            UIColor.whiteColor().setFill();
            path.stroke();
        }
    }
    
    func toggle_play()
    {
        if(is_playing)
        {
            set_paused();
        }
        else
        {
            set_playing();
        }
    }
    
    func set_paused()
    {
        is_playing = false;
        audio_player.pause();
        self.setNeedsDisplay();
    }
    
    func set_playing()
    {
        is_playing = true;
        audio_player.play();
        self.setNeedsDisplay();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(self, action: "toggle_play", forControlEvents: UIControlEvents.TouchUpInside);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
