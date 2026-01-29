//
//  ContentView.swift
//  test_app
//
//  Created by MK on 2026-01-12.
//

import SwiftUI

struct ContentView: View {
    @State var game = MasterMindModel()
    var body: some View {
        VStack{
            view(for:game.masterCode)
            ScrollView{
                view(for: game.guess)
                //            pegs(colors:game.attempts[0].pegs)
                ForEach(
                    game.attempts.indices.reversed(),
                    id: \.self
                ){
                    index in view(for: game.attempts[index])
                }
            }
            
        }.padding()
        
        
    }
    
    var guessButton: some View {
        Button("Guess"){
            withAnimation{
                game.recordAttempt()
            }
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(
                code.pegs.indices,
                id: \.self){
                    index in RoundedRectangle(cornerRadius: 10)
                        .contentShape(Rectangle())
                        .aspectRatio(1, contentMode: .fit)
                    
                        .foregroundStyle(code.pegs[index])
                        .onTapGesture {
                            if code.kind == .guess{
                                game.changePegchoice(at: index)
                            }
                        }
                }
            
            MatchMakers(match: code.matches)
                .overlay{
                    if code.kind == .guess{
                        guessButton
                    }
                    
                }

        }
    }
}



#Preview {
    ContentView()
}
