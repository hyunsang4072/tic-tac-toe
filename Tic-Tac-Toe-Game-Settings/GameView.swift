//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Justin Wong on 7/16/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    @State private var showBackConfirmationAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScoreHeaderView(viewModel: viewModel)
                gameGrid
                FullGameResetButton(viewModel: viewModel)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        showBackConfirmationAlert.toggle()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
            }
            .alert("Are you sure you want to go back?", isPresented: $showBackConfirmationAlert) {
                Button("Cancel", role: .cancel) {
                    
                }
                Button("Yes", role: .destructive) {
                    viewModel.resetGame()
                    dismiss()
                }
            } message: {
                Text("If you exit the game, currrent in game progress will be lost!")
            }
        }
    }
    
    private var gameGrid: some View {
        GeometryReader { geo in
            LazyVGrid(columns: viewModel.columns, spacing: 5) {
                ForEach(0..<9) { i in
                    ZStack {
                        GameSquareView(color: viewModel.gridColor, proxy: geo)
                        PlayerIndicatorView(systemImageName: viewModel.moves[i]?.indicator ?? "")
                    }
                    .onTapGesture {
                        viewModel.processPlayerMove(for: i)
                    }
                }
            }
            .verticallyCentered()
            .disabled(viewModel.isGameboardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                    viewModel.resetGame()
                }))
            })
        }
    }
}

//MARK: - GameSquareView
struct GameSquareView: View {
    var color: Color
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(color).opacity(0.5)
            .frame(width: abs(proxy.size.width / 3 - 15), height: abs(proxy.size.width / 3 - 15))
    }
}

//MARK: - PlayerIndicatorView
struct PlayerIndicatorView: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

//MARK: - VerticallyCenteredView ViewModifer
struct VerticallyCenteredView: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
    func verticallyCentered() -> some View {
        modifier(VerticallyCenteredView())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
