//
//  AddNewTask.swift
//  Notas
//
//  Created by Jose Isaac on 13/06/22.
//

import SwiftUI

struct AddNewTask: View {
    
    let taskTypes: [String] = ["Basic", "Urgent", "Important"]
    @EnvironmentObject var taskModel: TaskViewModel
    
   
    @Namespace var animation
    @Environment(\.self) var env
 
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                }
            
            TaskColor()
                .padding(.top,15)
       
           
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            .padding(.top,20)
            
            TaskDeadline()
                .padding(.top, 10)
            Divider()
                .padding(.vertical,10)
            
            TaskTitle()
                .padding(.top,10)
            Divider()
            TaskType()
                .padding(.top,10)
            Divider()
                .padding(.top,10)
            
            Button{
                if taskModel.addTask(context: env.managedObjectContext) {
                    env.dismiss()
                    
                }
                
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,12)
                    .foregroundColor(.white)
                    .background{
                        Capsule()
                            .fill(.black)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom,10)
            .disabled(taskModel.taskTitle == "")
            .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay{
            showPicker()
        }
    }
    
    //Funcion para elegir el color
    @ViewBuilder
    func TaskColor()->some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Task Color")
                .font(.caption)
                .foregroundColor(.gray)
            
            let colors: [String] = ["Yellow", "Green", "Blue","Purple","Red", "Orange"]
            HStack(spacing: 15){
                ForEach(colors,id:\.self){color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 35, height: 35 )
                        .background{
                            if taskModel.taskColor == color{
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                            
                        }
                        .contentShape(Circle())
                        .onTapGesture {
                            taskModel.taskColor = color
                            
                        }
                    
                    
                }
            }
            .padding(.top,10)
        }
        
        
    }


func TaskTitle()->some View {
    VStack(alignment:.leading, spacing: 12) {
        Text("Task Title")
            .font(.caption)
        .foregroundColor(.gray)
        
        TextField("", text: $taskModel.taskTitle)
            .frame(maxWidth: .infinity)
            .padding(.top,10)
    }
   
    
 }
    
func TaskDeadline()-> some View {
    VStack(alignment: .leading, spacing: 12) {
        Text("Task Deadline")
            .font(.caption)
            .foregroundColor(.gray)
        
        Text(taskModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + taskModel.taskDeadline.formatted(date: .omitted, time: .shortened))
            .font(.callout)
            .fontWeight(.semibold)
            .padding(.top,10)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    
    .overlay(alignment: .bottomTrailing) {
        Button {
            taskModel.showDataPicker.toggle()
            
        } label: {
            Image(systemName: "calendar")
                .foregroundColor(.black)
        }
        
            
    }
    
}
    

func TaskType()->some View{
    
    
    VStack(alignment: .leading, spacing: 12) {
        Text("Task Type")
            .font(.caption)
            .foregroundColor(.gray)
        
        HStack(spacing: 12) {
            ForEach(taskTypes, id: \.self){
                type in
                Text(type)
                    .font(.callout)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(taskModel.taskType == type ? .white : .black)
                    .background{
                        if taskModel.taskType == type{
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TYPE", in: animation)
                        } else {
                            Capsule()
                                .strokeBorder(.black)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{taskModel.taskType = type}
                    }
            }
        }
        .padding(.top,8)
    }
        
    }
    
func showPicker()->some View {
    ZStack{
        if taskModel.showDataPicker{
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    taskModel.showDataPicker = false
                }
            
            //Desativamos fechas pasadas
            DatePicker.init("", selection: $taskModel.taskDeadline, in:
                                Date.now...Date.distantFuture)
            //Seteamos DatePicker
            .datePickerStyle(.graphical)
            .labelsHidden()
            .padding()
            .background(.white, in: RoundedRectangle(cornerRadius: 12,
            style: .continuous))
            .padding()
            
        }
    }
    .animation(.easeInOut, value: taskModel.showDataPicker)
    
        
    }
}



struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
