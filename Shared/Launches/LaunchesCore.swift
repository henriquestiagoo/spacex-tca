//
//  LaunchesCore.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import Combine
import ComposableArchitecture

struct LaunchesState: Equatable {
    var launches: [Launch] = []
    var favoriteLaunches: [Launch] = []
}

enum LaunchesAction: Equatable {
    case onAppear
    case launchesResponse(Result<[Launch], APIError>)
    case favoriteButtonTapped(Launch)
}

struct LaunchesEnvironment {
    var launchesRequest: (JSONDecoder) -> Effect<[Launch], APIError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var decoder: JSONDecoder
}

let launchesReducer = Reducer<LaunchesState, LaunchesAction, LaunchesEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        return environment.launchesRequest(environment.decoder)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(LaunchesAction.launchesResponse)
        
    case .launchesResponse(.success(let launches)):
        print("\n## Launches: \(launches)")
        state.launches = launches
        return .none
        
    case .launchesResponse(.failure(let error)):
        print("\n## Error: \(error)")
        return .none
    
    case .favoriteButtonTapped(let launch):
        if state.favoriteLaunches.contains(launch) {
            state.favoriteLaunches.removeAll { $0 == launch }
        } else {
            state.favoriteLaunches.append(launch)
        }
        return .none
    }
}
