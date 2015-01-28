//
//  board.swift
//  Minesweeper2
//
//  Created by Nidhi Shah on 1/27/15.
//  Copyright (c) 2015 Nidhi Shah. All rights reserved.
//

import Foundation

class Board: NSObject {
    
    let size:Int
    
    // 2d list of tiles
    var squares:[[Square]] = []
    
    init(size:Int) {
        
        self.size = size
        super.init()
        
        for row in 0 ..< size {
            var squareRow:[Square] = []
            for col in 0 ..< size {
                let square = Square(row: row, col: col)
                squareRow.append(square)
            }
            squares.append(squareRow)
        }
        self.resetBoard()
    }
    
    func resetBoard() {
        for row in 0 ..< size {
            for col in 0 ..< size {
                squares[row][col].isRevealed = false
                self.calculateMineForSquare(squares[row][col])
            }
        }
        setupNeighborMineCounts()
    }
    
    func calculateMineForSquare(square: Square) {
        square.isMineLocation = ((arc4random()%10) == 0) // 10% chance that each location contains a mine
    }
    
    func setupNeighborMineCounts() {
        for row in 0 ..< size {
            for col in 0 ..< size {
                let thisSquare = squares[row][col]
                thisSquare.numNeighboringMines = calculateNumNeighborMines(thisSquare)
            }
        }
    }
    
    func calculateNumNeighborMines(square : Square) -> Int {
        
        let neighbors = getNeighboringSquares(square)
        var numNeighborMines = 0
        
        for neighborSquare in neighbors {
            if neighborSquare.isMineLocation {
                numNeighborMines++
            }
        }
        
        return numNeighborMines
    }
    
    func getNeighboringSquares(square : Square) -> [Square] {
        
        var neighbors:[Square] = []
        
        for (thisRow, thisCol) in
            [(square.row-1, square.col-1),
                (square.row-1, square.col),
                (square.row-1, square.col+1),
                (square.row, square.col-1),
                (square.row, square.col+1),
                (square.row+1, square.col-1),
                (square.row+1, square.col),
                (square.row+1, square.col+1)]
        {
            if isValidLocation(thisRow, col: thisCol) {
                neighbors.append(squares[thisRow][thisCol])
            }
        }
        
        return neighbors
    }
    
    func isValidLocation(row : Int, col : Int) -> Bool {
        return (row >= 0 && row < self.size && col >= 0 && col < self.size)
    }
    
    
}