import Foundation

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks() // Save tasks whenever they change
        }
    }

    init() {
        loadTasks() // Load tasks when the view model is initialized
    }

    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
    }

    func toggleComplete(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func removeAllTasks() {
        tasks.removeAll()
    }

    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
}

