//
//  IntroView.swift
//  Clipboard
//
//  Created by dan on 11/08/24.
//

import SwiftUI

struct IntroFirstPageView: View {
    
    let buttonFeedback = UIImpactFeedbackGenerator(style: .light)
    @Binding var introCurrentPage: UInt8
    
    var body: some View {
        VStack {
            Image("ClipboardIcon")
            .resizable()
            .scaledToFill()
            .frame(width: 125, height: 125)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Text("Welcome to Clipboard")
            .font(.system(size: 25, weight: .bold))
            .multilineTextAlignment(.center)
            Text("A new place to organize copy & paste")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        } // VSTACK
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .center)
        .overlay(IntroButtonView(label: "Let's start", forward: true, altStyle: true, disabled: false, action: {
            withAnimation() {
                buttonFeedback.impactOccurred()
                introCurrentPage = 2
            } // WITH ANIMATION
        }).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 25))
    } // VAR BODY
} // STRUCT INTRO FIRST PAGE VIEW

struct IntroSecondPageView: View {
    
    let buttonFeedback = UIImpactFeedbackGenerator(style: .light)
    @Binding var introCurrentPage: UInt8
    
    var body: some View {
        VStack {
            Image(systemName: "paperclip")
            .font(.system(size: 75, weight: .light))
            .foregroundStyle(.purple)
            Text("Easy to manage your Clipboard")
            .font(.system(size: 25, weight: .bold))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            Text("Try to add an item with the button below, and manage it by swiping left or right or long-pressing it")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
        } // VSTACK
        .frame(maxHeight: .infinity, alignment: .center)
        .overlay(IntroButtonView(label: "Next", forward: true, altStyle: true, disabled: false, action: {
            withAnimation() {
                buttonFeedback.impactOccurred()
                introCurrentPage = 3
            } // WITH ANIMATION
        }).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 25))
    } // VAR BODY
} // STRUCT INTRO SECOND PAGE VIEW

struct IntroThirdPageView: View {
    
    let buttonFeedback = UIImpactFeedbackGenerator(style: .light)
    @Binding var introCurrentPage: UInt8
    
    var body: some View {
        VStack {
            Image(systemName: "trash")
            .font(.system(size: 75, weight: .light))
            .foregroundStyle(.purple)
            Text("Find items you moved to the Trash with the top-right menu button")
            .font(.system(size: 25, weight: .bold))
            .multilineTextAlignment(.center)
            Text("Just click on the top-right three dots menu to access the Trash. Try it now!")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        } // VSTACK
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .center)
        .overlay(
            IntroButtonView(label: "Next", forward: true, altStyle: true, disabled: false, action: {
                withAnimation() {
                    buttonFeedback.impactOccurred()
                    introCurrentPage = 4
                } // WITH ANIMATION
            }).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 25)
        ) // OVERLAY
    } // VAR BODY
} // STRUCT INTRO THIRD PAGE VIEW

struct IntroFourthPageView: View {
    
    let buttonFeedback = UIImpactFeedbackGenerator(style: .light)
    @Binding var introCurrentPage: UInt8
    
    var body: some View {
        VStack {
            Image(systemName: "gear")
            .font(.system(size: 75, weight: .light))
            .foregroundStyle(.purple)
            Text("Access the Settings of your Clipboard with the top-right menu button")
            .font(.system(size: 25, weight: .bold))
            .multilineTextAlignment(.center)
            Text("In the same way, you can access the Settings page from the same three dots menu. Try it now!")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        } // VSTACK
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .center)
        .overlay(
            IntroButtonView(label: "Next", forward: true, altStyle: true, disabled: false, action: {
                withAnimation() {
                    buttonFeedback.impactOccurred()
                    introCurrentPage = 5
                } // WITH ANIMATION
            }).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 25)
        ) // OVERLAY
    } // VAR BODY
} // STRUCT INTRO FOURTH PAGE VIEW

struct IntroFifthPageView: View {
    
    let buttonFeedback = UIImpactFeedbackGenerator(style: .light)
    @Binding var introIsPresented: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "square.stack.3d.up")
            .font(.system(size: 75, weight: .light))
            .foregroundStyle(.purple)
            Text("Integrate your Clipboard with the Shortcuts app")
            .font(.system(size: 25, weight: .bold))
            .multilineTextAlignment(.center)
            Text("It's really easy to automate your Clipboard by configuring your personalized shortcuts from the Shortcuts app. Try opening the Shortcuts app and see what you can do with it!")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            Button(action: {
                if let url = URL(string: "shortcuts://") {
                    UIApplication.shared.open(url)
                } // IF LET
            }, label: {
                HStack {
                    Text("Open Shortcuts app")
                    Image(systemName: "arrow.up.right")
                } // HSTACK
            }) // BUTTON + label
            .foregroundStyle(.purple)
            .padding(.vertical, 10)
            Text("You can also run some actions like adding something to Clipboard through Spotlight or by asking to Siri")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        } // VSTACK
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .center)
        .overlay(IntroButtonView(label: "Done!", forward: false, altStyle: true, disabled: false, action: {
            buttonFeedback.impactOccurred()
            withAnimation() {
                introIsPresented = false
            } // WITH ANIMATION
        }).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 25))
    } // VAR BODY
} // STRUCT INTRO FIFTH PAGE VIEW

struct IntroButtonView: View {
    
    var label: String
    var forward: Bool
    var altStyle: Bool
    var disabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 17.5)
                .foregroundStyle(altStyle ? .gray : .purple)
                .opacity(altStyle ? 0.25 : 1.0)
                HStack {
                    Text(label)
                        .fontWeight(.medium)
                    if forward {
                        Spacer()
                        Image(systemName: "arrow.right")
                    } // IF
                } // HSTACK
                .foregroundStyle(altStyle ? .purple : .white)
                .padding(.horizontal, 20)
            } // ZSTACK
            .frame(width: 315, height: 55)
        }) // BUTTON + label
        .buttonStyle(ButtonBounce())
        .disabled(disabled)
    } // VAR BODY
} // STRUCT INTRO BUTTON VIEW

struct ButtonBounce: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .scaleEffect(configuration.isPressed ? 0.975 : 1.0)
    } // FUNC MAKE BODY
} // STRUCT BUTTON BOUNCE
