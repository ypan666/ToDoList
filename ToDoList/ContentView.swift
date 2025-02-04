//
//  ContentView.swift
//  ToDoList
//
//  Created by alina on 2025/2/3.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @State private var showAddList = false
    @State private var newListName = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.lists) { list in
                NavigationLink(list.name, value: list)
            }
            .navigationDestination(for: ItemList.self) {
                ItemListView(list: $0)
            }
            .navigationTitle("Lists")
            .toolbar {
                Button("Add List", systemImage: "plus") {
                    showAddList.toggle()
                }
            }
        }
        .alert("New List", isPresented: $showAddList) {
            TextField("List Name", text: $newListName)
            Button("Cancel", role: .cancel) {
                newListName = ""
            }
            Button("Done") {
                if !newListName.isEmpty {
                    viewModel.createList(name: newListName)
                    newListName = ""
                }
            }
        } message: {
            Text("What is the name of the new list?")
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}
