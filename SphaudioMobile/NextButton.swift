//
//  PlayButton.swift
//  Sphaudio
//
//  Created by Alex Harrison on 11/14/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class NextButton:UIButton
{
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let path = UIBezierPath();
        UIColor.whiteColor().setFill();
        
        // draw first triangle
        path.moveToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
        path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.5), y: rect.origin.y + (rect.height * 0.5)));
        path.addLineToPoint(CGPoint(x: 0.0, y: rect.origin.y + rect.height));
        path.addLineToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y));
        path.fill();
        
        // draw second triangle
        path.moveToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.5), y: rect.origin.y));
        path.addLineToPoint(CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + (rect.height * 0.5)));
        path.addLineToPoint(CGPoint(x: rect.width * 0.5, y: rect.origin.y + rect.height));
        path.addLineToPoint(CGPoint(x: rect.origin.x + (rect.width * 0.5) , y: rect.origin.y));
        path.fill();
        
        self.addTarget(main_controller, action: "next", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
