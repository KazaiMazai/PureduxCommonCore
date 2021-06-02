//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct DelayedJob {
    public private(set) var request: RequestState<DelayedRequest> = .none
    private let interval: TimeInterval

    public init(timeInterval: TimeInterval) {
        self.interval = timeInterval
    }
}

public extension DelayedJob {
    mutating func scheduleIfNeeded(now: Date, makeUUID: () -> UUID) {
        if request.isInProgress {
            return
        }

        request = .inProgress(
            DelayedRequest(
                id: RequestID(rawValue: makeUUID()),
                performAfter: now.addingTimeInterval(interval)))

    }

    mutating func setFinished() {
        request = .success
    }

    mutating func setFailed() {
        request = .failed
    }

    mutating func setCancelled() {
        request = .none
    }
}
