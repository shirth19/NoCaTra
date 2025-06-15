//
//  UnlockableView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

struct UnlockableView: View {
    @ObservedObject var unlockableViewModel: UnlockableViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ForEach(0..<9, id: \.self) { index in
                    Toggle(isOn: Binding(
                        get: { unlockableViewModel.unlockStates[index] },
                        set: { newValue in
                            unlockableViewModel.setEntry(at: index, to: newValue)
                        }
                    )) {
                        Text(unlockableViewModel.unlockStates[index] ? "Entry \(index + 1): Unlocked" : "Entry \(index + 1): Locked")
                            .font(.headline)
                    }
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Text("Toggle entries to unlock or lock them")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .navigationTitle("Unlock Features")
            .padding()
        }
    }
}

#Preview {
    UnlockableView(unlockableViewModel: UnlockableViewModel())
}
