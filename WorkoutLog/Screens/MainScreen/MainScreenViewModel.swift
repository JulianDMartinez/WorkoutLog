//
//  MainScreenViewModel.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/5/24.
//

import Foundation
import CoreData

@Observable
class MainScreenViewModel {
    let moc: NSManagedObjectContext
    var bodySections: [BodySectionEntity] = []
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func fetch() {
        let request = BodySectionEntity.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BodySectionEntity.lastCompleted, ascending: true)]
        
        if let bodySections = try? moc.fetch(request) {
            self.bodySections = bodySections
        }
    }
}
