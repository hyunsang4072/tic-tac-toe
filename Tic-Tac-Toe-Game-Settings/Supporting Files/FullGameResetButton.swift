//
//  FullGameResetButton.swift
//  Tic-Tac-Toe
//
//  Created by Justin Wong on 7/17/23.
//

import SwiftUI

//MARK: - Implement FullGameResetButton
struct FullGameResetButton: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        Button(action: {
            viewModel.fullResetGame()
        }) {
            Text("Full Reset Game")
                .bold()
                .foregroundColor(.white)
        }
        .padding()
        .background(.radialGradient(colors: [.blue.opacity(0.4), .purple.opacity(0.5)], center: .center, startRadius: 1, endRadius: 150))
        .cornerRadius(10)
        .shadow(color: .purple.opacity(0.9), radius: 10)
    }
}

struct FullGameResetButton_Previews: PreviewProvider {
    static let viewModel = GameViewModel()
    
    static var previews: some View {
        FullGameResetButton(viewModel: viewModel)
    }
}
