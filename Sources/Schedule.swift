//
//  Schedule.swift
//  scheduler-ios
//
//  Created by Rizadh Nizam on 2017-06-18.
//  Copyright © 2017 Rizadh Nizam. All rights reserved.
//

import Foundation

struct Schedule {
    var combinations = [Course: Section]()

    func generateSchedules(adding course: Course) -> Set<Schedule> {
        var schedules: Set = [self]

        for section in course.sections {
            var newCombination = self
            newCombination.add(section, from: course)
            schedules.insert(newCombination)
        }

        return schedules
    }

    private mutating func add(_ section: Section, from course: Course) {
        guard course.sections.contains(section) else {
            fatalError("Section does not belong in course")
        }

        self.combinations.updateValue(section, forKey: course)
    }

    func isValid() -> Bool {
        for outerSection in combinations.values {
            for innerSection in combinations.values {
                if outerSection.overlaps(with: innerSection) {
                    return false
                }
            }
        }

        return true
    }
}

extension Schedule: Equatable {
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.combinations == rhs.combinations
    }
}

extension Schedule: Hashable {
    var hashValue: Int {
        var hashSum = 0

        for course in combinations.keys {
            hashSum += course.hashValue
        }

        return hashSum
    }
}
