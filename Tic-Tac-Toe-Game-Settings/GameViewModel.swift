//
//  GameViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Justin Wong on 7/17/23.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] =  [GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    @Published var playerScore = 0
    @Published var computerScore = 0
    
    //MARK: - Added gridColor property
    @Published var gridColor: Color = .red
    
    private let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    func processPlayerMove(for position: Int) {
        //human move processing
        if isSquareOccupied(in: moves, forIndex: position) {return}
        moves[position] = Move(player: .human, boardIndex: position)
        
        //check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            playerScore += 1
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        //computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                computerScore += 1
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        //If AI can win, then win
        let winPosition = getWinPositionIfPossible(for: getComputerPositions())
        guard winPosition == nil else { return winPosition! }
        
        //if AI can't win, then block
        let blockPosition = getWinPositionIfPossible(for: getHumanPositions())
        guard blockPosition == nil else { return blockPosition! }
        
        let centerSquareIndex = 4
        //If AI can't block, then take middle square
        if !isSquareOccupied(in: moves, forIndex: centerSquareIndex) {return centerSquareIndex}
        
        return getRandomNotOccupiedSquare()
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        
        //removes nils and gets player moves
        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let playerPositions = Set(playerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {return true}
        return false
    }
    
    //MARK: - Helper Methods
    private func getComputerPositions() -> Set<Int> {
        let computerMoves = moves.compactMap{$0}.filter{$0.player == .computer}
        return Set(computerMoves.map{$0.boardIndex})
    }
    
    private func getHumanPositions() -> Set<Int> {
        let humanMoves = moves.compactMap{$0}.filter{$0.player == .human}
        return Set(humanMoves.map{$0.boardIndex})
    }
    
    private func getRandomNotOccupiedSquare() -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
    func fullResetGame() {
        playerScore = 0
        computerScore = 0
        resetGame()
    }
    
    func getWinPositionIfPossible(for positions: Set<Int>) -> Int? {
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(positions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        return nil
    }
}
