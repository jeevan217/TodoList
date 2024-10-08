import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    // Add new task
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
    }

    // Remove task
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    // Mark task as complete
    func toggleComplete(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    // Remove all tasks
        func removeAllTasks() {
            tasks.removeAll()
        }
}
