//
//  main.swift
//  scheduler-swift
//
//  Created by Rizadh Nizam on 2017-06-19.
//
//

import Foundation

let schedules = Schedule.getSchedules(for: CourseGenerator.generate(5))
let fiveCourseSchedules = schedules.filter({ $0.courses.count == 5 })

print("Total: \(schedules.count)")
print("Five-course: \(fiveCourseSchedules.count)")

for schedule in fiveCourseSchedules {
    print(schedule)
}
