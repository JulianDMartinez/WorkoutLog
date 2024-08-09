//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import SwiftUI

struct MainScreen: View {
    @State var viewModel: MainScreenViewModel

    var body: some View {
        List(viewModel.categories) { category in
            CategoryView(category: category)
        }
        .navigationTitle("Weight Lifting")
    }
}

#Preview {
    NavigationStack {
        MainScreen(
            viewModel: MainScreenViewModel(
                moc: WorkoutStore(forPreview: true).persistentContainer.viewContext
            )
        )
    }
}
