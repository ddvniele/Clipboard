//
//  Shortcut.swift
//  Clipboard
//
//  Created by dan on 09/08/24.
//

import Foundation
import AppIntents
import SwiftUI

struct AddToClipboardIntent: AppIntent {
    static let title: LocalizedStringResource = "Add to Clipboard"
    static let description: IntentDescription = IntentDescription("Add given input to Clipboard", categoryName: "New Item")
    
    @Parameter(title: "Text")
    var text: String
    
    @MainActor
    func perform() async throws -> some IntentResult {
        ItemsModel.shared.appendItem(item: text)
        return .result()
    } // FUNC PERFORM
    
    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$text) to Clipboard")
    } // STATIC VAR PARAMETER SUMMARY
} // STRUCT ADD TO CLIPBOARD INTENT

struct PasteToClipboardIntent: AppIntent {
    static let title: LocalizedStringResource = "Paste to Clipboard"
    static let description: IntentDescription = IntentDescription("Paste what you have copied before to Clipboard", categoryName: "New Item")
    
    @MainActor
    func perform() async throws -> some IntentResult {
        if let pasteboard = UIPasteboard.general.string {
            ItemsModel.shared.appendItem(item: pasteboard)
        } // IF LET
        return .result()
    } // FUNC PERFORM
} // STRUCT PASTE TO CLIPBOARD INTENT

struct RetrieveClipboardIntent: AppIntent {
    static let title: LocalizedStringResource = "Retrieve Clipboard (by last added)"
    static let description: IntentDescription = IntentDescription("Returns a list of all the items stored into Clipboard", categoryName: "Retrieve")
    
    @MainActor
    func perform() async throws -> some ReturnsValue<[String]> {
        let clipboard = ItemsModel.shared.items
        return .result(value: clipboard)
    } // FUNC PERFORM
} // STRUCT RETRIEVE CLIPBOARD INTENT

struct RetrieveTrashItemsIntent: AppIntent {
    static let title: LocalizedStringResource = "Retrieve Trash Items"
    static let description: IntentDescription = IntentDescription("Returns a list of all the items moved to Trash", categoryName: "Trash")
    
    @MainActor
    func perform() async throws -> some ReturnsValue<[String]> {
        let clipboard = ItemsModel.shared.trashItems
        return .result(value: clipboard)
    } // FUNC PERFORM
} // STRUCT RETRIEVE TRASH ITEMS INTENT

struct MoveItemToTrashIntent: AppIntent {
    static let title: LocalizedStringResource = "Move Item to Trash"
    static let description: IntentDescription = IntentDescription("Move given item to Trash. Combine this action with a selection from a list of items obtained with the action Retrieve Clipboard", categoryName: "Trash")
    
    @Parameter(title: "Text")
    var text: String
    
    @MainActor
    func perform() async throws -> some IntentResult {
        if let index = ItemsModel.shared.items.firstIndex(of: text) {
            ItemsModel.shared.deleteItem(index: index, text: ItemsModel.shared.items[index])
        } // IF LET
        return .result()
    } // FUNC PERFORM
    
    static var parameterSummary: some ParameterSummary {
        Summary("Move \(\.$text) to Trash")
    } // STATIC VAR PARAMETER SUMMARY
} // STRUCT MOVE ITEM TO TRASH INTENT

struct PermanentlyDeleteItemIntent: AppIntent {
    static let title: LocalizedStringResource = "Permanently delete Item from Trash"
    static let description: IntentDescription = IntentDescription("Permanently delete given item from Trash. Combine this action with a selection from a list of items obtained with the action Retrieve Trash Items", categoryName: "Trash")
    
    @Parameter(title: "Text")
    var text: String
    
    @MainActor
    func perform() async throws -> some IntentResult {
        if let index = ItemsModel.shared.trashItems.firstIndex(of: text) {
            ItemsModel.shared.deleteItemFromTrash(index: index)
        } // IF LET
        return .result()
    } // FUNC PERFORM
    
    static var parameterSummary: some ParameterSummary {
        Summary("Permanently delete \(\.$text) from Trash")
    } // STATIC VAR PARAMETER SUMMARY
} // STRUCT PERMANENTLY DELETE ITEM INTENT

struct AddToClipboardShortcut: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddToClipboardIntent(),
            phrases: ["Add to \(.applicationName)"],
            shortTitle: "Add to Clipboard",
            systemImageName: "plus.circle.fill"
        ) // APP SHORTCUT
        AppShortcut(
            intent: PasteToClipboardIntent(),
            phrases: ["Paste to \(.applicationName)"],
            shortTitle: "Paste to Clipboard",
            systemImageName: "list.bullet.clipboard.fill"
        ) // APP SHORTCUT
    } // STATIC VAR APP SHORTCUTS
} // STRUCT ADD TO CLIPBOARD SHORTCUT
