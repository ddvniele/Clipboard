//
//  TrashView.swift
//  Clipboard
//
//  Created by dan on 11/08/24.
//

import SwiftUI

struct TrashView: View {
    
    @Binding var textToPermanentlyDelete: String?
    @Binding var permanentlyDeleteIsPresented: Bool
    @Binding var emptyTrashIsPresented: Bool
    @Binding var restoreAllTrashIsPresented: Bool
    
    var body: some View {
        Section(content: {
            ForEach(ItemsModel.shared.trashItems, id: \.self) { trashItem in
                Text(trashItem)
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button(action: {
                        ItemsModel.shared.appendItem(item: trashItem)
                        if let index = ItemsModel.shared.trashItems.firstIndex(of: trashItem) {
                            ItemsModel.shared.deleteItemFromTrash(index: index)
                        } // IF LET
                    }, label: {
                        Label("Restore", systemImage: "arrow.uturn.left")
                    }) // BUTTON + label
                } // SWIPE ACTIONS
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive, action: {
                        textToPermanentlyDelete = trashItem
                        permanentlyDeleteIsPresented = true
                    }, label: {
                        Label("Permanently delete", systemImage: "trash")
                    }) // BUTTON + label
                } // SWIPE ACTIONS
                .contextMenu {
                    Button(action: {
                        ItemsModel.shared.appendItem(item: trashItem)
                        if let index = ItemsModel.shared.trashItems.firstIndex(of: trashItem) {
                            ItemsModel.shared.deleteItemFromTrash(index: index)
                        } // IF LET
                    }, label: {
                        Label("Restore", systemImage: "arrow.uturn.left")
                    }) // BUTTON + label
                    Button(role: .destructive, action: {
                        textToPermanentlyDelete = trashItem
                        permanentlyDeleteIsPresented = true
                    }, label: {
                        Label("Permanently delete", systemImage: "trash")
                    }) // BUTTON + label
                } // CONTEXT MENU
            } // FOR EACH
        }, header: {
            HStack {
                Text("Trash")
                Spacer()
                Button("Empty Trash") {
                    emptyTrashIsPresented = true
                } // BUTTON
                .foregroundStyle(.red)
                Button("Restore all") {
                    restoreAllTrashIsPresented = true
                } // BUTTON
                .foregroundStyle(.purple)
                .padding(.leading, 10)
            } // HSTACK
        }) // SECTION + header
    } // VAR BODY
} // STRUCT TRASH VIEW
