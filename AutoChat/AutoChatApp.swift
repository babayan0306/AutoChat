//
//  AutoChatApp.swift
//  AutoChat
//
//  Created by Yurka Babayan on 22.09.23.
//

import SwiftUI
import ComposableArchitecture

@main
struct AutoChatApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView(store: Store(initialState: RegisterReducer.State(), reducer: {
                RegisterReducer()
            }))
        }
    }
}
