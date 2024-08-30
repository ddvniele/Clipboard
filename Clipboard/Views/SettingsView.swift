//
//  SettingsView.swift
//  Clipboard
//
//  Created by dan on 11/08/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var alwaysSearchable: Bool
    @Binding var inlineNavTitle: Bool
    @Binding var introIsPresented: Bool
    @Binding var settingsIsPresented: Bool
    @Binding var introCurrentPage: UInt8
    
    var body: some View {
        Section(content: {
            /*
            Button(action: {
                
            }, label: {
                HStack {
                    Text("Change app theme")
                    Spacer()
                    Image(systemName: "paintbrush")
                } // HSTACK
            }) // BUTTON + label
             */
            Toggle("Always show search bar", isOn: $alwaysSearchable)
            Toggle("Inline navigation title", isOn: $inlineNavTitle)
            Button(action: {
                if let url = URL(string: "shortcuts://") {
                    UIApplication.shared.open(url)
                } // IF LET
            }, label: {
                HStack {
                    Text("Open Shortcuts app")
                    Spacer()
                    Image(systemName: "arrow.up.right")
                } // HSTACK
            }) // BUTTON + label
            Button(action: {
                withAnimation() {
                    settingsIsPresented = false
                    introCurrentPage = 1
                    introIsPresented = true
                } // WITH ANIMATION
            }, label: {
                HStack {
                    Text("Show help again")
                    Spacer()
                    Image(systemName: "questionmark")
                } // HSTACK
            }) // BUTTON + label
        }, header: {
            Text("General")
        }) // SECTION + header
        
        Section(content: {
            VStack {
                HStack {
                    Spacer()
                    Image("ClipboardIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 125, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    Spacer()
                } // HSTACK
                HStack {
                    Spacer()
                    Text("Clipboard")
                    .font(.system(size: 25, weight: .bold))
                    Spacer()
                } // HSTACK
                HStack {
                    Spacer()
                    Text("Made by @ddvniele")
                    .foregroundStyle(.secondary)
                    Spacer()
                } // HSTACK
            } // VSTACK
            .padding(.vertical, 15)
            
            Button(action: {
                if let url = URL(string: "https://ddvniele.github.io") {
                    UIApplication.shared.open(url)
                } // IF LET
            }, label: {
                HStack {
                    Text("Dan's House ツ")
                    Spacer()
                    Image(systemName: "arrow.up.right")
                } // HSTACK
            }) // BUTTON + label
            
            Button(action: {
                if let url = URL(string: "https://github.com/ddvniele/Clipboard") {
                    UIApplication.shared.open(url)
                } // IF LET
            }, label: {
                HStack {
                    Text("Project on GitHub")
                    Spacer()
                    Image(systemName: "arrow.up.right")
                } // HSTACK
            }) // BUTTON + label
            
            Button(action: {
                if let url = URL(string: "https://github.com/ddvniele") {
                    UIApplication.shared.open(url)
                } // IF LET
            }, label: {
                HStack {
                    Text("@ddvniele on GitHub")
                    Spacer()
                    Image(systemName: "arrow.up.right")
                } // HSTACK
            }) // BUTTON + label
        }, header: {
            Text("Info")
        }) // SECTION + header
    } // VAR BODY
} // STRUCT SETTINGS VIEW
