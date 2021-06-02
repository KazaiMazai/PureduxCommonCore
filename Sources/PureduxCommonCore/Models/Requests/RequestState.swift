//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public enum RequestState<RequestModel: Request> {
    case none
    case inProgress(RequestModel)
    case success
    case failed
}

public extension RequestState {
    var isInProgress: Bool {
        guard case .inProgress = self else {
            return false
        }

        return true
    }

    var isSuccess: Bool {
        guard case .success = self else {
            return false
        }

        return true
    }

    var isFailed: Bool {
        guard case .failed = self else {
            return false
        }

        return true
    }

    var isNone: Bool {
        guard case .none = self else {
            return false
        }

        return true
    }
}

extension RequestState: Codable {
    enum CodingKeys: CodingKey {
        case none
        case inProgress
        case success
        case failed
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .none:
            try container.encode(true, forKey: .none)
        case .inProgress(let state):
            try container.encode(state, forKey: .inProgress)
        case .success:
            try container.encode(true, forKey: .success)
        case .failed:
            try container.encode(true, forKey: .failed)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: container.codingPath,
                                       debugDescription: "Unabled to decode enum.")
            )
        }

        switch key {
        case .none:
            self = .none
        case .inProgress:
            let state = try container.decode(RequestModel.self, forKey: .inProgress)
            self = .inProgress(state)
        case .success:
            self = .success
        case .failed:
            self = .failed
        }
    }
}
