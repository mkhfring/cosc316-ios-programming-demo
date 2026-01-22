//
//  MasterMind.swift
//  test_app
//
//  Created by MK on 2026-01-22.
//
import SwiftUI

typealias Peg = Color

struct MasterMind {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind:.guess)
    var attempts: [Code] = [Code]()
    let pegChoices: [Peg] = [.red, .yellow, .green, .blue]
    
    mutating func changePegchoice(at index: Int){
        let currentPeg = guess.pegs[index]
        if let currentPegIndexInChoices = pegChoices.firstIndex(of: currentPeg){
            guess.pegs[index] = pegChoices[(currentPegIndexInChoices + 1) % pegChoices.count]
        }
        else {
            guess.pegs[index] = pegChoices.first ?? .clear
        }
    }
    
}

struct Code{
    var kind: Kind
    var pegs:[Peg] = [.red, .red, .yellow, .blue]
    
    enum Kind{
        case master
        case guess
        case attempt
    }
    
}

