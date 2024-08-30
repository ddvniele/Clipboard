//
//  ContentView.swift
//  Clipboard
//
//  Created by dan on 08/08/24.
//

import AppIntents
import SwiftUI

struct MainView: View {
    
    // vars
    @AppStorage("INTRO_IS_PRESENTED") var introIsPresented: Bool = true
    @State var introCurrentPage: UInt8 = 1
    @AppStorage("INLINE_NAV_TITLE") var inlineNavTitle: Bool = false
    @AppStorage("ALWAYS_SEARCHABLE") var alwaysSearchable: Bool = true
    @State var copiedText: String?
    @State var insertNewTextIsPresented: Bool = false
    @State var newTextInserted: String = ""
    @State var editItemIsPresented: Bool = false
    @State var editingItem: String = ""
    @State var indexToEdit: Int?
    @State var searchItem: String = ""
    var searchResults: [String] {
        if searchItem.isEmpty {
            return ItemsModel.shared.items
        } else {
            return ItemsModel.shared.items.filter { $0.localizedCaseInsensitiveContains(searchItem) }
        } // IF ELSE
    } // VAR SEARCH RESULTS
    @State var currentSorting: String = "Last added"
    @State var permanentlyDeleteIsPresented: Bool = false
    @State var textToPermanentlyDelete: String?
    @State var emptyTrashIsPresented: Bool = false
    @State var restoreAllTrashIsPresented: Bool = false
    @State var trashIsPresented: Bool = false
    @State var settingsIsPresented: Bool = false
    
    // body
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if !ItemsModel.shared.items.isEmpty {
                        SavedItemsView(currentSorting: $currentSorting, searchResults: searchResults, copiedText: $copiedText, editingItem: $editingItem, indexToEdit: $indexToEdit, editItemIsPresented: $editItemIsPresented)
                    } // IF
                } // LIST
                .listStyle(.plain)
                .searchable(text: $searchItem, placement: .navigationBarDrawer(displayMode: alwaysSearchable ? .always : .automatic))
                .overlay(
                    ZStack {
                        if searchResults.isEmpty && !ItemsModel.shared.items.isEmpty {
                            ContentUnavailableView.search(text: searchItem)
                        } // IF
                    } // ZSTACK
                ) // OVERLAY
                .overlay(
                    ZStack {
                        if ItemsModel.shared.items.isEmpty && !introIsPresented {
                            ContentUnavailableView("Nothing saved to Clipboard", systemImage: "doc.on.clipboard", description: Text("Start by pressing the Add Item button"))
                        } // IF
                    } // ZSTACK
                ) // OVERLAY
            } // VSTACK
            .navigationTitle("Clipboard")
            .navigationBarTitleDisplayMode(inlineNavTitle ? .inline : .automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu(content: {
                        Button(role: .destructive, action: {
                            trashIsPresented = true
                        }, label: {
                            Label("Trash", systemImage: "trash")
                        }) // BUTTON + label
                        Divider()
                        Button(action: {
                            settingsIsPresented = true
                        }, label: {
                            Label("Settings", systemImage: "gear")
                        }) // BUTTON + label
                    }, label: {
                        Image(systemName: "ellipsis.circle")
                        .fontWeight(.medium)
                        .foregroundStyle(.purple)
                    }) // MENU + label
                } // TOOL BAR ITEM
                ToolbarItem(placement: .bottomBar) {
                    Menu(content: {
                        PasteButton(payloadType: String.self) { strings in
                            ItemsModel.shared.appendItem(item: strings[0])
                        } // PASTE BUTTON
                        Divider()
                        Button(action: {
                            newTextInserted = ""
                            insertNewTextIsPresented = true
                        }, label: {
                            Label("Add Text", systemImage: "pencil.line")
                        }) // BUTTON + label
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Item")
                        } // HSTACK
                        .foregroundStyle(.purple)
                    }) // MENU + label
                } // TOOL BAR ITEM
            } // TOOL BAR
        } // NAVIGATION STACK
        .blur(radius: introCurrentPage != 2 && introCurrentPage != 3 && introCurrentPage != 4 && introIsPresented ? 10 : 0)
        .disabled(introCurrentPage != 2 && introCurrentPage != 3 && introCurrentPage != 4 && introIsPresented)
        .overlay(
            ZStack {
                if introIsPresented {
                    ZStack {
                        IntroFirstPageView(introCurrentPage: $introCurrentPage)
                        .offset(x: introCurrentPage == 1 ? 0 : -500)
                        IntroSecondPageView(introCurrentPage: $introCurrentPage)
                        .offset(x: introCurrentPage < 2 ? 500 : introCurrentPage > 2 ? -500 : 0)
                        .frame(maxHeight: 450)
                        IntroThirdPageView(introCurrentPage: $introCurrentPage)
                        .offset(x: introCurrentPage < 3 ? 500 : introCurrentPage > 3 ? -500 : 0)
                        .frame(maxHeight: 450)
                        IntroFourthPageView(introCurrentPage: $introCurrentPage)
                        .offset(x: introCurrentPage < 4 ? 500 : introCurrentPage > 4 ? -500 : 0)
                        .frame(maxHeight: 450)
                        IntroFifthPageView(introIsPresented: $introIsPresented)
                        .offset(x: introCurrentPage == 5 ? 0 : 500)
                    } // ZSTACK
                } // IF
            } // ZSTACK
        ) // OVERLAY
        .sheet(isPresented: $trashIsPresented) {
            NavigationStack {
                List {
                    if !ItemsModel.shared.trashItems.isEmpty {
                        TrashView(textToPermanentlyDelete: $textToPermanentlyDelete, permanentlyDeleteIsPresented: $permanentlyDeleteIsPresented, emptyTrashIsPresented: $emptyTrashIsPresented, restoreAllTrashIsPresented: $restoreAllTrashIsPresented)
                    } // IF ELSE
                } // LIST
                .listStyle(.plain)
                .navigationTitle("Trash")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            trashIsPresented = false
                        }, label: {
                            Text("Done")
                            .fontWeight(.medium)
                            .foregroundStyle(.purple)
                        }) // BUTTON + label
                    } // TOOL BAR ITEM
                } // TOOL BAR
                .overlay(
                    ZStack {
                        if ItemsModel.shared.trashItems.isEmpty {
                            ContentUnavailableView("The Trash is empty", systemImage: "trash", description: Text("Items you moved to the Trash will appear here"))
                        } // IF
                    } // ZSTACK
                ) // OVERLAY
            } // NAVIGATION STACK
            .interactiveDismissDisabled()
        } // SHEET
        .sheet(isPresented: $settingsIsPresented) {
            NavigationStack {
                List {
                    SettingsView(alwaysSearchable: $alwaysSearchable, inlineNavTitle: $inlineNavTitle, introIsPresented: $introIsPresented, settingsIsPresented: $settingsIsPresented, introCurrentPage: $introCurrentPage)
                } // LIST
                .listStyle(.plain)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            settingsIsPresented = false
                        }, label: {
                            Text("Done")
                            .fontWeight(.medium)
                            .foregroundStyle(.purple)
                        }) // BUTTON + label
                    } // TOOL BAR ITEM
                } // TOOL BAR
            } // NAVIGATION STACK
        } // SHEET
        .alert("Add Text", isPresented: $insertNewTextIsPresented) {
            TextField("Enter text here", text: $newTextInserted)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                ItemsModel.shared.appendItem(item: newTextInserted)
            } // BUTTON
        } // ALERT
        .alert("Edit Item", isPresented: $editItemIsPresented) {
            TextField("Enter text here", text: $editingItem)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                ItemsModel.shared.editItem(index: indexToEdit!, text: editingItem)
            } // BUTTON
        } // ALERT
        .alert("Permanently delete", isPresented: $permanentlyDeleteIsPresented) {
            Button("Cancel", role: .cancel) { }
            Button("Yes, delete", role: .destructive) {
                if let index = ItemsModel.shared.trashItems.firstIndex(of: textToPermanentlyDelete!) {
                    ItemsModel.shared.deleteItemFromTrash(index: index)
                } // IF LET
                trashIsPresented = true
            } // BUTTON
        } message: {
            Text("Are you sure you want to permanently delete this item?")
        } // ALERT + message
        .alert("Empty Trash", isPresented: $emptyTrashIsPresented) {
            Button("Cancel", role: .cancel) { }
            Button("Yes, delete", role: .destructive) {
                ItemsModel.shared.emptyTrash()
                trashIsPresented = true
            } // BUTTON
        } message: {
            Text("Are you sure you want to permanently empty the trash?")
        } // ALERT + message
        .alert("Restore all", isPresented: $restoreAllTrashIsPresented) {
            Button("Cancel", role: .cancel) { }
            Button("Yes, restore") {
                ItemsModel.shared.restoreAllTrash()
                trashIsPresented = true
            } // BUTTON
        } message: {
            Text("Do you want to restore all items in the trash?")
        } // ALERT + message
    } // VAR BODY
} // STRUCT MAIN VIEW

#Preview {
    MainView()
} // PREVIEW
