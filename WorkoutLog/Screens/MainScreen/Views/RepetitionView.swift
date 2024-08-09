//
//  RepetitionView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/9/24.
//

import SwiftUI

struct RepetitionView: View {
    @State var repetition: RepetitionEntity
    @State var testBool: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            Spacer()

            Text("")

            VStack {
                Text("\(repetition.count) of " + (repetition.name ?? ""))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    
                    

                Stepper(value: $repetition.count) {} onEditingChanged: { _ in
                    try? repetition.managedObjectContext?.save()
                }
                .labelsHidden()
                
            }
            .padding(.horizontal)
            
//            Divider()
            
            Button(action: {
                testBool.toggle()
            }, label: {
                Text(Image(systemName: testBool ? "checkmark.square" : "square"))
                    .font(.title2)
            })
            .buttonStyle(.plain)
            .foregroundStyle(.primary)
            .padding(16)
            .animation(.easeIn(duration: 0.05), value: testBool)
        }
    }
}
