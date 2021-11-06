//
//  LaunchesEffects.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import Foundation
import ComposableArchitecture

func launchesEffect(decoder: JSONDecoder) -> Effect<[Launch], APIError> {
    guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {
        fatalError("Error on creating url")
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: [Launch].self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

func dummyLaunches(decoder: JSONDecoder) -> Effect<[Launch], APIError> {
    let launches = [
        Launch(id: "1", name: "Launch 1", dateUtc: "2006-03-24T22:30:00.000Z", success: false, flightNumber: 1),
        Launch(id: "2", name: "Launch 2", dateUtc: "2006-03-24T22:30:00.000Z", success: false, flightNumber: 2)
    ]
    return Effect(value: launches)
}

