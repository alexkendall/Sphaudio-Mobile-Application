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
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let path = UIBezierPath();
        UIColor.whiteColor().setStroke();
        path.lineWidth = 2.0;
        
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
