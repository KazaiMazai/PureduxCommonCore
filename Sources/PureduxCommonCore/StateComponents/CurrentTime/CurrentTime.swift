//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct CurrentTime: Codable {
    public private(set) var time: Date
    public let interval: Double

    public init(time: Date, interval: Double, initialRequestId: UUID) {
        self.time = time
        self.interval = interval
        self.request = .inProgress(
            SingleRequest(id: RequestID(rawValue: initialRequestId)))
    }

    public private(set) var request: RequestState<SingleRequest>

    mutating func handleTimeChanged(_ now: Date, nextRequestId: UUID) {
        time = now
        request = .inProgress(SingleRequest(id: RequestID(rawValue: nextRequestId)))
    }
}
