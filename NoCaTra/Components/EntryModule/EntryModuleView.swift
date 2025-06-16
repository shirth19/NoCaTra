//
//  EntryModuleView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

// This should be how all the entry modules look
// It should have a title, a button, a middle portion, and a caption - all within a box
// The middle portion should only be there if the module's variable says that the module is open
// What the middle portion should look like will be defined in a file called EntryModuleMiddleView
// a uniting file will between this the view and the models will be defined in viewModels section
// Little or no cases at this point -- just the structure to use in other portions

import SwiftUI


struct EntryModuleView: View {
    // MARK: - Properties
    let module: EntryModule
    @Binding var isOpen: Bool
    @Binding var content: String
    @Binding var ratingOne: Int?
    @Binding var ratingTwo: Int?
    @Binding var isLocked: Bool
    var previousContent: String? = nil
    
    @State private var isSessionStarted = false
    @State private var sessionTimer: Timer? = nil
    @State private var canStartSession = true
    @State private var timeRemaining: Int = 300
    
    // MARK: - Computed Properties
    private var title: String {
        switch module.category {
        case .food:
            return "Food " + module.contentType.rawValue.capitalized
        case .exercise:
            return "Exercise " + module.contentType.rawValue.capitalized
        case .mindfulness:
            return "Mindfulness " + module.contentType.rawValue.capitalized
        }
    }
    
    private var caption: Text {
        if !canStartSession && !isOpen {
            return Text("Completed, but you can still edit in the calendar. Don't worry if you didn't get everything")
        }

        switch (module.category, module.contentType) {
        case (.food, .diary):
            return Text("Track your meals from ") + Text("yesterday").bold()
        case (.food, .plan):
            return Text("Plan your meals for today")
        case (.food, .rating):
            return Text("Rate your meals from ") + Text("2 days ago").bold()
        case (.exercise, .diary):
            return Text("Track your exercise from ") + Text("yesterday").bold()
        case (.exercise, .plan):
            return Text("Plan your workouts for today")
        case (.exercise, .rating):
            return Text("Rate your exercise from ") + Text("2 days ago").bold()
        case (.mindfulness, .diary):
            return Text("Track your mindfulness practice from ") + Text("yesterday").bold()
        case (.mindfulness, .plan):
            return Text("Plan your mindfulness activities for today")
        case (.mindfulness, .rating):
            return Text("Rate your mindfulness practice from ") + Text("2 days ago").bold()
        }
    }
    
    private var buttonText: String {
        if isOpen {
            return "Done"
        }
        if !canStartSession {
            return "Completed"
        }
        return "Start"
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            // Header
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                if isOpen {
                    Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                        .font(.subheadline)
                        .monospacedDigit()
                }
                Button(buttonText) {
                    withAnimation {
                        if isOpen {
                            endSessionEarly()
                        } else if canStartSession {
                            startSession()
                        }
                    }
                }
                .disabled(!canStartSession && !isOpen)
            }
            
            // Middle portion (only if open)
            if isOpen {
                EntryModuleMiddleView(
                    contentType: module.contentType,
                    content: $content,
                    ratingOne: $ratingOne,
                    ratingTwo: $ratingTwo,
                    previousContent: previousContent
                )
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
            
            // Caption
            caption
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(radius: 2)
        )
    }
    
    private func startSession() {
        isOpen = true
        isSessionStarted = true
        canStartSession = false
        timeRemaining = 300
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            if timeRemaining == 0 {
                withAnimation {
                    isOpen = false
                    isSessionStarted = false
                    timer.invalidate()
                }
            }
        }
    }
    
    private func endSessionEarly() {
        sessionTimer?.invalidate()
        sessionTimer = nil
        isOpen = false
        isSessionStarted = false
    }
}
