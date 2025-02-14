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

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                Color.black.opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack(alignment: .leading) {
                    
                    SignUpUserItem(store: store)
                    SignUpTermsItem(store: store)
                    
                    Button(action: {
                        
                    }) {
                        Text("확인")
                            .frame(height: 54)
                            .frame(maxWidth: .infinity)
                            .fontColor(.h4, color: .w1, background: .c1)
                            .cornerRadius(8)
                            .padding(.horizontal, 18)
                            .padding(.bottom, 10)
                    }
                    .padding(.top, 10)

                }
                .frame(maxWidth: .infinity, maxHeight: 460)
                .background(
                    Color.white
                        .cornerRadius(16)
                )
                .padding(.horizontal, 18)

            }
            .ignoresSafeArea()
        }
    }
}


struct SignUpUserItem: View {
    let store: StoreOf<SignUpFeature>
    @State var birth: String?
    @State var time: String?
    @State var region: String?

    let isValid = ValidHelper()

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("#기본님, 어서오세요!")
                        .fontColor(.h1, color: .black)
                        .padding(.top, 20)
                    
                    Text("정확한 운세를 위해 고객님 정보를 수집할게요.🙏")
                        .fontColor(.h8, color: .black)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 18)
                
                
                HStack(spacing: 10) {
                    Text("생년월일 ")
                        .fontColor(.h5, color: .black)
                    VStack(spacing: 4) {
                        TextField("19920406",text: viewStore.binding(get: { $0.birth },send: { SignUpFeature.Action.binding(.set(\.$birth, $0)) }))
                            .fontColor(.h5, color: .black)
                            .textFieldStyle(.plain)
//                            .id("birth-\(viewStore.birth)")
                            .keyboardType(.numberPad)
//                            .onChange(of: viewStore.birth) { text in
//                                viewStore.send(.onChangeBirthTF(text))
////                                birth = viewStore.birth
////                                viewStore.send(.onChangeTextField(SignUpFeature.filedType.birth, text))
//                                    if text.count >= 8 {
////                                        hideKeyboard()
//                                    }
//                            }

                        Rectangle()
                            .fill(Color.b3)
                            .frame(height: 1.2)
                        
                    }
                    .frame(width: 100)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.c1)
                        .isHidden(!isValid.isValidBirthDate(viewStore.birth))

                }.padding(.horizontal, 30)

                HStack(spacing: 10) {
                    Text("성별 ")
                        .fontColor(.h5, color: .black)
                        .padding(.trailing, 12)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: .b2)
                        Text("남자")
                            .fontColor(.h6, color: .b2)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .fontColor(.h6, color: .b2)
                        Text("여자")
                            .fontColor(.h6, color: .b2)
                    }
                }.padding(.horizontal, 30)

                
                HStack(spacing: 10) {
                    Text("태어난 시 ")
                        .fontColor(.h5, color: .black)
                    VStack(spacing: 4) {
                        TextField("17:30",text: viewStore.binding(get: { $0.time },send: { SignUpFeature.Action.binding(.set(\.$time, $0)) }))
                            .fontColor(.h5, color: .black)
                            .textFieldStyle(.plain)
                            .keyboardType(.numberPad)
//                            .onChange(of: viewStore.time) { text in
//                                viewStore.send(.onChangeTextField(SignUpFeature.filedType.time, text))
//                            }
                        Rectangle()
                            .fill(Color.b3)
                            .frame(height: 1.5)
                    }
                    .frame(width: 100)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "button.programmable")
                            .fontColor(.h6, color: .b2)
                        Text("모름")
                            .fontColor(.h6, color: .b2)
                            .padding(.leading, -4)
                    }
                }.padding(.horizontal, 30)

                HStack(spacing: 10) {
                    Text("출생지")
                        .fontColor(.h5, color: .black)
                    VStack(spacing: 4) {
                        TextField("서울특별시 강남구",text: viewStore.binding(get: { $0.region },send: { SignUpFeature.Action.binding(.set(\.$region, $0)) }))
                            .fontColor(.h5, color: .black)
                            .textFieldStyle(.automatic)
//                            .onChange(of: viewStore.region) { text in
//                                viewStore.send(.onChangeTextField(SignUpFeature.filedType.region, text))
//                            }

                        Rectangle()
                            .fill(Color.b3)
                            .frame(height: 1.5)
                    }
                    .frame(width: 150)

                    Button {
                        
                    } label: {
                        Image(systemName: "button.programmable")
                            .fontColor(.h6, color: .b2)
                        Text("나중에")
                            .fontColor(.h6, color: .b2)
                            .padding(.leading, -4)
                    }
                    
                }.padding(.horizontal, 30)
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
                        
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("(필수)\(WebUIType.personal.rawValue)")
                            .fontColor(.h7, color: .black)
                    }
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                    }

                    Button {
                        
                    } label: {
                        Text("(필수)\(WebUIType.marketing.rawValue)")
                            .fontColor(.h7, color: .black)
                    }
                }


            }
            .padding(.top, 18)
            .padding(.horizontal, 20)
        }
    }
}

