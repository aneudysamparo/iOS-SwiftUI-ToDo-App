//
//  ToDoItem+CoreDataProperties.swift
//  MyDo
//
//  Created by Aneudys Amparo on 27/4/23.
//

import Foundation
import Foundation
import CoreData

extension Item {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
//        return NSFetchRequest<Item>(entityName: "ToDoItem")
//    }

    //@NSManaged public var name: String?
   // @NSManaged public var isCompleted: Bool
    //@NSManaged public var timestamp: Date?

    public var wrappedName: String {
        return name ?? "Tarea sin nombre"
    }
}

//extension Item: Identifiable {
//}
