//
//  PegChooser.swift
//  test_app
//
//  Created by MK on 2026-02-08.
//

import SwiftUI

struct PegChooser: View {
    let choices: [Peg]
    let onChoose: (Peg) -> Void
    
    var body: some View {
            HStack{
                ForEach(choices, id:\.self){ peg in
                    Button{
                        onChoose(peg)
                    } label:{
                        PegView(peg:peg)
                    }
                    
                }
            }
        }
}

//#Preview {
//    PegChooser()
//}
