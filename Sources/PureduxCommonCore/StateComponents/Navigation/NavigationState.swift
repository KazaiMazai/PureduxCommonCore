//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct NavigationState<ID, Tags>: Codable
    where
    ID: Codable & Hashable,
    Tags: Codable & Hashable & CaseIterable {

    private var statesBySource: [ViewID<ID>: [Tags: PresentationState<ID, Tags>]]
    private var statesByDestination: [ViewID<ID>: PresentationState<ID, Tags>]
}

public extension NavigationState {
    func isPresented(for source: ViewID<ID>, tag: Tags) -> Bool {
        statesBySource[source]?[tag]?.isPresented ?? false
    }

    func destinationId(for source: ViewID<ID>, tag: Tags) -> ViewID<ID> {
        statesBySource[source]?[tag]?.destination ?? .stub
    }
}

public extension NavigationState {
    init() {
        statesBySource = [:]
        statesByDestination = [:]
    }

    init(for source: ViewID<ID>, makeId: () -> ID) {
        statesBySource = [:]
        statesByDestination = [:]

        let states = Tags.allCases.map {
            PresentationState<ID, Tags>(
                source: source,
                destination: ViewID(rawValue: makeId()),
                tag: $0,
                isPresented: false)
        }

        states.forEach { statesByDestination[$0.destination] = $0}
        statesBySource[source] = Dictionary(uniqueKeysWithValues: states.map { ($0.tag, $0) })
    }
}

public extension NavigationState {
    mutating func setPresenation(destination: ViewID<ID>, isPresented: Bool) {
        guard var state = statesByDestination[destination] else {
            return
        }

        state.isPresented = isPresented
        statesByDestination[destination] = state
        var statesByTag = statesBySource[state.source] ?? [:]
        statesByTag[state.tag] = state
        statesBySource[state.source] = statesByTag
    }

    mutating func setPresenation(source: ViewID<ID>, tag: Tags, isPresented: Bool) {
        guard var state = statesBySource[source]?[tag] else {
            return
        }

        state.isPresented = isPresented
        var statesByTag = statesBySource[state.source] ?? [:]
        statesByTag[state.tag] = state
        statesBySource[state.source] = statesByTag
    }
}
