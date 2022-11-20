//
//  ViewController.swift
//  TicTacToe
//
//  Created by Babayev Kamran on 16.11.22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case crosses
        case noughts
    }
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var noughtsScore = 0
    var crossesScore = 0
    var buttons = [UIButton]()
    
    @IBOutlet weak var turnLabel: UILabel!
    
    var firstTurn = Turn.crosses
    var currentTurn = Turn.crosses
    
    var cross = "X"
    var nought = "O"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        addToBoard(sender)
        
        if checkForVictory(cross) {
            crossesScore += 1
            alertControler(title: "Crosses win")
        }
        
        if checkForVictory(nought) {
            noughtsScore += 1
            alertControler(title: "Noughts win")
        }
        
        if(fullBoard()) {
            alertControler(title: "Draw")
        }
            
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        // Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
        
        return false
    }
    
    func fullBoard() -> Bool
    {
        for button in buttons
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func resetBoard()
    {
        turnLabel.text = "X"
        
        for button in buttons
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.noughts
        {
            firstTurn = Turn.crosses
            turnLabel.text = cross
        }
        else if firstTurn == Turn.crosses
        {
            firstTurn = Turn.noughts
            turnLabel.text = nought
        }
        currentTurn = firstTurn
    }
    
    func alertControler(title: String) {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            print("reset board")
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func initButtons() {
        buttons.append(a1)
        buttons.append(a2)
        buttons.append(a3)
        buttons.append(b1)
        buttons.append(b2)
        buttons.append(b3)
        buttons.append(c1)
        buttons.append(c2)
        buttons.append(c3)
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.noughts)
            {
                sender.setTitle(nought, for: .normal)
                currentTurn = Turn.crosses
            }
            else if(currentTurn == Turn.crosses)
            {
                sender.setTitle(cross, for: .normal)
                currentTurn = Turn.noughts
            }
            sender.isEnabled = false
        }
    }
}

