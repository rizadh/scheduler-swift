//
//  TimeRange.swift
//  scheduler-ios
//
//  Created by Rizadh Nizam on 2017-06-13.
//  Copyright © 2017 Rizadh Nizam. All rights reserved.
//

import Foundation

struct TimeRange {
    let start: Time
    let end: Time

    init(from start: Time, to end: Time) {
        self.start = start
        self.end = end
    }
}

extension TimeRange: Equatable {
    static func == (lhs: TimeRange, rhs: TimeRange) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

extension TimeRange: Overlappable {
    static func overlap(lhs: TimeRange, rhs: TimeRange) -> Bool {
        return (lhs.start < rhs.start) != (lhs.end < rhs.end)
    }
}
