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
