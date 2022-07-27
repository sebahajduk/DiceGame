
//
//  PlayingView-Model.swift
//  DiceGame
//
//  Created by Sebastian Hajduk on 28/06/2022.
//

import Foundation

extension PlayingView {
    @MainActor class ViewModel: ObservableObject {
        @Published var recentScores: [Score] = [Score(score: 0), Score(score: 0)]
        @Published var diceType: Int = 100
        @Published var rotation: Double = 0.0
        @Published var animationEnded = true
        @Published var lastScore: Int = 0
        @Published var randomX: Double = 0.0
        @Published var randomY: Double = 0.0
        @Published var randomZ: Double = 0.0
        
        let availableDices = [4, 6, 8, 10, 12, 20, 100]
        
        @Published var currentDate = Date()
        let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
        
        func rollTheDice(diceType: Int) {
            randomizeAxis()
            animationEnded = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                self.animationEnded = true
                self.recentScores.append(Score(score: Int.random(in: 1...diceType)))
                self.lastScore = self.recentScores[self.recentScores.count - 1].score!
                print("Animation ended")
            }
            
            lastScore = recentScores[recentScores.count - 1].score!
            
        }
        
        // Randomizing axis for dice rotations.
        private func randomizeAxis() {
            randomX = Double.random(in: -1...1)
            randomY = Double.random(in: -1...1)
            randomZ = Double.random(in: -1...1)
        }
        
        // Rotating the dice
        func changeRotation() {
            if rotation == 0 {
                rotation = 1080
            } else {
                rotation = 0
            }
        }
    }
}
