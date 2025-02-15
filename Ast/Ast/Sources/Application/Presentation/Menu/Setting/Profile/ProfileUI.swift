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
    @State var profileType: ProfileUIFeature.ProfileType
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    NavigationBarView(title: "") {
                        dismiss()
                    }
                    Button {
                        viewStore.send(.confirm(profileType))
                        if viewStore.isColsed { dismiss() }
                    } label: {
                        Text("완료")
                            .padding(.trailing, 20)
                            .fontColor(.h3, color: viewStore.myColor)
                    }
                }
                
                Text(viewStore.title)
                    .fontColor(.h1, color: .b1)
                    .padding(.top, 56)
                    .padding(.horizontal, 20)
                
                switch profileType {
                case .name : NameItem(store: store)
                case .gender : GenderItem(store: store)
                case .birth : BirthItem(store: store)
                case .time : Spacer()
                case .region : Spacer()
                }
                
                Text("🚨 회원 정보를 변경한 경우 다음 운세부터 반영이 돼요.").isHidden(profileType == .name)
                    .fontColor(.l1, color: .b1)
                    .padding(.top, 60)
                    .padding(.horizontal, 30)
                
                Spacer()
            }
            .onAppear {
                viewStore.send(.viewAppeared(profileType))
            }
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
            .navigationBarBackButtonHidden()
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
                    .fontColor(.h3, color: .b1)
                    .focused($isTextFieldFocused)
                    .textFieldStyle(.plain)
                    .frame(height: 50)
                
                Rectangle()
                    .fill(viewStore.myColor)
                    .frame(height: 1)
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
}


struct GenderItem: View {
    let store: StoreOf<ProfileUIFeature>
    @State private var selectedGender: String? = nil
    let genders: [(String, String)] = [("gender0", "여성"), ("gender1", "남성")]

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 24) {
                ForEach(genders, id: \.0) { gender in
                    Button(action: {
                        withAnimation {
                            selectedGender = gender.0
                        }
                        viewStore.send(.setGender(gender.0 == "gender0" ? 0 : 1))
                    }) {
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .fill(Color.b3.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedGender == gender.0 ? Color.c1 : Color.clear, lineWidth: 3)
                                    )
                                Image(gender.0)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            Text("\(gender.1)")
                                .fontColor(.tiny2, color: .b1)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
            .onAppear {
                selectedGender = UserDefaults.userGender == 0 ? "gender0" : "gender1"
            }
        }
    }
}


struct BirthItem: View {
    let store: StoreOf<ProfileUIFeature>
    @State private var selectedDate: Date = {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = Int(UserDefaults.userBirth.prefix(4))
        components.month = Int(UserDefaults.userBirth.prefix(6).suffix(2))
        components.day = Int(UserDefaults.userBirth.suffix(2))
        return calendar.date(from: components) ?? Date()
    }()

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: Calendar.current.date(byAdding: .year, value: -100, to: Date())!...Date(),
                    displayedComponents: .date
                )
                .frame(height: 250)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "ko_KR")) // 한국식 날짜 형식
                // 선택한 날짜 표시
//                Text("선택한 날짜: \(formattedDate)")
            }
            .padding(.top, 30)
            .onChange(of: selectedDate) { _ in
                viewStore.send(.setBirth(formattedDate))
            }
        }
    }
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: selectedDate)
    }

}

#Preview {
    ProfileUI(profileType: .name)
}
