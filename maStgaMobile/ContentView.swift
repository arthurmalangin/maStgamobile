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
    @State private var rotationAngle: Double = 0
    @State private var elapsedTimeInSeconds: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Image de fond
                Image("backgroundimg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)

                // Contenu principal
                VStack {
                    Text(currentDate)
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .position(x: geometry.size.width / 2 - 75, y: geometry.size.height / 2 + 152)

                    Text(currentTime)
                        .font(.system(size: 24))
                        .position(x: geometry.size.width / 2 - 75, y: geometry.size.height / 2 - 10)

                    Text(expirationDate)
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .position(x: geometry.size.width / 2 + 95, y: geometry.size.height / 2 - 235 )
                    Text(expirationTime)
                        .font(.system(size: 24))
                        .position(x: geometry.size.width / 2 + 95, y: geometry.size.height / 2 - 400)
                }
                Text(expirationDate)
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 251)
                Text(expirationTime)
                    .font(.system(size: 24))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 276)
                Text(formattedElapsedTime)
                    .font(.system(size: 21))
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
                    .position(x: geometry.size.width / 2 + 131, y: geometry.size.height / 2 + 276)

                ZStack {
                    Circle()
                        .fill(Color(red: 0/255, green: 82/255, blue: 42/255))
                        .frame(width: 50, height: 50)
                        .offset(x: 100, y: 0)
                        .rotationEffect(.degrees(rotationAngle))

                    Circle()
                        .fill(Color(red: 255/255, green: 241/255, blue: 176/255))
                        .frame(width: 50, height: 50)
                        .offset(x: -100, y: 0)
                        .rotationEffect(.degrees(rotationAngle))
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 125)
                .onAppear {
                    withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                            rotationAngle = 360
                    }
                }
                
            }
        }
        .onReceive(timer) { _ in
            elapsedTimeInSeconds += 1
        }
        .onAppear {
            let now = Date()
            currentDate = formatDate(now)
            currentTime = formatTime(now)
            expirationTime = calculateExpirationTime(from: currentTime)
            expirationDate = currentDate
        }
    }

    var formattedElapsedTime: String {
        _ = elapsedTimeInSeconds / 3600
        let minutes = (elapsedTimeInSeconds % 3600) / 60
        let seconds = elapsedTimeInSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
        let components = time.components(separatedBy: ":")
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
