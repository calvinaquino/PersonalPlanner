//
//  ShoppingSection.swift
//  personal-planner
//
//  Created by Calvin De Aquino on 2020-02-24.
//  Copyright © 2020 Calvin Aquino. All rights reserved.
//

import SwiftUI
import CoreData

struct ShoppingSection: Hashable {
  var category: ShoppingCategory?
  var items: [ShoppingItem]
  var categoryName: String {
    category?.name ?? "Geral"
  }
  
  static func sections(items: FetchRequest<ShoppingItem>, categories: FetchRequest<ShoppingCategory>) -> [ShoppingSection] {
    var sections: [ShoppingSection] = []
    let generalSection = ShoppingSection(category: nil, items: items.wrappedValue.filter({
        ($0.shoppingCategory == nil)
    }))
    if generalSection.items.count > 0 {
        sections.append(generalSection)
    }
    for category in categories.wrappedValue {
        let section = ShoppingSection(category: category, items: items.wrappedValue.filter({
            ($0.shoppingCategory != nil) ? $0.shoppingCategory!.id == category.id : false
        }))
        if section.items.count > 0 {
            sections.append(section)
        }
    }
    return sections
  }
}

extension Array where Iterator.Element == ShoppingSection {
  
  func hasItem(with name: String) -> Bool {
    for section in self {
      let match = section.items.filter{ $0.name == name }.first != nil
      if match {
        return true
      }
    }
    return false
  }
  
  var itemCount: Int {
    var total = 0
    for section in self {
      total = total + section.items.count
    }
    return total
  }
  
  func item(at indexPath: IndexPath) -> ShoppingItem {
    let section = self[indexPath.section]
    return section.items[indexPath.row]
  }
}
