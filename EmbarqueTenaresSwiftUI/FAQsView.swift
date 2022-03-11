//
//  FAQsView.swift
//  EmbarqueTenaresSwiftUI
//
//  Created by Elkin Garcia on 2/21/22.
//

import Foundation
import SwiftUI

struct Row: Identifiable {
    
    let id = UUID()
    
    let text: String
    
    var answer: [Row]?
    
}



struct FAQsView: View {
    
    let screenHeight = UIScreen.main.bounds.height
    
    let screenWidth = UIScreen.main.bounds.width
    
    // some example websites
    
    
    
    static let answerText = "Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response Response."
    
    
    
    static let answerItem = Row(text: answerText)
    
    
    
    static let question = "Question Question Question Question Question Question Question Question Question ?"
    
    
    
    // some example groups
    
    static let row1 = Row(text: question, answer: [answerItem])
    
    
    
    let questions: [Row] = [row1, row1, row1, row1, row1,row1, row1, row1, row1, row1,row1, row1, row1, row1, row1,row1, row1, row1, row1, row1,row1, row1, row1, row1, row1,]
    
    init() {
       UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        VStack{
            List(questions, children: \.answer) { row in
                Text(row.text)
            }
            .listStyle(.plain)
            Spacer()
        }
    }
}
