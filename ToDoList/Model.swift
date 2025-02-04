//
//  Model.swift
//  ToDoList
//
//  Created by alina on 2025/2/3.
//

import SwiftUI

@Observable
class ItemList: Identifiable, Equatable, Hashable {
    static func == (lhs: ItemList, rhs: ItemList) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    let name: String
    private(set) var items: [Item]
    let createdAt: Date = .init()
    
    var isCompleted: Bool {
        items.allSatisfy(\.isCompleted)
    }
    
    init(name: String, items: [Item]) {
        self.id = UUID()
        self.name = name
        self.items = items
    }
    
    struct Item: Identifiable, Equatable {
        let id: UUID
        let title: String
        var isCompleted: Bool
        let createdAt: Date = .init()
        
        init(title: String, isCompleted: Bool) {
            self.id = UUID()
            self.title = title
            self.isCompleted = isCompleted
        }
    }
    
    func addItem(_ name: String) {
        let item: Item = .init(title: name, isCompleted: false)
        items.append(item)
    }
    
    func toggleItemAsCompleted(_ item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        
        items[index].isCompleted.toggle()
    }
}
