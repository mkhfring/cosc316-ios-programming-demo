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
            
            Circle().foregroundStyle(colors[0])
            Circle().foregroundStyle(colors[1])
            Circle().foregroundStyle(colors[2])
            Circle().foregroundStyle(colors[3])
        }
    }
}


#Preview {
    ContentView()
}
