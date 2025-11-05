//
//  EntryCardView.swift
//  FeelingDiary
//
//  Created by Jia Shen on 11/3/25.
//

import SwiftUI

struct EntryCardView: View {
    let entry: Entry
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            //Card content
            VStack(alignment: .center, spacing: 0) {
                Text(entry.content)
                    .font(.system(size: 11, weight: .light, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(10)
                    .padding(8)
            }
            .frame(width: width, height: height, alignment: .topLeading)
            .background(Color.white)
            .cornerRadius(8)
            
            Text(entry.date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 11, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color.black)
                .cornerRadius(8)
                .offset(x: -6, y: -6)
        }
    }
}

#Preview {
    ZStack{
        Rectangle()
            .background(Color.blue)
        EntryCardView(entry:
            Entry(
                id: UUID(),
                content: "I'm remembering when I was 5 and my mom had my brother. I remember feeling invisible, like I didn't matter anymore. It's strange how these memories surface now that I'm pregnant.",
                date: Date().addingTimeInterval(-86400 * 2),
                tags: ["#childhood", "#mother", "#brother", "#pregnancy"]
            ), width: 200, height: 360)
    }
}
