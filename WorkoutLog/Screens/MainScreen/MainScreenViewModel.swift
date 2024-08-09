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
    var categories: [CategoryEntity] = []
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
