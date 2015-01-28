//
//  square.swift
//  Minesweeper2
//
//  Created by Nidhi Shah on 1/27/15.
//  Copyright (c) 2015 Nidhi Shah. All rights reserved.
//

import Foundation

class Square : NSObject {
    var isMineLocation:Bool
    var isRevealed:Bool
    
    var row:Int
    var col:Int
    var numNeighboringMines:Int
    
    init(row:Int, col:Int) {
        self.row = row
        self.col = col
        
        // initialize with deafult values that we will assign later
        self.isMineLocation = false
        self.isRevealed = false
        self.numNeighboringMines = 0
        
        super.init()
    }
    
}