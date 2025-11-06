//
//  DataManager.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/6/25.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let fileName = "entries.json"
    
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    private init() {}
    
    // MARK: - Load Entries
    
    func loadEntries() -> [Entry] {
        // Check if file exists
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("No saved entries found, returning empty array")
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let entries = try decoder.decode([Entry].self, from: data)
            print("Sucessfully loaded \(entries.count) entries")
            return entries
        } catch {
            print("Error loading entries: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Save Entries
    
    func saveEntries(_ entries: [Entry]) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(entries)
            try data.write(to: fileURL, options: .atomic)
            print("Successfully saved \(entries.count) entries")
        } catch {
            print("Error saving entries: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Add Entry
    
    func addEntry(_ entry: Entry, to entries: inout [Entry]) {
        entries.insert(entry, at: 0)
        saveEntries(entries)
    }
    
    // MARK: - Update Entry
    
    func updateEntry(_ updatedEntry: Entry, in entries: inout [Entry]) {
        if let index = entries.firstIndex(where: { $0.id == updatedEntry.id }) {
            entries[index] = updatedEntry
            saveEntries(entries)
        }
    }
    
    // MARK: - Delete Entry
    
    func deleteEntry(_ entry: Entry, from entries: inout[Entry]) {
        entries.removeAll { $0.id == entry.id }
        saveEntries(entries)
    }
    
    // MARK: - Clear All Data (for testing)
    
    func clearAllData() {
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
                print("All data cleared")
            }
        } catch {
            print("Error clearing data: \(error.localizedDescription)")
        }
    }
}
