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
    let pegChoices: [Peg] = [.red, .yellow, .green, .blue]
    
    init(){
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

struct Code{
    var kind: Kind
    var pegs:[Peg] = Array(repeating:Code.missing, count: 4)
    static let missing: Peg = .clear
    
    enum Kind : Equatable{
        case master
        case guess
        case attempt([Match])
    }
    
    mutating func randomize(from pegChoices:[Peg]){
        for index in pegs.indices{
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches) : return matches
        case .master, .guess: return []
        }
    }
    
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .noMatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs

        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index,
               pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }

        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }

        return results
    }
    
}

