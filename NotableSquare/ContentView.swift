//
//  ContentView.swift
//  NotableSquare
//
//  Created by Nikita Koruts on 11.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var dragOffset: CGSize = .zero
    
    private let colors: [Color] = [.white, .pink, .yellow, .black]
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                ForEach(colors, id: \.self) { color in
                    Rectangle()
                        .fill(color)
                }
            }
            DraggableView()
                .frame(width: 100, height: 100)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged(dragOnChange(_:))
                        .onEnded(dragOnEnd(_:)))
        }
        .ignoresSafeArea()
    }
    
    private func dragOnChange(_ value: DragGesture.Value) {
        dragOffset = value.translation
    }
    
    private func dragOnEnd(_ value: DragGesture.Value) {
        withAnimation(.spring()) {
            dragOffset = .zero
        }
    }
}

struct DraggableView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .blendMode(.difference)
            .overlay(.blendMode(.hue))
            .overlay(Color.white.blendMode(.overlay))
            .overlay(Color.black.blendMode(.overlay))
            .cornerRadius(16)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
