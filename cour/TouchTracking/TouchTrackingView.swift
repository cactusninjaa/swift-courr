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
    var notificationsEnabled: Bool
    var numberOfWinners: Int
    @Binding var countdownValue: Int?

    func makeUIView(context: Context) -> TouchTrackingUIView {
        let view = TouchTrackingUIView()
        view.onUpdate = onUpdate
        view.notificationsEnabled = notificationsEnabled
        view.numberOfWinners = numberOfWinners
        
        view.onCountdownUpdate = { value in
            DispatchQueue.main.async {
              countdownValue = value
            }
        }
        return view
    }

    func updateUIView(_ uiView: TouchTrackingUIView, context: Context) {
        uiView.notificationsEnabled = notificationsEnabled
        uiView.numberOfWinners = numberOfWinners
    }
}

final class TouchTrackingUIView: UIView {
    var onUpdate: (([TouchTrackingView.TouchData]) -> Void)?
    
    var notificationsEnabled: Bool = true
    var numberOfWinners: Int = 1
    
    var onCountdownUpdate: ((Int?) -> Void)?
    
    private var activeTouches: [UITouch: CGPoint] = [:]
    private var initialPositions: [UITouch: CGPoint] = [:]
    
    private let movementTolerance: CGFloat = 0
    private var countdownTimer: Timer?
    private var countdownSeconds = 3
    private var partyInProgress = false
    private var winnerTouches: Set<UITouch> = []
    
    private let partyCooldown: TimeInterval = 2.0
    private var isCooldownActive = false // 👈 new flag

    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !partyInProgress else { return } // block new touches during party/cooldown

        if notificationsEnabled {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }

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
            // 👈 during cooldown, only allow winner touches to move
            if isCooldownActive && !winnerTouches.contains(touch) {
                continue
            }

            let location = touch.location(in: self)
            if let start = initialPositions[touch] {
                let distance = hypot(location.x - start.x, location.y - start.y)
                if distance > movementTolerance {
                    initialPositions[touch] = location
                    activeTouches[touch] = location
                } else {
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
            winnerTouches.remove(touch)
        }
        sendTouches()
        resetCountdownIfNeeded()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeTouches.removeValue(forKey: touch)
            initialPositions.removeValue(forKey: touch)
            winnerTouches.remove(touch)
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
        guard activeTouches.count >= numberOfWinners + 1, !partyInProgress else { return }
        resetCountdown()
        startCountdown()
    }

    private func resetCountdownIfNeeded() {
        if activeTouches.count < numberOfWinners + 1 && !partyInProgress {
            resetCountdown()
        }
    }

    private func resetCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        countdownSeconds = 3
        onCountdownUpdate?(nil)
    }

    private func startCountdown() {
        onCountdownUpdate?(countdownSeconds)
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if self.activeTouches.count < self.numberOfWinners + 1 || self.partyInProgress {
                timer.invalidate()
                self.countdownSeconds = 3
                self.onCountdownUpdate?(nil)
                return
            }

            if self.notificationsEnabled {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }

            print("Countdown: \(self.countdownSeconds)")
            self.countdownSeconds -= 1
            self.onCountdownUpdate?(self.countdownSeconds)

            if self.countdownSeconds <= 0 {
                timer.invalidate()
                self.onCountdownUpdate?(nil)
                self.startParty()
            }
        }
    }

    private func startParty() {
        guard activeTouches.count >= numberOfWinners + 1 else { return }

        partyInProgress = true
        isCooldownActive = true

        let allTouches = Array(activeTouches)
        let shuffled = allTouches.shuffled()
        let winners = Array(shuffled.prefix(numberOfWinners))

        winnerTouches = Set(winners.map { $0.key })

        var newActiveTouches: [UITouch: CGPoint] = [:]
        for (touch, position) in winners {
            newActiveTouches[touch] = position
        }
        activeTouches = newActiveTouches
        sendTouches()

        if notificationsEnabled {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }

        print("Party! \(numberOfWinners) winner(s) selected")

        DispatchQueue.main.asyncAfter(deadline: .now() + partyCooldown) { [weak self] in
            guard let self = self else { return }
            self.partyInProgress = false
            self.isCooldownActive = false
            self.winnerTouches.removeAll()
            self.countdownSeconds = 3
        }
    }
}
