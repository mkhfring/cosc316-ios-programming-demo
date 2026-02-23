//
//  Code.swift
//  test_app
//
//  Created by MK on 2026-02-04.
//


import SwiftUI

struct Code{
    var kind: Kind
    var pegs:[Peg] = Array(repeating:Code.missing, count: 4)
    static let missing: Peg = .clear
    
    enum Kind : Equatable{
        case master(isHidden: Bool)
        case guess
        case attempt([Match])
    }
    
    var isHidden:Bool{
        switch kind{
        case .master(let hidden): return hidden
        default: return false
        }
    }
    
    mutating func reset(){
        pegs = Array(repeating: Peg.clear, count: 4)
    }
    
    mutating func randomize(from pegChoices:[Peg]){
        for index in pegs.indices{
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
        print(self)
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
