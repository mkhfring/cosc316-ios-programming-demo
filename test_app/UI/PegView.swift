//
//  PegView.swift
//  test_app
//
//  Created by MK on 2026-02-04.
//

import SwiftUI

struct PegView: View {
    let peg: Peg
    let pegShape = Circle()
    
    //MARK: - Body
    var body: some View {
        pegShape
            .overlay{
                if peg == Code.missing{
                    pegShape
                        .stroke(Color.black)
                }
                
            }
            .contentShape(Rectangle())
            .aspectRatio(1, contentMode: .fit)
        
            .foregroundStyle(peg)
    }
}

#Preview {
    PegView(peg: Peg.red)
        .padding(10)
}
