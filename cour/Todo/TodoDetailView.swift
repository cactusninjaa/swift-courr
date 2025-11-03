//
//  TodoDetailView.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI

struct TodoDetailView: View {
    let todo: Todo

    var body: some View {
        VStack(spacing: 16) {
            Text(todo.title)
                .font(.largeTitle)
                .bold()
            
            Text(todo.completed ? "Completed" : "Not Completed")
                .foregroundColor(todo.completed ? .green : .red)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
    }
}
