//
//  MenuTop.swift
//  Ast
//
//  Created by 변윤나 on 2/1/25.
//

import SwiftUI
import ComposableArchitecture

struct MenuTop: View {
    let store: StoreOf<AllMenuUIFeature>
//    @State private var progress: CGFloat = 0.25
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("#기본 님")
                            .fontColor(.h1, color: .t1)
                        Spacer()
                        FlagBubbleView()
                    }
                    
                    HStack(spacing: 10) {
                        MenuTopItem(atrNm: "\(AstroTyp.getZodiacSign(birthDate: UserDefaults.userBirth)?.rawValue ?? "")")
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 10) {
                                Image(UserDefaults.userGender == 0 ? "gender0" : "gender1")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .padding(.leading, 10)
                                Text(UserDefaults.userBirth.tobirthDateDots)
                                    .fontColor(.h5, color: .t1)
                                Spacer()
                            }
                            HStack(spacing: 10) {
                                Button {
                                    
                                } label: {
                                    Text(UserDefaults.userRegion != "" ?  UserDefaults.userRegion : "출생지")
                                        .fontColor(.h5, color: .t1)
                                        .underline(UserDefaults.userRegion == "")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text(UserDefaults.userTime != "" ?  UserDefaults.userTime : "태어난 시")
                                        .fontColor(.h5, color: .t1)
                                        .underline(UserDefaults.userTime == "")
                                }
                            }
                        }
                        
                        Spacer()
                        
                        CircularGaugeView(progress: progress())
                            .padding()
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 18)
            }
        }
    }
    
    private func progress() -> CGFloat {
        let values = [UserDefaults.userTime, UserDefaults.userRegion]
        let nonNilCount = values.filter { !$0.isEmpty }.count
        let score = max(100 - (2 - nonNilCount) * 25, 0)
        return CGFloat(score) / 100.0
    }
}

struct MenuTopItem: View {
    var atrNm = ""
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 46, height: 46)
                .cornerRadius(23)
            
            Text(atrNm.getEmoji())
                .font(.system(size: 24))
                .frame(width: 24, height: 24)
            
            Text(atrNm.getSymbol())
                .font(.system(size: 12))
                .padding(6)
                .offset(x: 18, y: 15)
        }
        .padding(.trailing, 16)
        .padding(.leading, 10)
    }
}

struct CircularGaugeView: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(Color.gray.opacity(0.3))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.red)
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .fontColor(.c3, color: .b2)
        }
        .frame(width: 50, height: 50)
    }
}


struct FlagBubbleView: View {
    @State private var isVisible = true
    @State private var myColor:Color = .orange

    var body: some View {
        VStack {
            if isVisible {
                ZStack {
                    Text("👀 정보를 입력하여 프로필을 완성해 주세요!")
                        .padding(8)
                        .background(myColor)
                        .foregroundColor(.white)
                        .font(.tiny3)
                        .cornerRadius(10)
                        .scaleEffect(isVisible ? 1.0 : 0.0)  // 크기 애니메이션
                        .opacity(isVisible ? 1.0 : 0.0)  // 투명도 애니메이션
                        .animation(.easeOut(duration: 1), value: isVisible) // 애니메이션 효과
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                withAnimation {
                                    self.isVisible = false
                                }
                            }
                        }
                    
                        TriangleShape(triangleSize: 10)
                            .fill(myColor)
                            .frame(width: 10, height: 12)
                            .offset(x: 40, y: 30) // 위치 조정하여 말풍선 오른쪽 하단에 배치
                }
            }
        }
        .padding(.vertical, -10)
        .padding(.trailing, 20)
        .onAppear {
            myColor = Color.fromHex(hex: UserDefaults.myColor)
        }
    }
}

struct TriangleShape: Shape {
    var triangleSize: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY)) // 삼각형의 꼭짓점 (아래)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // 왼쪽 상단
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // 오른쪽 상단
        path.closeSubpath() // 삼각형 닫기
        
        return path
    }
}
