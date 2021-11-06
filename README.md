# spacex-tca

Hi there! 👋 

This application presents a list of SpaceX launches and it was architected using [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).
It was built as a proof-of-concept to demonstrate how The Composable architecture works and how it can be applied to SwiftUI projects.

It serves as the base of the writing of the blog post ["A Tour of The Composable Architecture with the SpaceX API 🚀"](https://tiagohenriques.vercel.app/blog/spacex-composable-architecture)

This application explores an open source [SpaceX API](https://github.com/r-spacex/SpaceX-API/) 🚀 to fetch launches data.

# Exploring the Composable Architecture
TCA focuses on different aspects around developing applications of different size and complexity. It offers concepts to solve various problems, including:

- **State management:** Each app consists of some sort of state. TCA offers a concept to manage and share state.
- **Composition:** This enables you to develop smaller features in isolation and compose them together to form the whole app.
- **Side effects:** These are often hard to understand and test. TCA tries to change this by defining a way to handle them.
- **Testing:** This is always important and TCA makes it easy to accomplish.
- **Ergonomics:** A framework is available that provides a convenient API to implement all components.

# Understanding the Components of TCA
An application built with TCA consists of five main components that help to model your app:

- **State:** Often, a collection of properties represents the state of an app or a feature spread over many classes. TCA places all relevant properties together in a single type.
- **Actions:** An enumeration including cases for all events that can occur in your app, e.g., when a user taps a button, when a timer fires or an API request returns.
- **Environment:** A type wrapping all dependencies of your app or feature. For example, these can be API clients with asynchronous methods.
- **Reducer:** A function that uses a given action to transform the current state to the next state.
- **Store:** A place your UI observes for changes and where you send actions. Based on these actions, it runs reducers.
