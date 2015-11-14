//
//  heart_rate.swift
//  HealthApp
//
//  Created by Alex Harrison on 8/6/15.
//  Copyright (c) 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

// base class for menu button including setters for customizing appearance
class AudioButton:UIButton
{
    var icon_color:UIColor = UIColor.blackColor();
    var high_color:UIColor = UIColor.lightGrayColor();
    var un_high_color:UIColor = UIColor.whiteColor();
    var line_width:CGFloat = 1.0;
    var path:UIBezierPath  = UIBezierPath();
    var active_flag:Bool = false;
    var border_width:CGFloat = 0.0;
    var border_color:UIColor = UIColor.blackColor();
    var is_square:Bool = false;
    
    
    override init(frame:CGRect)
    {
        super.init(frame: frame);
        clipsToBounds = true;
        backgroundColor = UIColor.whiteColor();
        addTarget(self, action: "highlight_color", forControlEvents: UIControlEvents.TouchDown);
        addTarget(self, action: "unhighlight_color", forControlEvents: UIControlEvents.TouchUpInside);
        addTarget(self, action: "unhighlight_color", forControlEvents: UIControlEvents.TouchUpOutside);
    }
    
    
    // SETTERS FOR CUSTOMIZING APPEARANCE
    
    func set_square()
    {
        is_square = true;
        self.setNeedsDisplay();
    }
    func set_border_width(width:CGFloat)
    {
        self.border_width = width;
        self.setNeedsDisplay();
    }
    
    func set_border_color(color:UIColor)
    {
        self.border_color = color;
        self.setNeedsDisplay();
    }
    
    func set_highlight_color(color:UIColor)
    {
        self.high_color = color;
        self.setNeedsDisplay();
    }
    
    func set_unhighlight_color(color:UIColor)
    {
        self.un_high_color = color;
        self.backgroundColor = un_high_color;
        self.setNeedsDisplay();
    }
    
    func set_image_color(color:UIColor)
    {
        self.icon_color = color;
        self.setNeedsDisplay();
    }
    
    func set_path_width(width:CGFloat)
    {
        self.line_width = width;
        self.setNeedsDisplay();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        if(!is_square)
        {
            self.layer.cornerRadius = rect.width * 0.5;
        }
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        self.layer.shadowOpacity = Float(0.5);
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.borderColor = self.border_color.CGColor;
        self.layer.borderWidth = self.border_width;
        self.backgroundColor = un_high_color;
    }
    
    // highlights the button
    // this will only occur if the view corresponding to that button is loaded
    func highlight_color()
    {
        if(active_flag == false)
        {
            backgroundColor = high_color;
            self.clipsToBounds = true;
            self.setNeedsDisplay();
        }
    }
    
    func unhighlight_color()
    {
        backgroundColor = un_high_color;
        self.clipsToBounds = true;
        self.setNeedsDisplay();
    }
    
    // if the view controller corresponding to this button is loaded set this flag to true
    func set_active()
    {
        active_flag = true;
    }
    
    // if the view controller corresponding to this button disappears set flag to false
    func set_not_active()
    {
        active_flag = false;
    }
    
    
}