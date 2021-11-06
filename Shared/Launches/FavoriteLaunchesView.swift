//
//  FavoriteLaunchesView.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import SwiftUI
import ComposableArchitecture

struct FavoriteLaunchesView: View {
    let store: Store<LaunchesState, LaunchesAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.favoriteLaunches) { launch in
                        LaunchView(
                            store: store,
                            launch: launch
                        )
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("Favorite Launches")
            }
        }
    }
}
struct FavoriteLaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteLaunchesView(
            store: Store(
                initialState: LaunchesState(),
                reducer: launchesReducer,
                environment: LaunchesEnvironment(
                    launchesRequest: dummyLaunches,
                    mainQueue: .main,
                    decoder: JSONDecoder())
            )
        )
    }
}
