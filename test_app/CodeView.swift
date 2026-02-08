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
    }
    struct Selection{
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let pegColor: Color = .gray(0.9)
    }
}

//#Preview {
//    CodeView(code)
//}
