//
//  ContentView.swift
//  Daily Todo
//
//  Created by iakalann on 22/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskList = TaskList()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskList.tasks) { task in
                    HStack {
                        Button(action: {
                            taskList.toggleTask(task: task)
                        }) {
                            Image(systemName: task.completed ? "checkmark.square.fill" : "square")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        Text(task.name)
                    }
                }
                .onDelete(perform: { indexSet in
                    taskList.tasks.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddTaskView(taskList: taskList)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            let calendar = Calendar.current
            let now = Date()
            
            // Get the last opened date from UserDefaults
            let defaults = UserDefaults.standard
            let lastOpenedDate = defaults.object(forKey: "lastOpenedDate") as? Date
            
            // If the app has never been opened before, or if the last opened date is in a previous day, reset the tasks
            if lastOpenedDate == nil || !calendar.isDate(now, inSameDayAs: lastOpenedDate!) {
                taskList.resetTasks()
            }
            
            // Save the current date to UserDefaults
            defaults.set(now, forKey: "lastOpenedDate")
            
            // Check if a new day has begun while the app is running, and reset the tasks if necessary
            if let lastOpenedDate = lastOpenedDate, !calendar.isDate(now, inSameDayAs: lastOpenedDate) {
                taskList.resetTasks()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
