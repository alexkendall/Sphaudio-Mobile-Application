//
//  PlayButton.swift
//  Sphaudio
//
//  Created by Alex Harrison on 11/14/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class PlayButton:UIButton
{
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let path = UIBezierPath();
        path.moveToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
        path.addLineToPoint(CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + (rect.height * 0.5)));
        path.addLineToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height));
        path.addLineToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
        UIColor.whiteColor().setFill();
        path.fill();

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(main_controller, action: "play", forControlEvents: UIControlEvents.TouchUpInside);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
