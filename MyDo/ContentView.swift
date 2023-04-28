//
//  ContentView.swift
//  MyDo
//
//  Created by Aneudys Amparo on 27/4/23.
//

import SwiftUI
import CoreData

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var newItem = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.name ?? "")
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                markTaskAsCompleted(item)
                            }
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .green : .gray)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                
                HStack {
                    TextField("Agregar tarea", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        withAnimation {
                            addItem()
                                
                                
                        }
                    }) {
                        Label("Agregar", systemImage: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Lista de tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = self.newItem
            newItem.timestamp = Date()
            newItem.isCompleted = false
            
            do {
                try viewContext.save()
                self.newItem = ""
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func markTaskAsCompleted(_ item: Item) {
        withAnimation {
            item.isCompleted.toggle()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
