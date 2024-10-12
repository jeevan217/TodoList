import SwiftUI

struct ContentView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var showAlert = false
    @FocusState private var isFocused: Bool          // State to manage TextField focus
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTaskTitle)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding()
                                            .focused($isFocused) // Link TextField focus to isFocused state
                                            .onSubmit {
                                                addNewTask()  // Trigger the function on Return key press
                                                isFocused = true // Keep the focus on TextField
                                            }
                    
                    Button(action: {
                                            isFocused = true
                                            let trimmedTaskTitle = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                                            if !trimmedTaskTitle.isEmpty {
                                                taskViewModel.addTask(title: trimmedTaskTitle)
                                                newTaskTitle = ""
                                            }    
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .offset(x: -10)
                    }
                }
                
                List {
                    ForEach(taskViewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Button(action: {
                                taskViewModel.toggleComplete(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                    .onDelete(perform: taskViewModel.removeTask)
                }
                .listStyle(PlainListStyle())
                
                Spacer() //Pushes the button to the bottom
                
                //Delete All Button
                Button(action:{
                    showAlert = true  // Show Confirmation alert
                }){
                Text("Delete All Tasks")
                        .foregroundStyle(.red)
                        .padding()
                        .cornerRadius(8)
                        .shadow(radius: 1)
                
                }
                .padding(.bottom)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure to remove all items?"),
                          primaryButton: .destructive(Text("Delete")){
                        taskViewModel.removeAllTasks()
                    },
                          secondaryButton: .cancel())
                }
            }
            
            .background(Color("EDE8DC")) // <-- Add your background color here
            .onAppear {
                isFocused = true // Set initial focus to TextField
            }
            .toolbar {
                ToolbarItem(placement: .principal) { // Centers the title
                    Text("To-Do List")
                        .font(.largeTitle)
                        .bold()
                        .offset(y: 40)
                }
            }

        
        }
    }
    
    // Function to handle adding a new task
        func addNewTask() {
            let trimmedTaskTitle = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmedTaskTitle.isEmpty {
                taskViewModel.addTask(title: trimmedTaskTitle)
                newTaskTitle = "" // Clear the text field after adding
            }
            DispatchQueue.main.async {
                        isFocused = true // Immediately refocus after adding task
                    }
        }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
