//
//  TodoViewModel.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI

@Observable
class TodoViewModel {
    var todos: [Todo] = []
    
    func fetchTodos() async{
        guard let url = URL(string:
            "https://jsonplaceholder.typicode.com/todos") else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                return
            }
            let decoded = try JSONDecoder().decode([Todo].self, from : data)
            todos = decoded
        } catch {
        }
    }
}
