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
            ZStack {
                Color(.systemBackground)
                VStack {
                    HomeTopUI()
                    HomeLeadTabUI(selectedTab: viewStore.selectedTab) { tab in
                        viewStore.send(.selectTab(tab))
                    }
                    DailyItemUI()
                    Spacer()
                }
            }
            .padding(0)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }
}

fileprivate struct HomeTopUI: View {
    let store: StoreOf<HomeFeature> = Store(initialState: HomeFeature.State()) { HomeFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottomTrailing) {
                Color.orange
                
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        viewStore.send(.toAllMenuTapped)
                    } label: {
                        Image("menu_icon")
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 8)
            }
            .frame(height: 96)
            .padding(.bottom, 0)
        }
    }
}

//MARK: 홈탭 - 일일,월간,년간
fileprivate struct HomeLeadTabUI: View {
    var selectedTab: HomeFeature.LeadType
    let action: ((HomeFeature.LeadType) -> Void)
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            HStack(spacing: 0) {
                HomeLeadTabButton(title: LeadType.daily.rawValue, isSelected: selectedTab == .daily) {
                    action(.daily)
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

