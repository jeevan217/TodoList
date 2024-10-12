import Foundation

struct Task: Identifiable, Codable { // Conform to Codable
    var id = UUID()
    var title: String
    var isCompleted: Bool

    init(title: String) {
        self.title = title
        self.isCompleted = false // Default to not completed
    }
}
