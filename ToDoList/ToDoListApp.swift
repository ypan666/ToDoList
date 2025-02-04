//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by alina on 2025/2/3.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
import SwiftUI
