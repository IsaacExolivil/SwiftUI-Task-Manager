//
//  TaskViewModel.swift
//  Notas
//
//  Created by Jose Isaac on 13/06/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    // MARK: Nueva tarea Propiedades
    
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDataPicker: Bool = false
    @Published var colaboracion: String =  ""
    
    //MARK: añadir tarea a Core Data
    
    func addTask(context: NSManagedObjectContext)->Bool{
        let task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        task.colaboracion = colaboracion
        
        if let _ = try? context.save(){
            return true
            
        }
        return false
        
    }
    
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadline = Date()
        colaboracion = ""
    }
   
}


