//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 29.05.2021.
//

import Foundation

public struct Merging<Existing, New> {
    let merge: (Existing, New) -> Existing

    public init(merge: @escaping (Existing, New) -> Existing) {
        self.merge = merge
    }

}

extension Merging {
    public static var replace: Merging<Existing, Existing> {
        Merging<Existing, Existing>(merge: { _, new in new })
    }
}
