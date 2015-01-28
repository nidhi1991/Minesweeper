//
//  squarebutton.swift
//  Minesweeper2
//
//  Created by Nidhi Shah on 1/27/15.
//  Copyright (c) 2015 Nidhi Shah. All rights reserved.
//

import Foundation
import UIKit

class SquareButton: UIButton {
    
    let squareSize:Float = 30
    let squareMargin:Float = 5
    let boardMargin = 0
    
    var square:Square
    
    init(squareModel:Square, squareSize:Float, squareMargin:Float) {
        self.square = squareModel
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        
        let x:CGFloat = CGFloat(self.square.col) * CGFloat(squareSize + squareMargin) + CGFloat(self.boardMargin)
        let y:CGFloat = CGFloat(self.square.row) * CGFloat(squareSize + squareMargin) + CGFloat(self.boardMargin)
        let squareFrame = CGRectMake(x, y, CGFloat(squareSize), CGFloat(squareSize))
        
        super.init(frame: squareFrame)
        
        self.setTitle("[ ]", forState: .Normal)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabelText() -> String {
        
        if !self.square.isMineLocation { // case 1: there's a mine
            
            if self.square.numNeighboringMines == 0 { // case 2: there's no mine and no neighboring mines
                return ""
            }else {
                return "\(self.square.numNeighboringMines)" // case 3: there's no mine but there are neighboring mines
            }
            
        } else {
            return "B"
        }
    }
};