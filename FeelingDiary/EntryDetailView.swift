//
//  EntryDetailView.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/4/25.
//

import SwiftUI

struct EntryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EntriesViewModel
    
    @State private var text: String
    @State private var date: Date
    @FocusState private var isTextFieldFocused: Bool
    
    let entry: Entry?
    private let isNewEntry: Bool
    
    init(entry: Entry? = nil) {
        self.entry = entry
        self.isNewEntry = (entry == nil)
        
        _text = State(initialValue: entry?.content ?? "")
        _date = State(initialValue: entry?.date ?? Date())
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                // Text Editor
                TextEditor(text: $text)
                    .font(.system(size: 16, weight: .light, design: .rounded))
                    .lineSpacing(24 - 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, isTextFieldFocused ? 60 : 0)
                    .focused($isTextFieldFocused)
                    .scrollContentBackground(.hidden)
                    .background(Color(hex: "#FAFAFA"))
            }
            
            if isTextFieldFocused {
                VStack {
                    Spacer()
                    toolbar
                }
            }
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#FAFAFA"),
                    Color(hex: "#FAFAFA").opacity(0.8),
                    Color(hex: "#FAFAFA").opacity(0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 125)
            .edgesIgnoringSafeArea(.top)
            
            Button(action: {
                saveEntry()
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.primary)
                    .frame(width: 45, height: 45)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding(.leading, 20)
        }
        .background(Color(hex: "#FAFAFA"))
        .navigationBarHidden(true)
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    var toolbar: some View {
        HStack(spacing: 20) {
            HStack(spacing: 24) {
                Button(action: {}) {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.primary)
                }
                
                Button(action: {}) {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.primary)
                }
                
                Button(action: {}) {
                    Image(systemName: "number")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.primary)
                }
                
                Button(action: {}) {
                    Image(systemName: "sparkle.magnifyingglass")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .glassEffect()

            
            Spacer()
            
            Button(action: {
                saveEntry()
                dismiss()
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.primary)
            }
            .frame(width: 45.0, height: 45.0)
            .glassEffect()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    // MARK: - Save Entry
     
    private func saveEntry() {
        //Don't save if content is empty
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        if isNewEntry {
            // Create new entry
            let newEntry = Entry(
                id: UUID(),
                content: text,
                date: date
            )
            viewModel.addEntry(newEntry)
        } else if let existingEntry = entry {
            // Update existing entry
            let updatedEntry = Entry(
                id: existingEntry.id,
                content: text,
                date: date
            )
            viewModel.updateEntry(updatedEntry)
        }
    }
}

#Preview {
    EntryDetailView(entry:
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
            date: Date().addingTimeInterval(-86400 * 2),
            tags: ["#childhood", "#mother", "#brother", "#pregnancy"]
        ))
}
