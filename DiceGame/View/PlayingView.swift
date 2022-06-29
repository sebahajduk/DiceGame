//
//  PlayingView.swift
//  DiceGame
//
//  Created by Sebastian Hajduk on 28/06/2022.
//

import SwiftUI

struct PlayingView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Text("Recent scores:")
                        .bold()
                        .foregroundColor(.purple)
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 30, height: 30)
                            .shadow(color: .purple.opacity(0.2), radius: 5)
                            .padding()
                            .foregroundColor(.white)
                        Image(systemName: "dice")
                            .foregroundColor(.purple)
                            .contextMenu {
                                ForEach(viewModel.availableDices, id: \.self) { dice in
                                    Button("\(dice)-sided dice") {
                                        viewModel.diceType = dice
                                    }
                                }
                            }
                    }
                }
                
                ScrollView(.vertical, showsIndicators: true) {
                    ScrollViewReader { value in
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer()
                            ForEach(viewModel.recentScores, id: \.id) { score in
                                GeometryReader { geo in
                                    Text(score.score != 0 ? "\(score.score!)" : "")
                                        .bold()
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .opacity(Double((geo.frame(in: .global).minY - 120) / 100))
                                        .onTapGesture {
                                            print("\(geo.frame(in: .global).minY - 120)")
                                        }
                                        .scaleEffect(Double((geo.frame(in: .global).minY - 120) / 100) > 1 ? 1 : Double((geo.frame(in: .global).minY - 100) / 100))
                                        .position(x: geo.frame(in: .global).midX)
                                        .id(score.id)
                                        .padding(.bottom, 5)
                                        .shadow(color: .purple.opacity(0.6), radius: 5)
                                }
                            }
                            .onChange(of: viewModel.recentScores.count) { _ in
                                withAnimation {
                                    if viewModel.recentScores.count < 3 {
                                        value.scrollTo(viewModel.recentScores[viewModel.recentScores.count - 1].id, anchor: .top)
                                    } else {
                                        value.scrollTo(viewModel.recentScores[viewModel.recentScores.count - 1].id, anchor: .bottom)
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                            
                            Spacer()
                        }
                    }
                }
                .frame(height: 120)
                
                
                Spacer()
                
                Button("Roll") {
                    viewModel.rollTheDice(diceType: viewModel.diceType)
                    withAnimation {
                        viewModel.changeRotation()
                    }
                }
                .frame(width: 100, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundColor(.purple)
                .shadow(color: .purple.opacity(0.2), radius: 5)
                .padding(.bottom, 10)
                .disabled(!viewModel.animationEnded)
            }
            
            ZStack {
                DiceView()
                
                if viewModel.lastScore != 0 {
                    Text("\(viewModel.lastScore)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.purple)
                        .onReceive(viewModel.timer) { _ in
                            if !viewModel.animationEnded {
                                viewModel.lastScore = Int.random(in: 1...viewModel.diceType)
                            }
                        }
                }
            }
            .rotation3DEffect(Angle(degrees: viewModel.rotation), axis: (x: viewModel.randomX, y: viewModel.randomY, z: viewModel.randomZ))
            .animation(.easeOut(duration: 2), value: viewModel.rotation)
            
        }
    }
    
    
}

struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView()
    }
}
