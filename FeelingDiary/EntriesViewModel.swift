//
//  EntriesViewModel.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/3/25.
//

import SwiftUI
internal import Combine

class EntriesViewModel: ObservableObject {
    @Published var allEntries: [Entry] = []
//    @Published var filteredEntries: [Entry] = []
    
    // Filter state
    @Published var selectedTags: [String] = []
    @Published var dateRange: (start: Date?, end: Date?) = (nil, nil)
    @Published var searchText: String = ""
    
    private let dataManager = DataManager.shared
    
    init() {
        loadEntries()
    }
    
    // MARK: - Load Entries
    
    func loadEntries() {
        allEntries = dataManager.loadEntries()
        
        // If no entries exist, load sample data
        if allEntries.isEmpty {
            loadSampleData()
        }
    }
    
    // MARK: - Add Entry
    
    func addEntry(_ entry: Entry) {
        dataManager.addEntry(entry, to: &allEntries)
    }
    
    // MARK: - Update Entry
    
    func updateEntry(_ entry: Entry) {
        dataManager.updateEntry(entry, in: &allEntries)
    }
    
    // MARK: - Delete Entry
    
    func deleteEntry(_ entry: Entry) {
        dataManager.deleteEntry(entry, from: &allEntries)
    }
    
    // MARK: - Sample Data (for first launch)
    
    private func loadSampleData() {
        allEntries = [
            Entry(
                id: UUID(),
                content:
                    """
                    Not a very productive day for me today. I felt torn between multiple things and restless but tired at the same time. That combination is so uncomfortable - like I can't settle into anything but I also don't have the energy to really push through.
                    I need to buy things for the baby and I've been doing research for an app I want to build. The shopping was okay but it takes so much energy to compare prices and products' functionality and their reviews. And for the app, what I had in mind just isn't coming to a solid shape. I felt there is already so much competition out there. I don't know if I will succeed and with all the time invested, I'm so unsure.
                    But I need this to happen - the creative projects. It feels like my livelihood. I'm out of a job because of a trend shift in my industry. There aren't appealing job opportunities out there. And since I'm in my early 30s, married and pregnant, companies I've talked to usually avoid people like me. I tried pretty hard to find a job for a year and the offers just aren't that appealing.
                    I wanted to go out there and create something. It defines me. With the baby coming, I feel I need to prove myself - not only to myself, but to my family and friends that I still got it. That I'm still capable. That I'm still me.
                    I'm also afraid that people around me will assume I need to take more responsibilities with the baby since I'm currently out of work. Like because I don't have a job, I should automatically be the primary caregiver. There's more to unpack there.
                    I feel like people look down on me. They don't care about me. They don't respect me. I want to prove myself so badly. But the harder I try to prove myself, the more strained I feel. I lose my cool. I lose my chill to be creative. It's like the pressure is killing the very thing I'm trying to prove I still have. I felt this has something to do with   #self-worth  ? or does it?
                    I don't know what I want for myself anymore. And how do I say no to having people stand over my shoulders? How do I get them to back off when they're probably just trying to help or be supportive? I don't even know.
                    """,
                date: Date().addingTimeInterval(-86400 * 0), // Today
                tags: ["#pregnancy", "#tired"]
            ),
            Entry(
                id: UUID(),
                content: "Had dinner with #A today. She made comments about my cooking again.",
                date: Date().addingTimeInterval(-86400 * 1), // Yesterday
                tags: ["#A", "#cooking", "#criticism"]
            ),
            Entry(
                id: UUID(),
                content: "I'm remembering when I was 5 and my mom had my brother. I remember feeling invisible, like I didn't matter anymore. It's strange how these memories surface now that I'm pregnant.",
                date: Date().addingTimeInterval(-86400 * 2),
                tags: ["#childhood", "#mother", "#brother", "#pregnancy"]
            ),
            Entry(
                id: UUID(),
                content: "Good session today.",
                date: Date().addingTimeInterval(-86400 * 3),
                tags: ["#therapy"]
            ),
            Entry(
                id: UUID(),
                content: "Another day of waiting for my partner to come home. He works such long hours and I feel so isolated during the day. I know he's working hard for us, but I'm exhausted too. Sometimes I wonder if he sees that.",
                date: Date().addingTimeInterval(-86400 * 4),
                tags: ["#partner", "#waiting", "#pregnancy", "#isolation"]
            ),
            Entry(
                id: UUID(),
                content: "Started researching the app idea today. Feeling excited but also scared. What if it fails? What if nobody wants it? But also - what if it works? I need this to work. I need to prove I can still create something meaningful.",
                date: Date().addingTimeInterval(-86400 * 5),
                tags: ["#app", "#selfdoubt", "#creative", "#proving"]
            ),
            Entry(
                id: UUID(),
                content: "Awful.",
                date: Date().addingTimeInterval(-86400 * 6),
                tags: ["#bad"]
            ),
            Entry(
                id: UUID(),
                content: "Family dinner with #A again. She asked when we were 'finally settling down' with such a pointed look. My partner didn't say anything. I felt so small.",
                date: Date().addingTimeInterval(-86400 * 7),
                tags: ["#A", "#familydinner", "#judgment", "#partner"]
            ),
            Entry(
                id: UUID(),
                content: "I have a vision for myself in 10 years. She has steady income. She has her own projects. She's not restricted by location. She can support her parents better. She has free time for hobbies and meets friends through those hobbies. That vision is about freedom, creativity, connection, autonomy.",
                date: Date().addingTimeInterval(-86400 * 8),
                tags: ["#10yearvision", "#future", "#identity"]
            ),
            Entry(
                id: UUID(),
                content: "Why am I like this?",
                date: Date().addingTimeInterval(-86400 * 9),
                tags: ["#selfdoubt"]
            ),
            Entry(
                id: UUID(),
                content: "Postpartum care center is all booked. Professional caregiver arranged. Parents will rotate. My partner is looking for a less demanding job. Everything is planned. So why do I still feel like I'm drowning? The logistics aren't the problem. It's me. It's this feeling that I've lost myself.",
                date: Date().addingTimeInterval(-86400 * 10),
                tags: ["#pregnancy", "#planning", "#identity", "#lost"]
            ),
            Entry(
                id: UUID(),
                content: "Tired.",
                date: Date().addingTimeInterval(-86400 * 11),
                tags: ["#tired"]
            )
        ]
        
        // Save sample data
        dataManager.saveEntries(allEntries)
    }
}
