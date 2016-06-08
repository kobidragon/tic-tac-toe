//
//  ViewController.swift
//  ticTacToe
//
//  Created by Danny Kobayashi on 3/5/16.
//  Copyright © 2016 Danny Kobayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1 // 1 = X, 2 = O
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var gameActive = true

    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var gameOver: UILabel!
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        // only do something if the slot is open and the game is still active
        // otherwise drop to the bottom of this function and exit doing nothing
        
        if (gameState[sender.tag - 1] == 0 && gameActive == true) {
            
            gameState[sender.tag - 1] = activePlayer
            
            if activePlayer == 1 {
                
                sender.setBackgroundImage(UIImage(named: "tttO.png"), forState: .Normal)
                
                activePlayer = 2
                
            } else {
                
                sender.setBackgroundImage(UIImage(named: "tttX.png"), forState: .Normal)
                
                activePlayer = 1
                
            }
            
            // see if someone won
            
            for combination in winningCombinations {
                
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    
                    // someone has won so game is over
                    gameActive = false
                    
                    // check to see who won
                    if gameState[combination[0]] == 1 {
                        
                        gameOver.text = "O has won!"
                        
                    } else {
                        
                        gameOver.text = "X has won!"
                        
                    }
                    
                    // notify winner and return early
                    endGame()
                    return
                }
                
            }
            
            // by this point the buttonPressed func would have returned if someone has won
            // gameActive is still set to true
            // but need to see if any slots are still open
            // by checking for zeroes in gameState
            
            var foundZero = false
            
            for buttonState in gameState {
                    
                if buttonState == 0 {
                        
                    foundZero = true
                }
            }
            
            // if no zeroes then it must be a draw
            if foundZero == false {
                    
                gameOver.text = "It's a draw!"
                gameActive = false
                endGame()
                    
            }
            // drop through the end of the function
            // and await the next button press
    }
        
}
    

    
    
    func endGame() {
        
        gameOver.hidden = false
        playAgainButton.hidden = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.gameOver.center = CGPointMake(self.gameOver.center.x + 500, self.gameOver.center.y)
            
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
            
        })
        
    }
    
    
    @IBAction func playAgain(sender: AnyObject) {
        
        // reinitialize the game variables, hide and clear all labels and buttons
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activePlayer = 1
        
        gameActive = true
        
        gameOver.hidden = true
        
        gameOver.center = CGPointMake(gameOver.center.x - 500, gameOver.center.y)
        
        playAgainButton.hidden = true
        
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
        
        var buttonToClear : UIButton
        
        for var i = 1; i < 10; i++ {
            
            buttonToClear = view.viewWithTag(i) as! UIButton
            
            buttonToClear.setBackgroundImage(nil, forState: .Normal)
        }
        
 
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // hide and move off to the side all end of game labels and buttons
        gameOver.hidden = true
        
        gameOver.center = CGPointMake(gameOver.center.x - 500, gameOver.center.y)
        
        playAgainButton.hidden = true
        
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

