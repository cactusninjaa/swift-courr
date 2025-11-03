//
//  exo1.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//
import SwiftUI

struct TodoView: View {
    @State var todoViewModel = TodoViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                if !todoViewModel.todos.isEmpty {
                    VStack(spacing: 8) {
                        ForEach(todoViewModel.todos) {todo in
                            NavigationLink(destination: TodoDetailView(todo: todo)) { Text(todo.title)
                                    .padding()
                            }
                            Divider()
                        }
                    }
                } else {
                    Text("Loading")
                }
                Spacer()
            }
            .task {
                await todoViewModel.fetchTodos()
            }
        }
    }
}

#Preview {
    TodoView()
}
