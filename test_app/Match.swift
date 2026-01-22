//
//  Match.swift
//  test_app
//
//  Created by MK on 2026-01-15.
//

import SwiftUI

enum Match{
    case exact
    case inexact
    case noMatch
}


struct MatchMakers: View {
    var match: [Match]
    var body: some View {
        HStack{
            VStack{
                matchMaker(peg: 0)
                matchMaker(peg: 1)
            }
            VStack{
                matchMaker(peg: 2)
                matchMaker(peg: 3)
            }
        }
        
    }
    
    
    func matchMaker(peg:Int) -> some View {
        
        
        let matchCount:Int = match.count{$0 == .exact}
        
        
        let foundCount:Int = match.count{ $0 != .noMatch}

        return Circle()
            .fill(matchCount > peg ? Color.primary: Color.clear)
            .stroke(foundCount > peg ? Color.primary: Color.clear, lineWidth:2)
    }
    
}

#Preview {
    MatchMakers(match: [.exact, .inexact, .exact])
}
