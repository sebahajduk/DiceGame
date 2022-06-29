//
//  Score.swift
//  DiceGame
//
//  Created by Sebastian Hajduk on 25/06/2022.
//

import Foundation

class Score: Identifiable, Equatable {
    static func == (lhs: Score, rhs: Score) -> Bool {
        lhs.score == rhs.score
    }
    
    let id = UUID()
    let score: Int?
    
    init(score: Int) {
        self.score = score
    }
    
}
