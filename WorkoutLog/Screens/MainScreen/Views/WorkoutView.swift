//
//  WorkoutView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/9/24.
//

import SwiftUI

struct WorkoutView: View {
    @State var workout: WorkoutEntity

    var body: some View {
        #if os(watchOS)
            NavigationLink {
                getItemContent()
                    .navigationTitle(workout.name ?? "")
            } label: {
                getItemLabel()
            }
        #else
            DisclosureGroup {
                getItemContent()
            } label: {
                getItemLabel()
            }
        #endif
    }

    private func getItemContent() -> some View {
        #if os(watchOS)
            return List(Array(workout.repetitions as! Set<RepetitionEntity>), id: \.self) { repetition in
                RepetitionView(repetition: repetition)
            }
        #else
            return ForEach(Array(workout.repetitions as! Set<RepetitionEntity>), id: \.self) { repetition in
                RepetitionView(repetition: repetition)
            }
        #endif
    }

    private func getItemLabel() -> some View {
        let predicate = NSPredicate(format: "isDone == %@", true as NSNumber)
        let filteredRepetitions = workout.repetitions?.filtered(using: predicate)
        return HStack {
            VStack(alignment: .leading) {
                Text(workout.name ?? "")

                Text("\(filteredRepetitions?.count ?? 0) / \(workout.repetitions?.count ?? 0) Done")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            #if os(watchOS)
                Image(systemName: "chevron.right")
            #endif
        }
        .navigationTitle(workout.category?.name ?? "")
    }
}
