//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import SwiftUI

struct MainScreen: View {
    @State private var viewModel = MainScreenViewModel()
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<CategoryEntity>

    var body: some View {
        List(categories) { category in
            CategoryView(category: category)
        }
    }
}

#Preview {
    MainScreen()
        .environment(
            \.managedObjectContext,
            WorkoutStore(forPreview: true).persistentContainer.viewContext
        )
}

struct CategoryView: View {
    @State var category: CategoryEntity
    var body: some View {
        DisclosureGroup(
            content: {
                if let workouts = category.workouts {
                    ForEach(Array(workouts as Set), id: \.self) { workout in
                        if let workout = workout as? WorkoutEntity {
                            WorkoutView(workout: workout)
                        }
                    }
                }
            },
            label: {
                VStack(alignment: .leading) {
                    Text(category.name ?? "")

                    if let lastCompleted = category.lastCompleted {
                        Text("Last Done: " + lastCompleted.formatted(date: .numeric, time: .omitted))
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        )
    }
}

struct WorkoutView: View {
    @State var workout: WorkoutEntity

    var body: some View {
        DisclosureGroup(
            content: {
                if let repetitions = workout.repetitions {
                    ForEach(Array(repetitions as Set), id: \.self) { repetition in
                        if let repetition = repetition as? RepetitionEntity {
                            ExtractedView(repetition: repetition)
                        }
                    }
                }
            },
            label: {
                Text(workout.name ?? "")
            }
        )
    }
}

struct ExtractedView: View {
    @State var repetition: RepetitionEntity

    var body: some View {
        Toggle(isOn: $repetition.done) {
            Stepper(value: $repetition.count) {
                HStack {
                    Text("\(repetition.count)")
                    Text(repetition.name ?? "")
                }
            }
        }
    }
}
