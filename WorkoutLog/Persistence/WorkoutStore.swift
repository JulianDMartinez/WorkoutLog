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
        let bodySection1 = BodySectionEntity(context: moc)
        bodySection1.name = "Chest"
        bodySection1.lastCompleted = Date(timeIntervalSince1970: 1722813429)

        let bsec1Workout1 = WorkoutEntity(context: moc)
        bsec1Workout1.name = "Bench Press Normal"

        let bsec1Wor1Rep1 = RepetitionEntity(context: moc)
        bsec1Wor1Rep1.name = "2x45"

        bodySection1.workouts = [bsec1Workout1]
        bsec1Workout1.repetitions = [bsec1Wor1Rep1]

        let bodySection2 = BodySectionEntity(context: moc)
        bodySection2.name = "Legs"
        bodySection2.lastCompleted = Date(timeIntervalSince1970: 1722613300)

        let bsec2Workout1 = WorkoutEntity(context: moc)
        bsec2Workout1.name = "Leg Press"

        let bsec2Wor1Rep1 = RepetitionEntity(context: moc)
        bsec2Wor1Rep1.name = "5x45"

        bodySection2.workouts = [bsec2Workout1]
        bsec2Workout1.repetitions = [bsec2Wor1Rep1]

        try? moc.save()
    }
}
