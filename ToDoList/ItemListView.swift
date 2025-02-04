//
//  ItemListView.swift
//  ToDoList
//
//  Created by alina on 2025/2/3.
//

import SwiftUI

struct ItemListView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(ViewModel.self) private var viewModel
    let list: ItemList
    
    @State private var showingAddItem: Bool = false
    @State private var newItemText = ""
    
    var body: some View {
        List(list.items) { item in
            HStack {
                Button {
                    withAnimation {
                        viewModel.toggleItemAsCompleted(item, list: list)
                        checkIfListCompleted()
                    }
                } label: {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .imageScale(.large)
                        .contentTransition(.symbolEffect(.replace))
                }
                .foregroundStyle(item.isCompleted ? .green : .accentColor)
                .buttonStyle(.plain)
                
                Text(item.title)
            }
        }
        .navigationTitle(list.name)
        .toolbar {
            Button("Add Item", systemImage: "plus") {
                showingAddItem.toggle()
            }
        }
        .alert("Add Item", isPresented: $showingAddItem) {
            TextField("Item Title", text: $newItemText)
            Button("Cancel", role: .cancel) {
                newItemText = ""
            }
            Button("Add") {
                list.addItem(newItemText)
                newItemText = ""
            }
            .disabled(newItemText.isEmpty)
        } message: {
            Text("Add item to \(list.name)")
        }
    }
    
    private func checkIfListCompleted() {
        if list.isCompleted {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.deleteList(list)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
