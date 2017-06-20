//
//  Schedule.swift
//  scheduler-ios
//
//  Created by Rizadh Nizam on 2017-06-18.
//  Copyright © 2017 Rizadh Nizam. All rights reserved.
//

import Foundation

struct Schedule {
    private(set) var courses = [Course: Section]()

    static func getSchedules(for courses: [Course]) -> [Schedule] {
        var schedules = [Schedule()]

        for course in courses {
            schedules = schedules.map() {
                Array($0.generateSchedules(adding: course))
            }.flatMap() { $0 }
        }

        return schedules
    }

    private func generateSchedules(adding course: Course) -> Set<Schedule> {
        var schedules: Set = [self]

        for section in course.sections {
            var newCombination = self
            newCombination.add(section, from: course)
            if newCombination.isValid {
                schedules.insert(newCombination)
            }
        }

        return schedules
    }

    private mutating func add(_ section: Section, from course: Course) {
        guard course.sections.contains(section) else {
            fatalError("Section does not belong in course")
        }

        courses.updateValue(section, forKey: course)
    }

    var isValid: Bool {
        for outerSection in courses.values {
            for innerSection in courses.values {
                if outerSection.overlaps(with: innerSection) {
                    return outerSection == innerSection || false
                }
            }
        }

        return true
    }

    var timeGaps: [Day: Int] {
        var gaps = [Day: Int]()

        for (_, section) in courses {
            let orderedSessions = Array(section.sessions).sorted(by: {
                if $0.day.rawValue < $1.day.rawValue {
                    return true
                }

                if ($0.day.rawValue == $1.day.rawValue) && ($0.time.start < $1.time.start) {
                    return true
                }

                return false
            })

            var currentDay: Day?
            var lastTime: Time?

            for session in orderedSessions {
                defer {
                    lastTime = session.time.end
                    currentDay = session.day
                }

                guard currentDay == session.day else {
                    continue
                }

                guard let lastTime = lastTime else {
                    fatalError("Last time was not set.")
                }

                let gap = session.time.start.toMinutes() - lastTime.toMinutes()

                if gap > 0 {
                    gaps.updateValue(gaps[currentDay!] ?? 0 + gap, forKey: currentDay!)
                }
            }
        }

        return gaps
    }
}

extension Schedule: CustomStringConvertible {
    var description: String {
        var descString = ""

        descString += "Gap: \(timeGaps)"
        for (course, section) in courses {
            descString += "\n\(course.code) -> \(section.identifier)"
        }

        return descString
    }
}

extension Schedule: Equatable {
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.courses == rhs.courses
    }
}

extension Schedule: Hashable {
    var hashValue: Int {
        var concatString = ""

        for (course, section) in courses {
            concatString += course.code + section.identifier
        }

        courses.keys.sorted(by: { $0.code < $1.code }).forEach({ course in
            concatString += course.code
            course.sections.sorted(by: { $0.identifier < $1.identifier }).forEach { section in
                concatString += section.identifier
            }
        })

        return concatString.hashValue
    }
}
