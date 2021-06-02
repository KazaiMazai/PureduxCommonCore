//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct DelayedRequest: Request {
    public let id: RequestID
    public let performAfter: Date

    public init(id: RequestID,
                performAfter: Date = .distantFuture) {
        self.id = id
        self.performAfter = performAfter
    }

    public func canPerform(_ now: Date) -> Bool {
        return now >= performAfter
    }
}
