//
//  Task.swift
//  Daily Todo
//
//  Created by iakalann on 22/02/2023.
//

import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var name: String
    var completed: Bool
}
