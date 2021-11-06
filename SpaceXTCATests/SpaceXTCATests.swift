//
//  SpaceXTCATests.swift
//  SpaceXTCATests
//
//  Created by Tiago Henriques on 06/11/2021.
//

@testable import SpaceXTCA
import XCTest
import ComposableArchitecture

class SpaceXTCATests: XCTestCase {

    let testScheduler = DispatchQueue.test

    let testLaunches: [Launch] = [
        Launch(id: "1", name: "Launch 1", dateUtc: "2006-03-24T22:30:00.000Z", success: false, flightNumber: 1),
        Launch(id: "2", name: "Launch 2", dateUtc: "2006-03-24T22:30:00.000Z", success: false, flightNumber: 2)
    ]

    func testLaunchesEffect(decoder: JSONDecoder) -> Effect<[Launch], APIError> {
        return Effect(value: testLaunches)
    }
    
    func testFavoriteButtonTapped() {
        let store = TestStore(
            initialState: LaunchesState(),
            reducer: launchesReducer,
            environment: LaunchesEnvironment(
                launchesRequest: testLaunchesEffect,
                mainQueue: self.testScheduler.eraseToAnyScheduler(),
                decoder: JSONDecoder()
            )
        )
        
        guard let testLaunch = testLaunches.first else {
            fatalError("Error in test setup")
        }
        store.send(.favoriteButtonTapped(testLaunch)) { state in
            state.favoriteLaunches.append(testLaunch)
        }
    }
    
    func testOnAppear() {
        let store = TestStore(
            initialState: LaunchesState(),
            reducer: launchesReducer,
            environment: LaunchesEnvironment(
                launchesRequest: testLaunchesEffect,
                mainQueue: self.testScheduler.eraseToAnyScheduler(),
                decoder: JSONDecoder()
            )
        )
        
        store.send(.onAppear)
        testScheduler.advance()
        store.receive(.launchesResponse(.success(testLaunches))) { state in
            state.launches = self.testLaunches
        }
    }

}
