//
//  DynamicGradientView.swift
//
//
//  Created by Livsy on 23.08.2024.
//

import SwiftUI

private struct CircleShape: Shape {
    
    var originOffset: CGPoint
    
    var animatableData: CGPoint.AnimatableData {
        get {
            originOffset.animatableData
        }
        set {
            originOffset.animatableData = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let adjustedX = rect.width * originOffset.x
        let adjustedY = rect.height * originOffset.y
        let smallestDimension = min(rect.width, rect.height)
        
        path.addArc(
            center: CGPoint(x: adjustedX, y: adjustedY),
            radius: smallestDimension / 2,
            startAngle: .zero,
            endAngle: .degrees(360),
            clockwise: true
        )
        
        return path
    }
    
}

private class CircleAnimator: ObservableObject {
    
    final class Circle: Identifiable {
        
        init(
            position: CGPoint,
            color: Color
        ) {
            self.position = position
            self.color = color
        }
        
        var position: CGPoint
        let id = UUID().uuidString
        let color: Color
        
    }
    
    @Published private(set) var circles: [Circle] = []
    
    init(colors: [Color]) {
        circles = colors.map { color in
            Circle(
                position: .random,
                color: color
            )
        }
    }
    
    func animate() {
        objectWillChange.send()
        circles.forEach { circle in
            circle.position = .random
        }
    }
    
}

public struct DynamicGradientView: View {
    
    private enum Constants {
        static let speed: Double = 3
        static let timerDuration: TimeInterval = 2
        static let blurRadius: CGFloat = 130
    }
    
    @ObservedObject private var animator: CircleAnimator
    @State private var timer = Timer.publish(
        every: Constants.timerDuration,
        on: .main,
        in: .common
    ).autoconnect()
    private let backgroundColor: Color
    
    public init(
        colors: [Color],
        backgroundColor: Color
    ) {
        self.animator = CircleAnimator(colors: colors)
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        ZStack {
            ZStack {
                ForEach(animator.circles) { circle in
                    CircleShape(originOffset: circle.position)
                        .foregroundColor(circle.color)
                }
            }
            .blur(radius: Constants.blurRadius)
        }
        .background(backgroundColor)
        .onDisappear {
            timer.upstream.connect().cancel()
        }
        .onAppear {
            animate()
            timer = Timer.publish(
                every: Constants.timerDuration,
                on: .main,
                in: .common
            ).autoconnect()
        }
        .onReceive(timer) { _ in
            animate()
        }
    }
    
    private func animate() {
        withAnimation(.easeInOut(duration: Constants.speed)) {
            animator.animate()
        }
    }
    
}

private extension CGPoint {
    static var random: CGPoint {
        CGPoint(
            x: CGFloat.random(in: 0 ... 1),
            y: CGFloat.random(in: 0 ... 1)
        )
    }
}
