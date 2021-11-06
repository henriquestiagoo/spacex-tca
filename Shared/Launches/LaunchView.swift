//
//  LaunchView.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import SwiftUI
import ComposableArchitecture
import SDWebImageSwiftUI

struct LaunchView: View {
    let store: Store<LaunchesState, LaunchesAction>
    let launch: Launch
    @Environment(\.openURL) var openURL
    
    var utcDateFormatter: DateFormatter = {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:mmmZ"
        return utcDateFormatter
    }()
    
    var launchUtcDateValue: Date {
        return utcDateFormatter.date(from: launch.dateUtc) ?? Date()
    }
    
    var body: some View {
        ZStack {
            WithViewStore(self.store) { viewStore in
                ZStack {
                    if launch.success ?? false {
                        Color.green
                            .opacity(0.8)
                            .cornerRadius(10)
                    } else {
                        Color.red
                            .opacity(0.8)
                            .cornerRadius(10)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        WebImage(url: URL(string: launch.links?.patch?.small ?? ""))
                            .resizable()
                            .indicator(.activity(style: .medium))
                            .frame(width: 50, height: 50, alignment: .center)
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("Mission:")
                                    .font(.headline)
                                    .bold()
                                Text(launch.name)
                            }
                            HStack(alignment: .top) {
                                Text("Date:")
                                    .font(.headline)
                                    .bold()
                                Text(launchUtcDateValue, style: .date)
                            }
                            if let details = launch.details {
                                VStack {
                                    Spacer()
                                    Text(details)
                                        .lineLimit(10)
                                }
                            }
                        }
                        Spacer()
                        
                        Button(
                            action: { viewStore.send(.favoriteButtonTapped(launch)) }, label: {
                                if viewStore.favoriteLaunches.contains(launch) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.black)
                                        .frame(width: 40, height: 40, alignment: .center)
                                    
                                } else {
                                    Image(systemName: "heart")
                                        .foregroundColor(.black)
                                        .frame(width: 40, height: 40, alignment: .center)
                                }
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.all, 16)
                }
                .onTapGesture {
                    if let article = launch.links?.article, let url = URL(string: article) {
                        openURL(url)
                    }
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(
            store: Store(
                initialState: LaunchesState(),
                reducer: launchesReducer,
                environment:
                    LaunchesEnvironment(
                        launchesRequest: dummyLaunches,
                        mainQueue: .main,
                        decoder: JSONDecoder()
                    )
            ),
            launch: Launch(id: "1", name: "Launch 1", dateUtc: "2006-03-24T22:30:00.000Z", rocket: "", success: false, links: nil, details: nil, flightNumber: 1))
            .frame(width: UIScreen.main.bounds.width, height: 50)
    }
}
