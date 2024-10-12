import Foundation

struct Task: Identifiable {
    let id: UUID // This will be initialized when the Task is created
    var title: String
    var isCompleted: Bool
    
    // Initializer for creating a new task
    init(title: String) {
        self.id = UUID() // Generate a new UUID for each task
        self.title = title
        self.isCompleted = false // Default to not completed
    }
}
