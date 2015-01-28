//
//  ViewController.swift
//  Minesweeper2
//
//  Created by Nidhi Shah on 1/27/15.
//  Copyright (c) 2015 Nidhi Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
        }
    }
    var timeTaken:Int = 0  {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
        }
    }
    
    var board:Board
    let BOARD_SIZE:Int = 10
    
    var oneSecondTimer:NSTimer?
    
    var squareButtons:[SquareButton] = []
    
    required init(coder aDecoder: NSCoder)
    {
        self.board = Board(size: BOARD_SIZE)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeBoard()
        
        self.startNewGame()
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                
                let square = board.squares[row][col]
                
                let squareMargin:Float = 5
                let squareSize:Float = Float(self.boardView.frame.width) / Float(BOARD_SIZE) - squareMargin //30
                
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize, squareMargin: 5);
                squareButton.setTitle("[x]", forState: .Normal)
                squareButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                squareButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareButton)
                
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func resetBoard() {
        
        self.board.resetBoard()
        
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", forState: .Normal)
        }
        
    }
    
    func oneSecond() {
        //Print in 1 second
        self.timeTaken++
    }
    
    func pressed(sender: SquareButton!) {
        
        if(!sender.square.isRevealed) {
            
            moves++
            
            sender.square.isRevealed = true
            sender.setTitle("\(sender.getLabelText())", forState: .Normal)
            
            if sender.square.isMineLocation {
                self.minePressed()
            }
            
        }
    }
    
    func minePressed() {
        
        self.endCurrentGame()
        
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "BABOOOOM!"
        alertView.message = "You hit a miney mine"
        alertView.delegate = self
        alertView.show()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Get rid of resources that can be recreated
    }
    
    @IBAction func newGamePressed() {
        
        self.endCurrentGame()
        
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("OK")
        alertView.title = "New Game!"
        alertView.message = "message"
        alertView.delegate = self
        alertView.show()
        
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        //start a new game
        self.startNewGame()
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
    
    func startNewGame() {
        //start new game
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    
    
}