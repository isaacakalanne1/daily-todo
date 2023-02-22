//
//  ContentView.swift
//  Daily Todo
//
//  Created by iakalann on 22/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskList = TaskList()
    @State private var lastOpenedDate: Date?
    
    let mutedBlue = Color(red: 55/255, green: 71/255, blue: 79/255)
    let mutedGreen = Color(red: 86/255, green: 139/255, blue: 125/255)
    let mutedRed = Color(red: 151/255, green: 66/255, blue: 63/255)
    let mutedYellow = Color(red: 180/255, green: 140/255, blue: 57/255)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskList.tasks) { task in
                    Button(action: {
                        taskList.toggleTask(task: task)
                    }) {
                        HStack {
                            Image(systemName: task.completed ? "checkmark.square.fill" : "square")
                                .foregroundColor(task.completed ? mutedGreen : mutedBlue)
                            Text(task.name)
                                .foregroundColor(task.completed ? .gray : .primary)
                        }
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
                            .foregroundColor(mutedBlue)
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
        .accentColor(mutedGreen)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
