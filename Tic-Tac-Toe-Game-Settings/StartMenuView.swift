//
//  StartMenuView.swift
//  Tic-Tac-Toe-Game-Settings
//
//  Created by Justin Wong on 10/4/23.
//

import SwiftUI

struct StartMenuView: View {
    @StateObject var viewModel: GameViewModel = GameViewModel()
    @State private var isPresentingGridColorSheet = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Tic-Tac-Toe")
                .font(.system(size: 50, weight: .heavy))
            Spacer()
            VStack(spacing: 30) {
                
                playGameNavigationLink
                Button(action: {
                    isPresentingGridColorSheet.toggle()
                }) {
                    Text("Set Grid Color")
                        .homeViewButtonStyle(backgroundColor: .gray)
                }
                .sheet(isPresented: $isPresentingGridColorSheet) {
                    SelectGameColorView(viewModel: viewModel)
                }
            }
            Spacer()
        }
    }
    
    private var playGameNavigationLink: some View {
        NavigationLink {
            GameView(viewModel: viewModel)
        } label: {
            Text("Play Game")
                .homeViewButtonStyle(backgroundColor: .green)
        }
//                Button(action: {}) {
//                    Text("Play Game")
//                        .homeViewButtonStyle(backgroundColor: .green)
//                }
    }
}

//MARK: - HomeViewButtonStyle ViewModifier
struct HomeViewButtonStyle: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
        //MARK: - Add modififers below
            .frame(width: 200)
            .foregroundColor(.white)
            .font(.title).bold()
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

//MARK: - Ignore below
extension View {
    func homeViewButtonStyle(backgroundColor: Color) -> some View {
        return modifier(HomeViewButtonStyle(backgroundColor: backgroundColor))
    }
}

#Preview {
    StartMenuView()
}
