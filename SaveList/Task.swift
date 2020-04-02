//
//  Task.swift
//  SaveList
//
//  Created by Janin Culhaoglu on 26/03/2020.
//  Copyright © 2020 Janin Culhaoglu. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Task] {
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "taskName", ascending: true)]
        guard let tasks = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return tasks
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        Task.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
}
