//
//  WorkoutEntity+Ext.swift
//  WorkoutLog
//
//  Created by Julian Martinez on 8/6/24.
//

import Foundation

extension WorkoutEntity {
    var completedRepetitions: [RepetitionEntity] {
        let entities = self.value(forKey: "completedRepetitions") as? [RepetitionEntity]
        return entities ?? []
    }
}
