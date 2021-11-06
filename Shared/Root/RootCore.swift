//
//  RootCore.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import Foundation
import ComposableArchitecture

struct RootState {
    var launchesState = LaunchesState()
}

enum RootAction {
   case launchesAction(LaunchesAction)
}

struct RootEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var decoder: JSONDecoder
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    launchesReducer.pullback(
        state: \.launchesState,
        action: /RootAction.launchesAction,
        environment: { LaunchesEnvironment(
            launchesRequest: launchesEffect,
            mainQueue: $0.mainQueue,
            decoder: $0.decoder)
        }
    )
)
