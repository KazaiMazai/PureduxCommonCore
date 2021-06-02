//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct SomeError: Codable, Error {
    public let localizedDescription: String
    public var error: Error?

    private enum CodingKeys: String, CodingKey {
        case localizedDescription
    }

    public init(error: Error) {
        self.localizedDescription = error.localizedDescription
        self.error = error
    }
}
