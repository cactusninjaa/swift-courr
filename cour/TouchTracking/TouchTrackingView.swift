//
//  TouchTrackingView.swift
//  cour
//
//  Created by thomas sauvage on 05/11/2025.
//
import SwiftUI
import UIKit

struct TouchTrackingView: UIViewRepresentable {
    struct TouchData {
        let id: Int
        let location: CGPoint
    }

    var onUpdate: ([TouchData]) -> Void

    func makeUIView(context: Context) -> TouchTrackingUIView {
        let view = TouchTrackingUIView()
        view.onUpdate = onUpdate
        return view
    }

    func updateUIView(_ uiView: TouchTrackingUIView, context: Context) {}
}

final class TouchTrackingUIView: UIView {
    var onUpdate: (([TouchTrackingView.TouchData]) -> Void)?
    
    private var activeTouches: [UITouch: CGPoint] = [:]
    private var initialPositions: [UITouch: CGPoint] = [:]
    
    private let movementTolerance: CGFloat = 10
    private var countdownTimer: Timer?
    private var countdownSeconds = 3
    private var partyInProgress = false
    private var winnerTouch: UITouch?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            activeTouches[touch] = location
            initialPositions[touch] = location
        }
        sendTouches()
        checkCountdownStart()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let start = initialPositions[touch] {
                let distance = hypot(location.x - start.x, location.y - start.y)
                if distance > movementTolerance {
                    // Significant movement → reset countdown if not in party
                    if !partyInProgress {
                        resetCountdown()
                    }
                    initialPositions[touch] = location
                    activeTouches[touch] = location
                } else {
                    // Minor movement → ignore, keep circle stable
                    activeTouches[touch] = start
                }
            }
        }
        sendTouches()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeTouches.removeValue(forKey: touch)
            initialPositions.removeValue(forKey: touch)
        }
        sendTouches()
        resetCountdownIfNeeded()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeTouches.removeValue(forKey: touch)
            initialPositions.removeValue(forKey: touch)
        }
        sendTouches()
        resetCountdownIfNeeded()
    }

    private func sendTouches() {
        let touchData = activeTouches.map { key, value in
            TouchTrackingView.TouchData(id: key.hash, location: value)
        }
        onUpdate?(touchData)
    }


    private func checkCountdownStart() {
        guard activeTouches.count >= 2, !partyInProgress else { return }
        resetCountdown()
        startCountdown()
    }

    private func resetCountdownIfNeeded() {
        if activeTouches.count < 2 && !partyInProgress {
            resetCountdown()
        }
    }

    private func resetCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        countdownSeconds = 3
    }

    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if self.activeTouches.count < 2 || self.partyInProgress {
                timer.invalidate()
                self.countdownSeconds = 3
                return
            }

            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            print("Countdown: \(self.countdownSeconds)")
            self.countdownSeconds -= 1

            if self.countdownSeconds <= 0 {
                timer.invalidate()
                self.startParty()
            }
        }
    }

    private func startParty() {
        guard activeTouches.count >= 2 else { return }

        partyInProgress = true

        let winner = activeTouches.randomElement()!
        winnerTouch = winner.key
        let winnerPosition = winner.value

        activeTouches = [winner.key: winnerPosition]
        sendTouches()

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        print("Party! Winner at: \(winnerPosition)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.partyInProgress = false
            self.winnerTouch = nil
            self.countdownSeconds = 3
        }
    }
}
