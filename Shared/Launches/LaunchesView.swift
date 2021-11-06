//
//  LaunchesView.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import SwiftUI
import ComposableArchitecture

struct LaunchesView: View {
    let store: Store<LaunchesState, LaunchesAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.launches) { launch in
                        LaunchView(
                            store: store,
                            launch: launch
                        )
                    }
                }
                .navigationTitle("Launches")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView(
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
