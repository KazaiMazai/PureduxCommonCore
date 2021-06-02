//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct PresentationState<ID, Tag>: Codable
    where
    ID: Codable & Hashable,
    Tag: Codable {

    public let source: ViewID<ID>
    public let destination: ViewID<ID>
    public let tag: Tag
    public var isPresented: Bool
}
