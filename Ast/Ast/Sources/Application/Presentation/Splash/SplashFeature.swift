//
//  SplashFeature.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import Foundation
import ComposableArchitecture
import Combine
import SwiftUI

@Reducer
struct SplashFeature {
    struct State: Equatable {
        var appDelegate: AppDelegate?
    }
    
    enum Action: Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case goToMain
        case testFetch([TestEntity?])
    }
    
    @Dependency(\.testApi)var testApi

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return .none }
                
                state.appDelegate = appDelegate
                return .run { send in
                    await send(.goToMain)
                    do {
                        await send(.testFetch( try await self.testApi.fetch() ))
                    } catch {
                        print("\(APIError.unowned)")
                    }
                }
            case .goToMain:
                guard let appDelegate = state.appDelegate else { return .none }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    appDelegate.resetRootViewController()
                }
                return .none
            case .testFetch(let live) :
                print(live)
                return .none
            default :
                return .none
            }
        }
    }
}



struct TestAPIProvider  {
    var fetch: () async throws -> [TestEntity]
}

extension TestAPIProvider: DependencyKey {
    static let liveValue = Self(
        fetch: {
            let response = try await Provider<TestTarget>().asyncRequest(.test, entityType: [TestEntity].self)
            return response
        })
}

extension DependencyValues {
    var testApi: TestAPIProvider {
        get { self[TestAPIProvider.self] }
        set { self[TestAPIProvider.self] = newValue }
    }
}

