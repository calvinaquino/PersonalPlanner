//
//  TransactionCategory.swift
//  personal-planner
//
//  Created by Calvin De Aquino on 2020-02-21.
//  Copyright © 2020 Calvin Aquino. All rights reserved.
//

import CoreData
import Foundation

class TransactionCategory : NSManagedObject, Identifiable {
  @NSManaged var name: String
  @NSManaged var budget: Double
  @NSManaged var transactionItems: [TransactionItem]?
  
  convenience init() {
    self.init(context: Store.context)
  }
  
  static func allFetchRequest() -> NSFetchRequest<TransactionCategory> {
    let request : NSFetchRequest<TransactionCategory> = TransactionCategory.fetchRequest() as! NSFetchRequest<TransactionCategory>
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    return request
  }
}

