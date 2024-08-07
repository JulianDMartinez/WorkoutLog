//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import SwiftUI

struct MainScreen: View {
    @State private var viewModel = MainScreenViewModel()
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(
            keyPath: \CategoryEntity.lastCompleted,
            ascending: false
        ),
    ]) private var categories: FetchedResults<CategoryEntity>

    var body: some View {
        List(categories) { category in
            CategoryView(category: category)
        }
        .navigationTitle("Weight Lifting")
    }
}

#Preview {
    NavigationStack {
        MainScreen()
            .environment(
                \.managedObjectContext,
                WorkoutStore(forPreview: true).persistentContainer.viewContext
            )
    }
}

struct CategoryView: View {
    @State var category: CategoryEntity
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
                List(Array(category.workouts as! Set<WorkoutEntity>), id: \.self) { workout in
                    WorkoutView(workout: workout)
                }
        #else
            return
                List(Array(category.workouts as! Set<WorkoutEntity>), id: \.self) { workout in
                    WorkoutView(workout: workout)
                }
        #endif
    }

    private func getItemLabel() -> some View {
        return ToggleRowLabel(
            isDone: $category.isDone,
            title: category.name ?? "",
            subtitle: "Done " + (category.lastCompleted?.formatted(date: .numeric, time: .omitted) ?? "")
        )
    }
}

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
