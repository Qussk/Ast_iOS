//
//  ProfileUI.swift
//  Ast
//
//  Created by 변윤나 on 2/14/25.
//

import SwiftUI
import ComposableArchitecture

struct ProfileUI: View {
    let store: StoreOf<ProfileUIFeature> = Store(initialState: ProfileUIFeature.State(), reducer: { ProfileUIFeature() })
    let profileType: ProfileUIFeature.ProfileType = .name
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    NavigationBarView(title: "") {
                        dismiss()
                    }
                    Button {
                        
                    } label: {
                        Text("완료")
                            .padding(.trailing, 20)
                            .fontColor(.h3, color: viewStore.myColor)
                    }
                }
                
                Text(viewStore.title)
                    .fontColor(.h1, color: .b1)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                switch profileType {
                case .name :
                    NameItem(store: store)
                case .birth : Spacer()
                case .gender : Spacer()
                case .time : Spacer()
                case .region : Spacer()
                }
                Spacer()
            }
            .onAppear {
                viewStore.send(.viewAppeared)
            }
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
        }
    }
}


struct NameItem: View {
    let store: StoreOf<ProfileUIFeature>
    @FocusState var isTextFieldFocused: Bool

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                TextField("8자이하", text: viewStore.$nameText)
                    .fontColor(.h3, color: .black)
                    .focused($isTextFieldFocused)
                    .textFieldStyle(.plain)
                    .onChange(of: viewStore.nameText) { text in
                    }
                    .frame(height: 50)
                
                Rectangle()
                    .fill(viewStore.myColor)
                    .frame(height: 1)
            }
            .padding(.top, 60)
            .padding(.horizontal, 20)
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
}

#Preview {
    ProfileUI()
}
