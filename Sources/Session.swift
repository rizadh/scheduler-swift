//
//  Session.swift
//  scheduler-ios
//
//  Created by Rizadh Nizam on 2017-06-14.
//  Copyright © 2017 Rizadh Nizam. All rights reserved.
//

import Foundation

enum Day: Int {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    func getText() -> String {
        switch (self) {
            case .Sunday: return "Sunday"
            case .Monday: return "Monday"
            case .Tuesday: return "Tuesday"
            case .Wednesday: return "Wednesday"
            case .Thursday: return "Thursday"
            case .Friday: return "Friday"
            case .Saturday: return "Saturday"
        }
    }
}

struct Session {
    let day: Day
    let location: Location
    let time: TimeRange
}

extension Session: Equatable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.day == rhs.day &&
        lhs.location == rhs.location &&
        lhs.time == rhs.time
    }
}

extension Session: Hashable {
    var hashValue: Int {
        return self.day.hashValue +
            self.location.building.hashValue +
            self.location.room.hashValue
    }
}

extension Session: Overlappable {
    static func overlap(lhs: Session, rhs: Session) -> Bool {
        return lhs.day == rhs.day &&
        lhs.time.overlaps(with: rhs.time)
    }
}
