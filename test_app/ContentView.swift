//
//  ContentView.swift
//  test_app
//
//  Created by MK on 2026-01-12.
//

import SwiftUI

struct ContentView: View {
    @State private var game = MasterMindModel(pegChoices: [.brown, .yellow, .orange, .black])
    
    @State private var selection:Int = 0
    
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
            pegChooser
            
        }.padding()
        
        
    }
    var pegChooser: some View{
        HStack{
            ForEach(game.pegChoices, id:\.self){ peg in
                Button{
                    game.setGuessPeg(peg, at:selection)
                } label:{
                    PegView(peg:peg)
                }
                
            }
        }
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
        return HStack {
            ForEach(
                code.pegs.indices,
                id: \.self){
                    index in
                    PegView(peg: code.pegs[index])
                        .background{
                            if selection == index, code.kind == .guess{
                                RoundedRectangle(cornerRadius: Selection.cornerRadius)
                                    .foregroundStyle(Selection.pegColor)
                            }
                        }.padding(Selection.border)
                        .onTapGesture {
                            if code.kind == .guess{
                                selection = index
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
    struct Selection{
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let pegColor: Color = .gray(0.9)
    }

}



extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    ContentView()
}
