//
//  SelectGameColorView.swift
//  Tic-Tac-Toe-Game-Settings
//
//  Created by Justin Wong on 10/4/23.
//

import SwiftUI

struct SelectGameColorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                selectedColorHeader
                grid
            }
            .navigationTitle("Set Grid Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                }
            }
        }
    }
    
    private var selectedColorHeader: some View {
        HStack(spacing: 20) {
            Text("Selected Grid Color: ")
                .font(.title).bold()
            RoundedRectangle(cornerRadius: 10)
                .fill(viewModel.gridColor)
                .frame(width: 50, height: 50)
        }
    }
    
    private var grid: some View {
        Grid {      // 3x3 Matrix
            GridRow {
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .red)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .green)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .blue)
            }
            GridRow {
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .purple)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .yellow)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .black)
            }
            GridRow {
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .brown)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .cyan)
                ColorCircleView(selectedColor: $viewModel.gridColor, color: .indigo)
            }
        }
    }
}

struct ColorCircleView: View {
    @Binding var selectedColor: Color
    var color: Color
    
    var body: some View {
        Circle()
            .fill(selectedColor == color ?
                .indigo.opacity(0.3) : .clear)
            .frame(width: 100, height: 100)
            .overlay(
                Circle()
                    .fill(color)
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        selectedColor = color
                    }
            )
    }
}

#Preview {
    SelectGameColorView(viewModel: GameViewModel())
}
