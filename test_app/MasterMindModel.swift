//
//  MasterMind.swift
//  test_app
//
//  Created by MK on 2026-01-22.
//
import SwiftUI

typealias Peg = Color

struct MasterMindModel {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind:.guess)
    var attempts: [Code] = [Code]()
    let pegChoices: [Peg] 
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]){
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    mutating func recordAttempt(){
        var attempt = guess
        attempt.kind = .attempt(attempt.match(against: masterCode))
        attempts.append(attempt)
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



