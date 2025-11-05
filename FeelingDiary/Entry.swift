//
//  Entry.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/3/25.
//

import Foundation

struct Entry: Identifiable, Hashable {
    let id: UUID
    var content: String
    var date: Date
    var tags: [String]
}

