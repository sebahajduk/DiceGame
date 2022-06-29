//
//  DiceView.swift
//  DiceGame
//
//  Created by Sebastian Hajduk on 28/06/2022.
//

import SwiftUI

struct DiceView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .shadow(color: .purple.opacity(0.2), radius: 10)
                .padding()
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
