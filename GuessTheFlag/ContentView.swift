//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mateus Moura Santos on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    fileprivate func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
    }
    
    fileprivate func askQUestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                      .font(.largeTitle.weight(.bold))
                      .foregroundStyle(.white)
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                VStack(spacing: 15) {
                    
                    Text(scoreTitle).font(.body).bold()
                    
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.white).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundStyle(.white).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            showingScore = true
                        } label: {
                            Image(countries[number]).clipShape(.capsule).shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQUestion)
        } message: {
            Text("Your score is \(score)")
        }
        
    
    }
}

#Preview {
    ContentView()
}
