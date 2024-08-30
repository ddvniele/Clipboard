//
//  Classes.swift
//  Clipboard
//
//  Created by dan on 09/08/24.
//

import Foundation

@Observable
class ItemsModel {
    static let shared = ItemsModel()
    var items: [String] = UserDefaults.standard.array(forKey: "ITEMS") as? [String] ?? ["this is an example"]
    var trashItems: [String] = UserDefaults.standard.array(forKey: "TRASH_ITEMS") as? [String] ?? ["this is an example"]
    
    func appendItem(item: String) {
        ItemsModel.shared.items.insert(item, at: 0)
        UserDefaults.standard.setValue(ItemsModel.shared.items, forKey: "ITEMS")
    } // FUNC APPEND ITEM
    
    func deleteItem(index: Int, text: String) {
        ItemsModel.shared.items.remove(at: index)
        UserDefaults.standard.setValue(ItemsModel.shared.items, forKey: "ITEMS")
        ItemsModel.shared.trashItems.insert(text, at: 0)
        UserDefaults.standard.setValue(ItemsModel.shared.trashItems, forKey: "TRASH_ITEMS")
    } // FUNC DELETE ITEM
    
    func editItem(index: Int, text: String) {
        ItemsModel.shared.items.remove(at: index)
        ItemsModel.shared.items.insert(text, at: index)
        UserDefaults.standard.setValue(ItemsModel.shared.items, forKey: "ITEMS")
    } // FUNC EDIT ITEM
    
    func deleteItemFromTrash(index: Int) {
        ItemsModel.shared.trashItems.remove(at: index)
        UserDefaults.standard.setValue(ItemsModel.shared.trashItems, forKey: "TRASH_ITEMS")
    } // FUNC DELETE ITEM FROM TRASH
    
    func emptyTrash() {
        ItemsModel.shared.trashItems = []
        UserDefaults.standard.setValue(ItemsModel.shared.trashItems, forKey: "TRASH_ITEMS")
    } // FUNC EMPTY TRASH
    
    func restoreAllTrash() {
        let arrayToRestore = ItemsModel.shared.trashItems + ItemsModel.shared.items
        ItemsModel.shared.items = arrayToRestore
        UserDefaults.standard.setValue(ItemsModel.shared.items, forKey: "ITEMS")
        emptyTrash()
    } // FUNC RESTORE ALL TRASH
} // CLASS ITEMS MODEL
