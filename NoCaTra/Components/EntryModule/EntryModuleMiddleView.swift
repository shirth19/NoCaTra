//
//  EntryModuleMiddleView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

// This should be what the Entry model's middle section should be based on cases
// - If it is a log, it should be a text box
// - If it is a plan, it should be a text box
// - If it is a rating, it should allow the user pick 1-10 for ratingOne and Rating two

import SwiftUI

struct EntryModuleMiddleView: View {
    let contentType: EntryContentType
    @Binding var content: String
    @Binding var ratingOne: Int?
    @Binding var ratingTwo: Int?
    
    var body: some View {
        VStack(spacing: 12) {
            switch contentType {
            case .diary, .plan:
                TextEditor(text: $content)
                    .frame(height: 100)
                    .padding(8)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                
            case .rating:
                HStack(spacing: 20) {
                    VStack {
                        Text("Healthiness")
                            .font(.caption)
                        Picker("Rating One", selection: Binding(
                            get: { ratingOne ?? 5 },
                            set: { ratingOne = $0 }
                        )) {
                            ForEach(1...10, id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    VStack {
                        Text("Happiness")
                            .font(.caption)
                        Picker("Rating Two", selection: Binding(
                            get: { ratingTwo ?? 5 },
                            set: { ratingTwo = $0 }
                        )) {
                            ForEach(1...10, id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var text = "Sample text"
        @State private var ratingOne: Int? = 5
        @State private var ratingTwo: Int? = 7
        
        var body: some View {
            VStack(spacing: 20) {
                // Preview diary
                EntryModuleMiddleView(
                    contentType: .diary,
                    content: $text,
                    ratingOne: $ratingOne,
                    ratingTwo: $ratingTwo
                )
                
                // Preview rating
                EntryModuleMiddleView(
                    contentType: .rating,
                    content: $text,
                    ratingOne: $ratingOne,
                    ratingTwo: $ratingTwo
                )
            }
            .padding()
        }
    }
    
    return PreviewWrapper()
}
