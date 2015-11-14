//
//  SongController.swift
//  SphaudioMobile
//
//  Created by Alex Harrison on 11/14/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class SongController:UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var super_view:UIView!;
    let margin:CGFloat = 80.0;
    var table_view:UITableView!;
    var media_collection:MPMediaItemCollection!;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        super_view = self.view;
        super_view.frame = CGRect(x: 0.0, y: margin, width: super_view.bounds.width, height: super_view.bounds.height - margin);
        super_view.backgroundColor = UIColor.blackColor();
        
        // song table view
        table_view = UITableView(frame: super_view.bounds, style: UITableViewStyle.Plain);
        table_view.dataSource = self;
        table_view.delegate = self;
        table_view.separatorStyle = UITableViewCellSeparatorStyle.None;
        table_view.backgroundColor = DARK_GRAY;
        super_view.addSubview(table_view);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        if((indexPath.row % 2) == 0)
        {
            cell.backgroundColor = DARK_GRAY;
        }
        else
        {
            cell.backgroundColor = GRAY;
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //https://stackoverflow.com/questions/29138285/ios-swift-how-to-access-all-music-file-in-directory
        let media_items = MPMediaQuery.songsQuery().items;
        media_collection = MPMediaItemCollection(items: media_items!);
        print(media_collection.count);
        return media_collection.count;
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected row");
    }
}