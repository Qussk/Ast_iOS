//
//  HomeUI.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import ComposableArchitecture


struct HomeUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HomeTopUI()
                        HomeLeadTabUI(selectedTab: viewStore.selectedTab) { tab in
                            viewStore.send(.selectTab(tab))
                        }
                        switch viewStore.selectedTab {
                        case .daily:
                            DailyUI(store: store)
//                            DailyUI(store: store.scope(state: \.topProxy0, action: { .topProxy0($0) }))
                        case .weekly:
                            WeeklyUI(store: store)
                        case .monthly:
                            MonthlyUI()
                        case .yearly:
                            YearlyUI()
                        }
                        Spacer()
                    }
                }
                .padding(0)
                .edgesIgnoringSafeArea(.top)
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
                .onChange(of: geometry.size) { newSize in
                    let isLandscape = newSize.width > newSize.height
                    viewStore.send(.orientationChanged(isLandscape))
                }
            }
        }
    }
}

fileprivate struct HomeTopUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    @State private var isPresent = false
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottomTrailing) {
                Color.orange
                
                HStack(spacing: 12) {
                    Spacer()
                    Button {
                        viewStore.send(.toGuideTapped)
                        self.isPresent = true

                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }

                    Button {
                        viewStore.send(.toAllMenuTapped)

                    } label: {
                        Image("menu_icon")
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 8)
            }
            .frame(height: viewStore.isLandscape ? 44 : 96)
            .padding(.bottom, 0)
            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            .fullScreenCover(isPresented: $isPresent) {
                GuideUI()
            }
        }
    }
}

//MARK: 홈탭 - 일일,주간,월간,년간
fileprivate struct HomeLeadTabUI: View {
    var selectedTab: HomeFeature.LeadType
    let action: ((HomeFeature.LeadType) -> Void)
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            HStack(spacing: 0) {
                HomeLeadTabButton(title: LeadType.daily.rawValue, isSelected: selectedTab == .daily) {
                    action(.daily)
                }
                HomeLeadTabButton(title: LeadType.weakly.rawValue, isSelected: selectedTab == .weekly) {
                    action(.weekly)
                }
                HomeLeadTabButton(title: LeadType.monthly.rawValue, isSelected: selectedTab == .monthly) {
                    action(.monthly)
                }
                HomeLeadTabButton(title: LeadType.yearly.rawValue, isSelected: selectedTab == .yearly) {
                    action(.yearly)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top, .bottom], -10)
    }
    
    private struct HomeLeadTabButton: View {
        let title: String
        let isSelected: Bool
        let action: (() -> Void)
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Button(title) {
                        action()
                    }
                    .font(isSelected ? .h4 : .h5)
                    .foregroundColor(.t1)
                    .frame(minHeight: 44)
                    .overlay(alignment: .bottom) {
                        
                        if isSelected {
                            Rectangle()
                                .fill(Color.t1)
                                .frame(width: 50, height: 4)
                                .padding(.top, -5)
                        }
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }
}

