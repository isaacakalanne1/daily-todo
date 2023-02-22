//
//  AddTaskView.swift
//  Daily Todo
//
//  Created by iakalann on 22/02/2023.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskList: TaskList
    @State private var taskName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Task Name", text: $taskName)
            }
            
            Section {
                Button("Add Task") {
                    taskList.addTask(name: taskName)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .disabled(taskName.isEmpty)
        }
        .navigationTitle("Add Task")
    }
}
