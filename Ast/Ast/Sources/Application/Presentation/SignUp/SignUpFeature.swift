//
//  SignUpFeature.swift
//  Ast
//
//  Created by 변윤나 on 2/13/25.
//
import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUpFeature {
    enum Item: Int  {
        case personal = 0
        case marketing
    }

    struct State: Equatable {
        @PresentationState var toPersonal: WebUIFeature.State?
        @PresentationState var toMarketing: WebUIFeature.State?
        var isPersonal: Bool = false
        var isMarketing: Bool = false
        var isColosed: Bool = false
        
    }
    
    enum Action:BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case personalCheck
        case marketingCheck
        case toPersonal(PresentationAction<WebUIFeature.Action>)
        case toMarketing(PresentationAction<WebUIFeature.Action>)
        case goTo(Item)
        case confirm(birth: String, gender: UserType.Gender, time: String, region: String)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .viewAppeared:
                state.isColosed = false
                return .none
            case .personalCheck:
                state.isPersonal.toggle()
                return .none
            case .marketingCheck:
                state.isMarketing.toggle()
                return .none
            case .goTo(let item):
                switch item {
                case .personal:
                    var webUIFeature = WebUIFeature.State(title: WebUIType.personal.rawValue, url: WebURL.isPersonal)
                    webUIFeature.type = .personal
                    state.toPersonal = webUIFeature
                    return .none
                case .marketing:
                    var webUIFeature = WebUIFeature.State(title: WebUIType.marketing.rawValue, url: WebURL.isMarketing)
                    webUIFeature.type = .marketing
                    state.toMarketing = webUIFeature
                    return .none
                }
            case let .confirm(birth, gender, time, region):
                let isVaild = ValidHelper()
                guard isVaild.isValidBirthDate(birth),
                      gender != .none
                else {
                        UIApplication.topmostViewController()?.showToast(message: "정보를 확인해 주세요.")
                return .none }
                
                let personal = state.isPersonal
                let marketing = state.isMarketing

                if !personal || !marketing {
                    UIApplication.topmostViewController()?.showToast(message: "약관에 동의(체크)해 주세요.")
                }
                else {
                    UserDefaults.timeStemp = getCurrentTimeIntervalSince1970()
                    UserDefaults.userBirth = birth
                    UserDefaults.userGender = gender.rawValue
//                    UserDefaults.userTime = time
//                    UserDefaults.userRegion = region
                    UserDefaults.isSignUp = true

                    state.isColosed = true
                }
                
                return .none
            default :
                return .none
            }
        }
        .ifLet(\.$toPersonal, action: \.toPersonal) {
            WebUIFeature()
        }
        .ifLet(\.$toMarketing, action: \.toMarketing) {
            WebUIFeature()
        }
    }
    ///현재 날짜 가져오기
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
}

