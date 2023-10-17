//
//  GameModel.swift
//  Tic-Tac-Toe
//
//  Created by Justin Wong on 7/17/23.
//

import Foundation

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
