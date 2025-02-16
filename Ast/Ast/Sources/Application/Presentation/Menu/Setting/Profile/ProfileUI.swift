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
                case .region : RegionItem(store: store)
                case .time : TimeItem(store: store)
                }
                
                Text("🚨 회원 정보를 변경한 경우 다음 운세부터 반영이 돼요.")
                    .fontColor(.l1, color: .b1)
                    .padding(.top, 60)
                    .padding(.horizontal, 30)
                    .isHidden(profileType == .name)
                
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
                .environment(\.locale, Locale(identifier: "ko_KR"))
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

struct RegionItem: View {
    let store: StoreOf<ProfileUIFeature>
    
    @State private var selectedProvince: String = "서울특별시"
    @State private var selectedCity: String = "강남구"
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 0) {
                    Picker("광역시/도", selection: $selectedProvince) {
                        ForEach(Locations.regionsKR.keys.sorted(), id: \.self) { province in
                            Text(province).tag(province)
                        }
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: selectedProvince) { newValue in
                        if let firstCity = Locations.regionsKR[newValue]?.first {
                            selectedCity = firstCity
                            
                            viewStore.send(.setRegion("\(selectedProvince) \(selectedCity)"))
                        }
                    }
                    .frame(width: 200)
                    
                    Picker("시/군/구", selection: $selectedCity) {
                        ForEach(Locations.regionsKR[selectedProvince] ?? [], id: \.self) { city in
                            Text(city).tag(city)
                        }
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: selectedCity) { _ in
                        viewStore.send(.setRegion("\(selectedProvince) \(selectedCity)"))
                    }
                    
                }
                .padding(.top, 30)
            }
        }
    }
}

struct TimeItem: View {
    let store: StoreOf<ProfileUIFeature>
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    let hours = Array(0..<24)
    let minutes = Array(0..<60)
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 6) {
                    Picker("시간", selection: $selectedHour) {
                        ForEach(hours, id: \.self) { hour in
                            Text(String(format: "%02d", hour))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .onChange(of: selectedHour) { newValue in
                        viewStore.send(.setTime("\(String(format: "%02d", selectedHour))" + ":" + "\(String(format: "%02d", selectedMinute))"))
                    }
                    
                    Text(":")
                    Picker("분", selection: $selectedMinute) {
                        ForEach(minutes, id: \.self) { minute in
                            Text(String(format: "%02d", minute))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .onChange(of: selectedMinute) { newValue in
                        viewStore.send(.setTime("\(String(format: "%02d", selectedHour))" + ":" + "\(String(format: "%02d", selectedMinute))"))
                    }
                }
            }
            .padding(.top, 45)
            .padding(.horizontal, 60)
        }
    }
}

#Preview {
    ProfileUI(profileType: .name)
}
