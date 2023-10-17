//
//  ScoreHeaderView.swift
//  Tic-Tac-Toe
//
//  Created by Justin Wong on 7/17/23.
//

import SwiftUI

struct ScoreHeaderView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        HStack {
            Spacer()
            PlayerAvatarScoreView(avatar: "🫵", score: viewModel.playerScore)
            Spacer()
            PlayerAvatarScoreView(avatar: "💻", score: viewModel.computerScore)
            Spacer()
        }
        .padding()
        .background(viewModel.gridColor.opacity(0.2))
        .cornerRadius(10)
        .shadow(color: viewModel.gridColor, radius: 10)
        .padding()
    }
}

struct PlayerAvatarScoreView: View {
    var avatar: String
    var score: Int
    
    var body: some View {
        VStack {
            Text(avatar)
                .font(.system(size: 60))
            Text("\(score)")
                .bold()
                .font(.system(size: 40))
        }
    }
}


struct ScoreHeaderView_Previews: PreviewProvider {
    static let viewModel = GameViewModel()
    
    static var previews: some View {
        ScoreHeaderView(viewModel: viewModel)
    }
}
