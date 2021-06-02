//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public protocol EntityID: Hashable, Codable {

}

public protocol Entity: Codable {
    // swiftlint:disable type_name
    associatedtype ID: EntityID

    var id: ID { get }
}

public struct Entities<T>: Codable where T: Entity {
    private var storage: [T.ID: T] = [:]
    private var timestamps: [T.ID: Date] = [:]

    public func all() -> [T] {
        return storage.map { $0.value }
    }

    public func findById(_ id: T.ID) -> T? {
        return storage[id]
    }

    public func findAllById(_ ids: [T.ID]) -> [T] {
        return ids
            .map { storage[$0] }
            .compactMap { $0 }
    }

    public func find(where predicate: (T) -> Bool) -> [T] {
        let items = storage.values.filter(predicate)
        return items
    }

    public mutating func removeById(_ id: T.ID) {
        storage.removeValue(forKey: id)
        timestamps.removeValue(forKey: id)
    }

    public mutating func removeAllById(_ ids: [T.ID]) {
        ids.forEach { storage.removeValue(forKey: $0) }
    }

    public mutating func removeAll(before timestamp: Date) {
        let deleteIds = timestamps
            .filter { $0.value < timestamp }
            .map { $0.key }

        removeAllById(deleteIds)
    }

    public mutating func save(_ item: T,
                              with updating: Merging<T, T> = .replace(),
                              timestamp: Date) {

        let updatedItem = storage[item.id].map { existing in
            updating.merge(existing, item)
        }
        storage[item.id] = updatedItem ?? item
        timestamps[item.id] = timestamp
    }

    public mutating func saveAll(_ items: [T],
                                 with updating: Merging<T, T> = .replace(),
                                 timestamp: Date) {

        items.forEach { save($0, with: updating, timestamp: timestamp) }
    }
}
