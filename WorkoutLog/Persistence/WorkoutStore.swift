//
//  WorkoutStore.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import CoreData

class WorkoutStore {
    let persistentContainer = NSPersistentContainer(name: "WorkoutStore")

    init(forPreview: Bool = false) {
        if forPreview {
            guard let description = persistentContainer.persistentStoreDescriptions.first else {
                print(
                    "\(#file) | \(#function) | Unable to get first persistent store description to set preview container."
                )
                return
            }
            description.url = URL(filePath: "/dev/null")
        }

        persistentContainer.loadPersistentStores { _, _ in }

        if forPreview {
            addMockData(moc: persistentContainer.viewContext)
        }
    }
}

extension WorkoutStore {
    func addMockData(moc: NSManagedObjectContext) {
        let category1 = CategoryEntity(context: moc)
        category1.name = "Chest"
        category1.lastCompleted = Date(timeIntervalSince1970: 1722813429)

        let cat1Workout1 = WorkoutEntity(context: moc)
        cat1Workout1.name = "Bench Press Normal"

        let cat1Wor1Rep1 = RepetitionEntity(context: moc)
        cat1Wor1Rep1.name = "2x45"

        category1.workouts = [cat1Workout1]
        cat1Workout1.repetitions = [cat1Wor1Rep1]

        let category2 = CategoryEntity(context: moc)
        category2.name = "Legs"
        category2.lastCompleted = Date(timeIntervalSince1970: 1722613300)

        let cat2Workout1 = WorkoutEntity(context: moc)
        cat2Workout1.name = "Leg Press"

        let cat2Wor1Rep1 = RepetitionEntity(context: moc)
        cat2Wor1Rep1.name = "5x45"

        category2.workouts = [cat2Workout1]
        cat2Workout1.repetitions = [cat2Wor1Rep1]

        try? moc.save()
    }
}
