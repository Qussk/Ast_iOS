//
//  SignUpUI.swift
//  Ast
//
//  Created by 변윤나 on 2/13/25.
//

import SwiftUI
import ComposableArchitecture

struct SignUpUI: View {
    let store: StoreOf<SignUpFeature> = Store(initialState: SignUpFeature.State()) { SignUpFeature() }
    @Environment(\.dismiss) private var dismiss

    @State var birth: String = ""
    @State var time: String = ""
    @State var region: String = ""
    @State var gender: UserType.Gender = .none

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                Color.black.opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack(alignment: .leading) {
                    
                    SignUpUserItem(
                        store: store,
                        birth: $birth,
                        time: $time,
                        region: $region,
                        gender: $gender
                    )
                    SignUpTermsItem(store: store)
                    
                    Button(action: {
                        viewStore.send(.confirm(birth: birth, gender: gender, time: time, region: region))
                        if viewStore.isColosed {
                            dismiss()
                        }
                    }) {
                        Text("확인")
                            .frame(height: 54)
                            .frame(maxWidth: .infinity)
                            .fontColor(.h4, color: .w1, background: .c1)
                            .cornerRadius(8)
                            .padding(.horizontal, 18)
                            .padding(.bottom, 15)
                    }
                    .padding(.top, 20)

                }
                .frame(maxWidth: .infinity, maxHeight: 390)
                .background(
                    Color.white
                        .cornerRadius(16)
                )
                .padding(.horizontal, 18)

            }
            .ignoresSafeArea()
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}


struct SignUpUserItem: View {
    let store: StoreOf<SignUpFeature>
    @Binding var birth: String
    @Binding var time: String
    @Binding var region: String
    @Binding var gender: UserType.Gender
    
    let isValid = ValidHelper()

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("회원님, 어서오세요!")
                        .fontColor(.h1, color: .black)
                        .padding(.top, 20)
                    
                    Text("정확한 운세를 위해 고객님 정보를 수집할게요.🙏\n정보를 입력 할수록 운세가 더욱 정확해져요.")
                        .fontColor(.h8, color: .black)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 18)
                
                
                HStack(spacing: 10) {
                    Text("생년월일 ")
                        .fontColor(.h5, color: .black)
                    VStack(spacing: 4) {
                        TextField("19920406",text: $birth)
                            .fontColor(.h5, color: .black)
                            .textFieldStyle(.plain)
                            .keyboardType(.numberPad)
                            .onChange(of: birth) { text in
                                if text.count >= 8 {
                                    hideKeyboard()
                                }
                            }
                        Rectangle()
                            .fill(Color.b3)
                            .frame(height: 1.5)
                    }
                    .frame(width: 90)
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.c1)
                        .isHidden(!isValid.isValidBirthDate(birth))
                }.padding(.horizontal, 30)

                
                HStack(spacing: 10) {
                    Text("성별 ")
                        .fontColor(.h5, color: .black)
                        .padding(.trailing, 12)
                    Button {
                        gender = .female
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: gender == .female ? .c1 : .b2)
                        Text("여자")
                            .fontColor(.h6, color: gender == .female ? .c1 : .b2)
                    }
                    Button {
                        gender = .male
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: gender == .male ? .c1 : .b2)
                        Text("남자")
                            .fontColor(.h6, color: gender == .male ? .c1 : .b2)
                    }
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.c1)
                        .isHidden(gender == .none ? true : false)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 15)

                
//                HStack(spacing: 10) {
//                    Text("태어난 시 ")
//                        .fontColor(.h5, color: .black)
//                    VStack(spacing: 4) {
//                        TextField("17:30", text: $time)
//                            .fontColor(.h5, color: .black)
//                            .textFieldStyle(.plain)
//                            .onChange(of: time) { text in
//                                if isValid.isValidTime(time) {
//                                    hideKeyboard()
//                                }
//                            }
//                        Rectangle()
//                            .fill(Color.b3)
//                            .frame(height: 1.5)
//                    }
//                    .frame(width: 80)
//                    Button {
//                        time = ""
//                    } label: {
//                        Image(systemName: "button.programmable")
//                            .fontColor(.h6, color: time == "" ? .c1 : .b2)
//                        Text("모름")
//                            .fontColor(.h6, color: time == "" ? .c1 : .b2)
//                            .padding(.leading, -4)
//                    }
//                    Image(systemName: "checkmark.seal.fill")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                        .foregroundColor(.c1)
//                        .isHidden(!isValid.isValidTime(time) ? true : false)
//                }
//                .padding(.horizontal, 30)
//
//                
//                HStack(spacing: 10) {
//                    Text("출생지")
//                        .fontColor(.h5, color: .black)
//                    VStack(spacing: 4) {
//                        TextField("서울특별시 강남구",text: $region)
//                            .fontColor(.h5, color: .black)
//                            .textFieldStyle(.automatic)
//                        Rectangle()
//                            .fill(Color.b3)
//                            .frame(height: 1.5)
//                    }
//                    .frame(width: 130)
//                    Button {
//                        region = ""
//                    } label: {
//                        Image(systemName: "button.programmable")
//                            .fontColor(.h6, color: region == "" ? .c1 : .b2)
//                        Text("나중에")
//                            .fontColor(.h6, color: region == "" ? .c1 : .b2)
//                            .padding(.leading, -4)
//                    }
//                    Image(systemName: "checkmark.seal.fill")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                        .foregroundColor(.c1)
//                        .isHidden(region.count > 5 ? false : true)
//                }
//                .padding(.leading, 30)
//                .padding(.trailing, 10)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct SignUpTermsItem: View {
    let store: StoreOf<SignUpFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 10) {

                HStack {
                    Button {
                        viewStore.send(.personalCheck)
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: viewStore.isPersonal ? .c1 : .b2)
                    }
                    Button {
                        viewStore.send(.goTo(.personal))
                    } label: {
                        Text("(필수)\(WebUIType.personal.rawValue)")
                            .fontColor(.h7, color: .black)
                    }
                }
                
                HStack {
                    Button {
                        viewStore.send(.marketingCheck)
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: viewStore.isMarketing ? .c1 : .b2)
                    }
                    Button {
                        viewStore.send(.goTo(.marketing))
                    } label: {
                        Text("(필수)\(WebUIType.marketing.rawValue)")
                            .fontColor(.h7, color: .black)
                    }
                }
            }
            .padding(.top, 18)
            .padding(.horizontal, 20)
            .fullScreenCover(store: store.scope(state: \.$toPersonal, action: { .toPersonal($0) }), content: {
                store in
                WebUI(store: store)
                    .navigationBarBackButtonHidden()
            })
            .fullScreenCover(store: store.scope(state: \.$toMarketing, action: { .toMarketing($0) }), content: {
                store in
                WebUI(store: store)
                    .navigationBarBackButtonHidden()
            })
        }
    }
}

