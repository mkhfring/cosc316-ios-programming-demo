//
//  ContentView.swift
//  test_app
//
//  Created by MK on 2026-01-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            pegs(colors:[.red, .green, .yellow, .blue])
            pegs(colors:[.red, .green, .red, .blue])
            pegs(colors:[.red, .blue, .yellow, .blue])
            
        }.padding()
        
    }
    
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(
                colors.indices,
                id: \.self){
                    index in RoundedRectangle(cornerRadius: 10)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundStyle(colors[index])
                }
            
            MatchMakers(match: [.exact, .inexact, .inexact, .noMatch])

        }
    }
}



#Preview {
    ContentView()
}
