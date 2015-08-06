//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jorge Gallardo on 8/5/15.
//  Copyright © 2015 Jorge Gallardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activePlayer = 1 // 1 = noughts, 2 = crosses
    var gameActive = true
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    var winningCombinations = [
        //horizontal
        [0,1,2], [3,4,5], [6,7,8],
        //vertical
        [0,3,6], [1,4,7], [2,5,8],
        //diagonals
        [0,4,8], [2,4,6]
    ]

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    this method is called when everything is created by not yet displayed on the screen - doesn't work for some reason
//    override func viewDidLayoutSubviews() {
//    }
    var totalMoves = 0

    @IBAction func buttonPressed(sender: AnyObject) {
        var labelText = ""
        if gameState[sender.tag] == 0 && gameActive == true {
            totalMoves++
            var image = UIImage()
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                image = UIImage(named: "nought.png")!
                activePlayer = 2
            } else {
                image = UIImage(named: "cross.png")!
                activePlayer = 1
            }
            sender.setImage(image, forState: .Normal)
            
            var isThereAWinner = false
            
            var winningCombo = 0

            for var i = 0; i < 8; i++ {
                if gameState[winningCombinations[i][0]] == gameState[winningCombinations[i][1]] && gameState[winningCombinations[i][1]] == gameState[winningCombinations[i][2]] && gameState[winningCombinations[i][0]] != 0 {
                    isThereAWinner = true
                    winningCombo = i
                }
            }
            if isThereAWinner == true {
                if gameState[winningCombinations[winningCombo][0]] == 1 {
                    labelText = "Noughts has won!"
                } else if gameState[winningCombinations[winningCombo][0]] == 2 {
                    labelText = "Crosses has won!"
                }
                gameOverLabel.text = labelText
                slideInAnimation()
            } else if totalMoves == 9 {
                labelText = "TIE, MOTHERFUCKER!"
                gameOverLabel.text = labelText
                slideInAnimation()
            }
        }
        print(totalMoves)
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        totalMoves = 0
        activePlayer = 1
        gameActive = true
        gameState = [0,0,0,0,0,0,0,0,0]
        var button: UIButton
        
        for var i = 0; i < 9; i++ {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: .Normal)
        }
        
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }
    
    func slideInAnimation() {
        gameOverLabel.hidden = false
        playAgainButton.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
        })
        gameActive = false
    }
}