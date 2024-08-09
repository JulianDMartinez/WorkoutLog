//
//  BodySectionView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/9/24.
//

import SwiftUI

struct BodySectionView: View {
    @State var bodySection: BodySectionEntity
    @State var testBool = false

    var body: some View {
        #if os(watchOS)
            NavigationLink {
                getItemContent()
            } label: {
                getItemLabel()
            }
            .padding(.leading, -8)
        #else
            NavigationLink {
                getItemContent()
                    .listStyle(.plain)
            } label: {
                getItemLabel()
            }
            .padding(.leading, -8)
        #endif
    }

    private func getItemContent() -> some View {
        #if os(watchOS)
            return
                List(Array(bodySection.workouts as! Set<WorkoutEntity>), id: \.self) { workout in
                    WorkoutView(workout: workout)
                }
        #else
            return
                List(Array(bodySection.workouts as! Set<WorkoutEntity>), id: \.self) { workout in
                    WorkoutView(workout: workout)
                }
        #endif
    }

    private func getItemLabel() -> some View {
        return ToggleRowLabel(
            isDone: $bodySection.isDone,
            title: bodySection.name ?? "",
            subtitle: "Done " + (bodySection.lastCompleted?.formatted(date: .numeric, time: .omitted) ?? "")
        )
    }
}
