//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct SingleRequest: Codable, Request {
    public let id: RequestID

    public init(id: RequestID) {
        self.id = id
    }

    public func canPerform(_ now: Date) -> Bool {
        return true
    }
}
