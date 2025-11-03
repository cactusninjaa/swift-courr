//
//  Todo.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

struct Todo: Codable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
}
