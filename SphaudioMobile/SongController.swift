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

class SongController:UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    var super_view:UIView!;
    let margin:CGFloat = 80.0;
    var table_view:UITableView!;
    var media_items:[MPMediaItem]!;
    var queried_items:[MPMediaItem]!;
    var audio_player:MPMusicPlayerController = MPMusicPlayerController();
    var search_bar:UISearchBar!;
    
    var is_searching = false;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        super_view = self.view;
        super_view.frame = CGRect(x: 0.0, y: margin, width: super_view.bounds.width, height: super_view.bounds.height - margin);
        super_view.backgroundColor = UIColor.blackColor();
        
        
        // configure search bar
        let search_width:CGFloat = super_view.bounds.width;
        let search_height:CGFloat = 50.0;
        search_bar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: search_width, height: search_height));
        search_bar.delegate = self;
        super_view.addSubview(search_bar);
        
        // song table view
        table_view = UITableView(frame: CGRect(x: 0.0, y: search_height, width: super_view.bounds.width, height: super_view.bounds.height - search_height), style: UITableViewStyle.Plain);
        table_view.dataSource = self;
        table_view.delegate = self;
        table_view.separatorStyle = UITableViewCellSeparatorStyle.None;
        table_view.backgroundColor = DARK_GRAY;
        super_view.addSubview(table_view);
    }
    
    // TABLE VIEW DELEGATE IMPLEMENTATION BEGIN -------------------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell();
        cell.textLabel?.textColor = UIColor.whiteColor();
        var this_song:String!;
        
        // get song title
        if(is_searching)
        {
            this_song = queried_items![indexPath.row].title;
        }
        else
        {
            this_song = media_items![indexPath.row].title;
        }
       cell.textLabel?.text = this_song;

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
        
        if(!is_searching)
        {
            media_items = MPMediaQuery.songsQuery().items;
            return media_items!.count;
        }
        else
        {
            print(queried_items.count);
            return queried_items!.count;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var item:MPMediaItem!;
        if(is_searching)
        {
            item = queried_items[indexPath.row];
        }
        else
        {
            item = media_items[indexPath.row];
        }
        let mediaCollection = MPMediaItemCollection(items: [item]);
        audio_player.setQueueWithItemCollection(mediaCollection);
        audio_player.play();
        
        // set title and artist labels
        let _title = item.title!;
        let _artist = item.artist!;
        main_controller.set_artist(_artist);
        main_controller.set_title(_title);
    }
    
     // TABLE VIEW DELEGATE IMPLEMENTATION END ----------------------------------------------------------------
    
    // SEARCH BAR DELEGATE IMPLEMENTATION BEGIN----------------------------------------------------------------
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(search_bar.text == "")
        {
            reset_state();
        }
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("selected scope buttom");
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("cancel clicked");
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("text began editing");
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("text ended editing");
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        print("should begin editing");
        return true;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search button clicked");
        
        // search for songs with text specified in search
        
        queried_items = [MPMediaItem]();
        let search_text = searchBar.text;
        for(var i = 0; i < media_items.count; ++i)
        {
            let title = media_items[i].title;
            let artist = media_items[i].artist;
            
            // check if song title or artist comes up in query
            if((title?.rangeOfString(search_text!) != nil) || (artist?.rangeOfString(search_text!) != nil))
            {
                queried_items.append(media_items[i]);
            }
        }
        // must have at least one song to switch data source to queried songs
        if(queried_items.count > 0)
        {
            is_searching = true;
        }
        else
        {
            is_searching = false;
        }
        table_view.reloadData();
        search_bar.resignFirstResponder();
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        print("should end editing");
        return true;
    }
    
     // SEARCH BAR DELEGATE IMPLEMENTATION END-----------------------------------------------------------------
    
    func reset_state()
    {
        is_searching = false;
        search_bar.text = "";
        table_view.reloadData();
        
    }
}





