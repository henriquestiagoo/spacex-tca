//
//  RootView.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<RootState, RootAction>
    
    var body: some View {
        TabView {
            LaunchesView(
                store: self.store.scope(
                    state: \.launchesState,
                    action: RootAction.launchesAction
                )
            )
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Launches")
                }
            
            FavoriteLaunchesView(
                store: self.store.scope(
                    state: \.launchesState,
                    action: RootAction.launchesAction
                )
            )
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite Launches")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let rootView = RootView(
            store: Store(
                initialState: RootState(),
                reducer: rootReducer,
                environment: RootEnvironment(
                    mainQueue: .main,
                    decoder: JSONDecoder()
                )
            )
        )
        return rootView
    }
}
