import SwiftUI

struct ContentView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                                            let trimmedTaskTitle = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                                            if !trimmedTaskTitle.isEmpty {
                                                taskViewModel.addTask(title: trimmedTaskTitle)
                                                newTaskTitle = ""
                                            }    
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .padding()
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
            .toolbar {
                ToolbarItem(placement: .principal) { // Centers the title
                    Text("To-Do List")
                        .font(.custom("Caveat-Bold", size: 38))
                        .bold()
                        .offset(y: 30)
                }
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
