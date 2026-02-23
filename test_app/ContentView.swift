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
            Button("Restart"){
                withAnimation(.restart){
                    game.restart()
                    selection = 0
                }
            }
            view(for:game.masterCode)
            ScrollView{
                
                if !game.isGameOver{
                    view(for: game.guess)
                        .animation(nil, value: game.attempts.count)
                }
                //            pegs(colors:game.attempts[0].pegs)
                ForEach(
                    game.attempts.indices.reversed(),
                    id: \.self
                ){
                    index in view(for: game.attempts[index])
                }.transition(.asymmetric(
                    insertion: game.isGameOver ? .opacity : .move(edge: .top),
                    removal: .move(edge: .trailing))
                )
            }
            if !game.isGameOver{
                PegChooser(choices: game.pegChoices, onChoose: choosePegSelection)
                    .transition(.offset(x: 0, y: 200))
            }
            
            
        }.padding()
        
        
    }
    func choosePegSelection(to peg:Peg){
        game.setGuessPeg(peg, at:selection)
            selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    var guessButton: some View {
        Button("Guess"){
            withAnimation(.guess){
                game.recordAttempt()
                selection = 0
            }
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        return HStack {
            CodeView(code: code, selection: $selection)
            
            MatchMakers(match: code.matches)
                .overlay{
                    if code.kind == .guess{
                        guessButton
                    }
                    
                }
        }
        
    }
    

}
extension Animation{
    static let defualt = Animation.easeInOut(duration: 3)
    static let guess = Animation.defualt
    static let restart = Animation.defualt
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    ContentView()
}
