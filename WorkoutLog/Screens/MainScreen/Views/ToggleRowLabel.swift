//
//  ToggleRowLabel.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/9/24.
//

import SwiftUI

struct ToggleRowLabel: View {
    @Binding var isDone: Bool
    let title: String
    let subtitle: String?

    var body: some View {
        HStack(spacing: 0) {
            Toggle(isOn: $isDone, label: {
                Text(
                    Image(systemName: isDone ? "checkmark.circle" : "circle")
                )
                .font(.title2)
            })
            .toggleStyle(.button)
            .buttonStyle(.plain)
            .frame(width: 44, height: 44)

            VStack(alignment: .leading) {
                Text(title)

                if let subtitle {
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            #if os(watchOS)
                Image(systemName: "chevron.right")
            #endif
        }
    }
}
