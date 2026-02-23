//
//  CodeView.swift
//  test_app
//
//  Created by MK on 2026-02-08.
//

import SwiftUI

struct CodeView: View {
    let code:Code
    @Binding var selection : Int
    
    
    var body: some View {
        ForEach(
            code.pegs.indices,
            id: \.self){
                index in
                PegView(peg: code.pegs[index])
                    .background{
                        if selection == index, code.kind == .guess{
                            Selection.shape
                                .foregroundStyle(Selection.pegColor)
                        }
                    }.padding(Selection.border)
                    .overlay{
                        Selection
                            .shape
                            .foregroundStyle(code.isHidden ? Color.gray: Color.clear)
                            .animation(nil, value: code.isHidden)
                    }
                    .onTapGesture {
                        if code.kind == .guess{
                            selection = index
                        }
                    }
            }
    }
    struct Selection{
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let pegColor: Color = .gray(0.9)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}

//#Preview {
//    CodeView(code)
//}
