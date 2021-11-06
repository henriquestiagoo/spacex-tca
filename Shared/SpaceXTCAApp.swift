//
//  SpaceXTCAApp.swift
//  Shared
//
//  Created by Tiago Henriques on 01/11/2021.
//

import SwiftUI
import ComposableArchitecture

@main
struct SpaceXTCAApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootState(),
                    reducer: rootReducer,
                    environment: RootEnvironment(
                        mainQueue: .main,
                        decoder: JSONDecoder()
                    )
                )
            )
        }
    }
}
