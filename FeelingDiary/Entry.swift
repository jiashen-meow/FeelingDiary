//
//  Entry.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/3/25.
//

import Foundation

struct Entry: Identifiable, Hashable, Codable {
    let id: UUID
    var content: String
    var date: Date
    var tags: [String]
    
    init(id: UUID = UUID(), content: String = "", date: Date = Date(), tags: [String] = []) {
        self.id = id
        self.content = content
        self.date = date
        self.tags = tags
    }
}

