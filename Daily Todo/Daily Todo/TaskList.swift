//
//  TaskList.swift
//  Daily Todo
//
//  Created by iakalann on 22/02/2023.
//

import SwiftUI

class TaskList: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            // When the tasks array is updated, save it to UserDefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(tasks) {
                UserDefaults.standard.set(encoded, forKey: "tasks")
            }
        }
    }
    
    func addTask(name: String) {
        tasks.append(Task(name: name, completed: false))
    }
    
    func toggleTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
    }
    
    func resetTasks() {
        tasks = tasks.map { Task(name: $0.name, completed: false) }
    }
    
    init() {
        // When the TaskList is initialized, retrieve the tasks from UserDefaults
        if let tasksData = UserDefaults.standard.data(forKey: "tasks") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Task].self, from: tasksData) {
                tasks = decoded
                return
            }
        }
        tasks = []
    }
}
