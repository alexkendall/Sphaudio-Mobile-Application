//
//  EncodeAudio.swift
//  SphaudioMobile
//
//  Created by Alex Harrison on 11/15/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import Foundation
import UIKit

class Chunk
{
    var chunkID:Int!;
    var chunkSize:Int!;
    var chunkData:String!;
    
    init()
    {
        chunkID = 0;
        chunkSize = 0;
        chunkData = "";
    }
    
    init(_id:Int, _size:Int, _data:String)
    {
        chunkID = _id;
        chunkSize = _size;
        chunkData = _data;
    }

}