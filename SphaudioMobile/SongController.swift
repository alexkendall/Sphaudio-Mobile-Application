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
    var queried_refs:[Int] = [];
    var search_bar:UISearchBar!;
    var song_index:Int = 0;
    
    
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
        
        // load libraries songs
        media_items = MPMediaQuery.songsQuery().items;
        play_button.audio_player.setQueueWithItemCollection(MPMediaItemCollection(items: media_items));
    }
    
    // TABLE VIEW DELEGATE IMPLEMENTATION BEGIN -------------------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell();
        cell.textLabel?.textColor = UIColor.whiteColor();
        var this_song:String!;
        
        // get song title
        if(is_searching)
        {
            let index = queried_refs[indexPath.row];
            this_song = media_items![index].title;
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
        
        if(is_searching)
        {
            return queried_refs.count;
        }
        else
        {
            return media_items.count;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(!is_searching)
        {
            song_index = indexPath.row;
        }
        else
        {
            song_index = queried_refs[indexPath.row];
        }
        play_current();
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
        queried_refs = [];
        
        // search for songs with text specified in search-> get there indices
        for(var i = 0; i < media_items.count; ++i)
        {
            
            // convert all search fields to lowercase
            let title = media_items[i].title!.lowercaseString;
            let artist = media_items[i].artist!.lowercaseString;
            let search_text = searchBar.text!.lowercaseString;
            
            // check if song title or artist comes up in query, if does add to result set
            if((title.rangeOfString(search_text) != nil) || (artist.rangeOfString(search_text ) != nil))
            {
                queried_refs.append(i);
            }
        }
        // must have at least one song to switch data source to queried songs
        if(queried_refs.count > 0)
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
        return true;
    }
    
     // SEARCH BAR DELEGATE IMPLEMENTATION END-----------------------------------------------------------------
    
    func reset_state()
    {
        is_searching = false;
        search_bar.text = "";
        table_view.reloadData();
    }
    
    func play_prev()
    {
        print("playing previous");
        if(media_items.count > 0)
        {
            if(song_index == 0)
            {
                song_index = media_items.count - 1;
            }
            else
            {
                --song_index;
            }
            
            play_current();
        }
        print("song index = " + String(song_index));
    }
    
    func play_next()
    {
        print("playing next");
        if(media_items.count > 0)
        {
            if(song_index == (media_items.count - 1))
            {
                song_index = 0;
            }
            else
            {
                ++song_index;
            }
            print("song index = " + String(song_index));
            
            play_current();
        }
    }
    
    func play_current()
    {
        let item = media_items[song_index];
        main_controller.set_artist(item.artist!);
        main_controller.set_title(item.title!);
        play_button.audio_player.setQueueWithItemCollection(MPMediaItemCollection(items: [item]));
        play_button.audio_player.play();
        play_button.set_playing();
    }
    
}