//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public protocol Request: Codable {
    var id: RequestID { get }

    func canPerform(_ now: Date) -> Bool
}
