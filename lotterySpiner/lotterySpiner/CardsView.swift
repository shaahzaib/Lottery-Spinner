//
//  CardsView.swift
//  lotterySpiner
//
//  Created by Macbook Pro on 10/03/2025.
//

import SwiftUI

struct CardsView: View {
    
    @Binding var symbol:String
    @Binding var background:Color
    var body: some View {
        
        
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .cornerRadius(20)
    }
}

#Preview {
    CardsView(symbol: Binding.constant("star"),background: Binding.constant(Color.green))
}
