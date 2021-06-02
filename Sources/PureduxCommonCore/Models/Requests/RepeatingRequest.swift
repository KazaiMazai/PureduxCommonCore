//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct RepeatingRequest: Codable {
    public let id: RequestID

    private let attempt: Int
    private let maxAttemptCount: Int
    private let performAfter: Date

    public init(id: RequestID,
                attempt: Int = 0,
                maxAttemptCount: Int = 10,
                performAfter: Date = .distantPast) {
        self.id = id
        self.attempt = attempt
        self.maxAttemptCount = maxAttemptCount
        self.performAfter = performAfter
    }
}

extension RepeatingRequest: RepeatableRequest {
    public func canPerform(_ now: Date) -> Bool {
        return performAfter <= now
    }

    public func nextAttempt(after now: Date, makeUUID: () -> UUID) -> RepeatingRequest? {
        guard hasMoreAttempts else {
            return nil
        }

        let newAttempt = attempt + 1
        let delayInterval: Double = pow(2.0, Double(attempt))
        let performAfterDate = now.addingTimeInterval(delayInterval)

        return RepeatingRequest(
            id: RequestID(rawValue: makeUUID()),
            attempt: newAttempt,
            maxAttemptCount: maxAttemptCount,
            performAfter: performAfterDate)
    }
}

extension RepeatingRequest {
    private var hasMoreAttempts: Bool {
        attempt < (maxAttemptCount - 1)
    }
}
