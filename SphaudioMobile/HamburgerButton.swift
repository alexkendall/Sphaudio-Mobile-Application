//
//  PlayButton.swift
//  Sphaudio
//
//  Created by Alex Harrison on 11/14/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class HamburgerButton:UIButton
{
    var _toggle:Bool = true;
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let path = UIBezierPath();
        UIColor.whiteColor().setStroke();
        
        if(_toggle)
        {
            path.lineWidth = 2.0;
        }
        else
        {
            path.lineWidth = 4.0;
        }
        
        // draw first line
        path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.1), y: rect.origin.y + (rect.height * 0.25)));
        path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.8), y: rect.origin.y + (rect.height * 0.25)));
        path.stroke();
        
        // draw second line
        path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.1), y: rect.origin.y + (rect.height * 0.5)));
        path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.8), y: rect.origin.y + (rect.height * 0.5)));
        path.stroke();
        
        // draw third line
        path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.1), y: rect.origin.y + (rect.height * 0.75)));
        path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.8), y: rect.origin.y + (rect.height * 0.75)));
        path.stroke();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(self, action: "toggle", forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    // switch function for toggling navigation hamburger bar on and off
    func toggle()
    {
        if(_toggle)
        {
            _toggle = false;
        }
        else
        {
            _toggle = true;
        }
        self.setNeedsDisplay();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
