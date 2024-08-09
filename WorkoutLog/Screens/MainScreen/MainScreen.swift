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
