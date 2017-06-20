//
//  Time.swift
//  scheduler-ios
//
//  Created by Rizadh Nizam on 2017-06-12.
//  Copyright © 2017 Rizadh Nizam. All rights reserved.
//

import Foundation

struct Time {
    let hour: Int
    let minute: Int

    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }

    init(fromMinutes: Int) {
        var minutes = fromMinutes
        
        var hours = 0

        while minutes >= 60 {
            hours += 1
            minutes -= 60
        }
        
        self.hour = hours
        self.minute = minutes
    }

    func toMinutes() -> Int {
        return 60 * self.hour + self.minute
    }
}

extension Time: Equatable {
    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.toMinutes() == rhs.toMinutes()
    }
}

extension Time: Comparable {
    static func < (lhs: Time, rhs: Time) -> Bool {
        return lhs.toMinutes() < rhs.toMinutes()
    }
}
