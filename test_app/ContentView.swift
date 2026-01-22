//
//  ContentView.swift
//  test_app
//
//  Created by MK on 2026-01-12.
//

import SwiftUI

struct ContentView: View {
    @State var game = MasterMind()
    var body: some View {
        VStack{
            view(for:game.masterCode)
            view(for: game.guess)
//            pegs(colors:game.attempts[0].pegs)
            
        }.padding()
        
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(
                code.pegs.indices,
                id: \.self){
                    index in RoundedRectangle(cornerRadius: 10)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundStyle(code.pegs[index])
                        .onTapGesture {
                            if code.kind == .guess{
                                game.changePegchoice(at: index)
                            }
                        }
                }
            
            MatchMakers(match: [.exact, .inexact, .inexact, .noMatch])

        }
    }
}



#Preview {
    ContentView()
}
