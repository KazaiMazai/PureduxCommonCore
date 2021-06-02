
//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public protocol RepeatableRequest: Request {
    func nextAttempt(after: Date, makeUUID: () -> UUID) -> Self?
}
