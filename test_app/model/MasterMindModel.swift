//
//  MasterMind.swift
//  test_app
//
//  Created by MK on 2026-01-22.
//
import SwiftUI

typealias Peg = Color

struct MasterMindModel {
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind:.guess)
    var attempts: [Code] = [Code]()
    let pegChoices: [Peg] 
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]){
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else {return}
        guess.pegs[index] = peg
    }
    
    var isGameOver: Bool{
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func recordAttempt(){
        var attempt = guess
        attempt.kind = .attempt(attempt.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
        if isGameOver {
            masterCode.kind = .master(isHidden: false)
        }
        
    }
    
    mutating func changePegchoice(at index: Int){
        let currentPeg = guess.pegs[index]
        if let currentPegIndexInChoices = pegChoices.firstIndex(of: currentPeg){
            guess.pegs[index] = pegChoices[(currentPegIndexInChoices + 1) % pegChoices.count]
        }
        else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
}



