//
//  WorkoutLogApp.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import SwiftUI

@main
struct WorkoutLogApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainScreen(
                    viewModel: MainScreenViewModel(
                        moc: WorkoutStore().persistentContainer.viewContext
                    )
                )
            }
        }
    }
}
