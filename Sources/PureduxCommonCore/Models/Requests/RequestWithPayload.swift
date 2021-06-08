//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct RequestWithPayload<RequestModel, Payload>: Codable
    where
    Payload: Codable,
    RequestModel: Request {

    public let payload: Payload
    public let request: RequestModel

    public init(payload: Payload, state: RequestModel) {
        self.payload = payload
        self.request = state
    }
}

extension RequestWithPayload: RepeatableRequest where RequestModel: RepeatableRequest {
    public func nextAttempt(after: Date, makeUUID: () -> UUID) -> RequestWithPayload? {
        guard let next = request.nextAttempt(after: after, makeUUID: makeUUID) else {
            return nil
        }

        return RequestWithPayload(payload: payload, state: next)
    }
}

extension RequestWithPayload: Request {
    public var id: RequestID {
        request.id
    }

    public func canPerform(_ now: Date) -> Bool {
        return request.canPerform(now)
    }
}
