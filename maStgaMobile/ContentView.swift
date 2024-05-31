//
//  ContentView.swift
//  maStgaMobile
//
//  Created by Arthur Malangin on 31/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate = ""
    @State private var currentTime = ""
    @State private var expirationTime = ""
    @State private var expirationDate = ""

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Image de fond
                Image("backgroundimg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // Contenu principal
                VStack {
                    Text(currentDate)
                        .font(.system(size: 24))
                        .bold()
                        .position(x: geometry.size.width / 2 - 75, y: geometry.size.height / 2 + 182)

                    Text(currentTime)
                        .font(.system(size: 24))
                        .position(x: geometry.size.width / 2 - 75, y: geometry.size.height / 2)

                    Text(expirationDate)
                        .font(.system(size: 24))
                        .bold()
                        .position(x: geometry.size.width / 2 + 95, y: geometry.size.height / 2 - 244.4)
                    Text(expirationTime)
                        .font(.system(size: 24))
                        .position(x: geometry.size.width / 2 + 95, y: geometry.size.height / 2 - 426)
                }
            }
        }
        .onAppear {
            let now = Date()
            currentDate = formatDate(now)
            currentTime = formatTime(now)
            expirationTime = calculateExpirationTime(from: currentTime)
            expirationDate = currentDate
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    func calculateExpirationTime(from time: String) -> String {
        var components = time.components(separatedBy: ":")
        guard let hours = Int(components[0]), let minutes = Int(components[1]) else {
            return ""
        }
        let newHour = (hours + 1) % 24
        return String(format: "%02d:%02d", newHour, minutes)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
