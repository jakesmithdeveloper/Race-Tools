//
//  DataController.swift
//  RaceTools
//
//  Created by Jake Smith on 5/1/22.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        let calendar = Calendar.current
        
        let dates = [calendar.date(from: DateComponents(year: 2022, month: 5, day: 30)), calendar.date(from: DateComponents(year: 2022, month: 6, day: 26)), calendar.date(from: DateComponents(year: 2022, month: 7, day: 4)), calendar.date(from: DateComponents(year: 2022, month: 7, day: 16))]
        let names = ["20th Highways One 5K", "20th Beach patrol 5k", "16th Dewey beach liquors 5k", "21st Santa Spring 5k"]
        
        for i in 0...3 {
            let race = Race(context: viewContext)
            race.name = names[i]
            race.completed = false
            race.date = dates[i]
        }
        
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }


    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Race.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
    static var preview: DataController {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating previews: \(error.localizedDescription)")
        }
        
        return dataController
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
}
