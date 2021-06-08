//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct ViewID<ID>: Codable, Hashable where ID: Codable & Hashable {
    private let rawValue: ID?

    static var stub: ViewID<ID> {
        ViewID<ID>(rawValue: nil)
    }

    private init(rawValue: ID?) {
        self.rawValue = rawValue
    }

    public init(rawValue: ID) {
        self.rawValue = rawValue
    }
}
