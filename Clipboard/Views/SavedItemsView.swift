//
//  SavedItemsView.swift
//  Clipboard
//
//  Created by dan on 11/08/24.
//

import SwiftUI

struct SavedItemsView: View {
    
    @Binding var currentSorting: String
    var searchResults: [String]
    @Binding var copiedText: String?
    @Binding var editingItem: String
    @Binding var indexToEdit: Int?
    @Binding var editItemIsPresented: Bool
    let sortingPossibilities: [String] = ["Last added", "First added", "Alphabetical (A-Z)", "Alphabetical (Z-A)"]
    
    var body: some View {
        Section(content: {
            ForEach(currentSorting == "Last added" ? searchResults : currentSorting == "First added" ? searchResults.reversed() : currentSorting == "Alphabetical (A-Z)" ? searchResults.sorted() : searchResults.sorted(by: >), id: \.self) { item in
                HStack {
                    Text(item)
                    if copiedText == item {
                        Spacer()
                        Text("Copied!")
                        .foregroundStyle(.tertiary)
                    } // IF
                } // HSTACK
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(action: {
                        UIPasteboard.general.string = item
                        copiedText = item
                    }, label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }) // BUTTON + label
                    .tint(.purple)
                } // SWIPE ACTIONS
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive, action: {
                        if let index = ItemsModel.shared.items.firstIndex(of: item) {
                            ItemsModel.shared.deleteItem(index: index, text: item)
                        } // IF LET
                    }, label: {
                        Label("Move to Trash", systemImage: "trash")
                    }) // BUTTON + label
                    Button(action: {
                        editingItem = item
                        if let index = ItemsModel.shared.items.firstIndex(of: item) {
                            indexToEdit = index
                        } // IF LET
                        editItemIsPresented = true
                    }, label: {
                        Label("Edit", systemImage: "pencil.line")
                    }) // BUTTON + label
                } // SWIPE ACTIONS
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = item
                        copiedText = item
                    }, label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }) // BUTTON + label
                    Divider()
                    Button(action: {
                        editingItem = item
                        if let index = ItemsModel.shared.items.firstIndex(of: item) {
                            indexToEdit = index
                        } // IF LET
                        editItemIsPresented = true
                    }, label: {
                        Label("Edit", systemImage: "pencil.line")
                    }) // BUTTON + label
                    Button(role: .destructive, action: {
                        if let index = ItemsModel.shared.items.firstIndex(of: item) {
                            ItemsModel.shared.deleteItem(index: index, text: item)
                        } // IF LET
                    }, label: {
                        Label("Move to Trash", systemImage: "trash")
                    }) // BUTTON + label
                } // CONTEXT MENU
            } // FOR EACH
        }, header: {
            HStack {
                Text("Saved Items")
                Spacer()
                Menu(content: {
                    Section(content: {
                        ForEach(sortingPossibilities, id: \.self) { possibility in
                            Button(action: {
                                currentSorting = possibility
                            }, label: {
                                HStack {
                                    Text(possibility)
                                    Spacer()
                                    if currentSorting == possibility {
                                        Image(systemName: "checkmark")
                                    } // IF
                                } // HSTACK
                            }) // BUTTON + label
                        } // FOR EACH
                    }, header: {
                        Text("Items sorting")
                    }) // SECTION + header
                }, label: {
                    HStack {
                        Text(currentSorting)
                        Image(systemName: "chevron.up.chevron.down")
                    } // HSTACK
                    .foregroundStyle(.purple)
                }) // MENU + label
            } // HSTACK
        }) // SECTION + header
    } // VAR BODY
} // STRUCT SAVED ITEMS VIEW
