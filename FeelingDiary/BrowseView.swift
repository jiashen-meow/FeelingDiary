//
//  BrowseView.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/3/25.
//

import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel = EntriesViewModel()
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var showDateFilter = false
    @State private var showTagFilter = false
    @State private var selectedEntry: Entry? = nil
    @State private var showNewEntry = false
    @State private var showAIOptions = false
    

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack (spacing: 0) {
                        topBar
                        filterRow
                        content(geometry: geometry)
                    }
                    floatingButtons
                }
                .background(.ultraThinMaterial)
                .background(Color(hex: "#FAFAFA"))
                .navigationDestination(item: $selectedEntry) { entry in
                    EntryDetailView(entry: entry)
                        .environmentObject(viewModel)
                }
                .navigationDestination(isPresented: $showNewEntry) {
                    EntryDetailView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
    
    @ViewBuilder
    var topBar: some View {
        if isSearching {
            // Search Bar
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    TextField("search", text: $searchText)
                }
                .font(.system(size: 20))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .glassEffect()
                
                // Exit Search Button
                Button(action: {
                    isSearching = false
                    searchText = ""
                }) {
                    Image(systemName: "xmark")
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .glassEffect()
                }
            }
            .padding(.horizontal, 16)
//            .background(Color.green)
        } else {
            // Title Bar
            HStack {
                Spacer()
                Text("Browse")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button(action: {
                    isSearching = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .glassEffect()
                }
                .padding(.trailing, 16)
            }
            .padding(.bottom, 8)
//            .background(Color.green)
        }
    }
    
    @ViewBuilder
    var filterRow: some View {
        if isSearching {
            HStack(spacing: 12) {
                Button(action: {
                    showDateFilter.toggle()
                }) {
                    HStack {
                        Spacer()
                        Text("Date")
                            .font(.system(size: 15, weight: .thin))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    showTagFilter.toggle()
                }) {
                    HStack {
                        Spacer()
                        Text("Tag")
                            .font(.system(size: 15, weight: .thin))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
//            .background(Color.yellow)
//            .background(Color(hex: "#F5F5F5"))
        }
    }
    
    func content(geometry: GeometryProxy) -> some View {
        let cardWidth = (geometry.size.width - 48) / 3
        let cardHeight = cardWidth * 1.4
        
        let columns = [
            GridItem(.fixed(cardWidth), spacing: 6),
            GridItem(.fixed(cardWidth), spacing: 6),
            GridItem(.fixed(cardWidth), spacing: 6)
        ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(viewModel.allEntries) { entry in
                    EntryCardView(entry: entry, width: cardWidth, height: cardHeight)
                        .onTapGesture {
                            selectedEntry = entry
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteEntry(entry)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
//                        .background(.red)
                }
            }
//            .background(.orange)
            .padding(0)
        }
//        .background(.blue)
    }
    
    @ViewBuilder
    var floatingButtons: some View {
        VStack(spacing: 16) {
            Spacer()
            HStack {
                Spacer()
                if !showAIOptions {
                    firstTierButtons
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                } else {
                    AIInsightButtons
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                }
            }
        }
    }
    
    var firstTierButtons: some View {
        VStack(spacing: 16) {
            // AI Insights Button
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    showAIOptions.toggle()
                }
            }) {
                Image(systemName: "sparkles")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            
            // Export Button
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            
            // Add Button
            Button(action: {
                showNewEntry = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
    }
    
    var AIInsightButtons: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Button(action: {
                showAIOptions.toggle()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.primary)
                    .frame(width: 56, height: 56)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            
            Button(action: {}) {
                Text("Summarize journals")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(22)
                    .shadow(radius: 4)
            }
            
            Button(action: {}) {
                Text("Generate talking points")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(22)
                    .shadow(radius: 4)
            }
            
            Button(action: {}) {
                Text("Recognize Pattern")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(22)
                    .shadow(radius: 4)
            }
        }
    }
}

#Preview {
    BrowseView()
}
