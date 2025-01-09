//
//  Difficulty.swift
//  A4
//
//  Created by Archita Nemalikanti on 11/20/24.
//

import Foundation
import UIKit

struct Difficulty{
    let diff: String
}

extension Difficulty{
    static let diff = [
        Difficulty(diff: "All"),
        Difficulty(diff: "Beginner"),
        Difficulty(diff: "Intermediate"),
        Difficulty(diff: "Advanced")
    ]
}
