//
//  HomeFeature.swift
//  Ast
//
//  Created by 변윤나 on 1/25/25.
//

import Foundation
import ComposableArchitecture
import UIKit

@Reducer
struct HomeFeature {
    enum LeadType: String, CaseIterable {
        case daily = "일일"
        case monthly = "월간"
        case yearly = "년간"
    }
    
    struct LeadDaily: Equatable, Hashable {
        let rank: Int
        let astroNm: String
        let content: String
        let luckyKey: String
        let luckyColor: String
        let luckyWord: String
        let luckyFood: String
        
        //MockData
        init(rank: Int, astroNm: String, content: String, luckyKey: String, luckyColor: String, luckyWord: String, luckyFood: String) {
            self.rank = rank
            self.astroNm = astroNm
            self.content = content
            self.luckyKey = luckyKey
            self.luckyColor = luckyColor
            self.luckyWord = luckyWord
            self.luckyFood = luckyFood
        }
    }
    
    struct State: Equatable, Hashable {
        @PresentationState var isSelection: HomeFeature.State?
        var isLandscape = UIDevice.current.orientation.isLandscape //가로 : true, 세로 : false
        var selectedTab: LeadType = .daily
        let currentMonthlydate = Date()
        var leadDays: [LeadDaily] = []
        var isLike:Bool = false
        var isLikeImagenamed:String = "heart"

    }
    
    enum Action: Equatable {
        case viewAppeared
        case selectTab(LeadType)
        case toAllMenuTapped
        case setDailyLead
        case orientationChanged(Bool)
        case toLikeTapped
        case toShareTapped
        case toDownloadTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
            case .toAllMenuTapped:
                print("전체메뉴")
                return .none
            case .setDailyLead:
                let mockData: [LeadDaily] = [
                    LeadDaily(rank: 1, astroNm: "aries", content: "오늘은 내면의 강한 힘을 느낄 수 있는 하루입니다. 직관과 감정이 잘 맞아떨어지는 날입니다. 애정운에서는 상대방과의 신뢰가 중요한 하루입니다. 금전적으로는 계획을 세워 지출을 조절하는 것이 중요합니다. 건강은 무리하지 않고 가벼운 운동이 좋습니다.", luckyKey: "목도리", luckyColor: "아이보리", luckyWord: "ㅈ", luckyFood: "핫도그"),
                    LeadDaily(rank: 2, astroNm: "virgo", content: "오늘은 감정적인 기복이 있을 수 있습니다. 과도한 생각이나 감정에 휘둘리지 않도록 신경 쓰세요. 애정운에서는 오해가 생기기 쉬운 하루입니다. 금전적으로는 작은 지출이 누적될 수 있으니 신중해야 합니다. 건강은 불규칙한 생활로 피로가 쌓일 수 있으니 주의하세요.", luckyKey: "우산", luckyColor: "회색", luckyWord: "ㅁ", luckyFood: "떡국"),
                    LeadDaily(rank: 3, astroNm: "gemini", content: "오늘은 일상에서 작은 변화가 생길 수 있는 날입니다. 예기치 않은 일이 일어나더라도 차분히 대처하면 좋은 결과를 얻을 수 있습니다. 애정운에서는 서로의 마음을 잘 헤아려야 합니다. 금전적으로는 지나친 소비를 피하는 것이 중요합니다. 건강은 무리하지 않는 선에서 좋은 상태를 유지할 수 있습니다.", luckyKey: "스마트폰", luckyColor: "연보라색", luckyWord: "ㅇ", luckyFood: "찌개"),
                    LeadDaily(rank: 4, astroNm: "sagittarius", content: "오늘은 조금 더 차분히 생각하고 결정해야 할 날입니다. 급한 결정을 내리지 않도록 주의하세요. 애정운에서는 약간의 거리감이 느껴질 수 있습니다. 금전적으로는 지출을 자제하고, 필요한 것만 구매하세요. 건강은 하루 중 지칠 수 있으니 충분한 휴식이 필요합니다.", luckyKey: "텀블러", luckyColor: "레드", luckyWord: "ㅅ", luckyFood: "순두부찌개"),
                    LeadDaily(rank: 5, astroNm: "scorpio", content: "오늘은 집중력이 강한 하루입니다. 중요한 일에 집중하여 성과를 올릴 수 있습니다. 애정운에서는 상대방의 입장을 고려한 배려가 필요합니다. 금전적으로는 예상치 못한 지출이 생길 수 있으니 예산을 세워 신중하게 소비하세요. 건강은 적당한 운동이 필요합니다.", luckyKey: "헤어핀", luckyColor: "흰색", luckyWord: "ㅂ", luckyFood: "떡볶이"),
                    LeadDaily(rank: 6, astroNm: "pisces", content: "오늘은 창의적이고 직관적인 힘이 솟구치는 날입니다. 감정적으로도 안정감을 느끼며, 중요한 결정을 내리기에 좋은 순간입니다. 애정운에서는 상대방의 진심을 알게 되어 더욱 가까워질 수 있습니다. 금전적으로는 나쁜 기회보다는 좋은 기회를 잡는 데 집중하세요. 건강은 활기차고 긍정적입니다.", luckyKey: "카드지갑", luckyColor: "하늘색", luckyWord: "ㅅ", luckyFood: "김치전"),
                    LeadDaily(rank: 7, astroNm: "libra", content: "오늘은 집중력과 성실함으로 좋은 결과를 얻을 수 있는 날입니다. 직장에서의 성과가 있을 수 있습니다. 애정운에서는 솔직한 대화가 중요합니다. 금전적으로는 예산을 잘 세워 지출을 조절하세요. 건강은 조금 지친 느낌이 있을 수 있으니 휴식이 필요합니다.", luckyKey: "스케줄러", luckyColor: "연두색", luckyWord: "ㅅ", luckyFood: "돈까스")
                ]
                state.leadDays = mockData
                return .none
            case .toLikeTapped:
                state.isLike = true
//                state.isLikeImagenamed = state.isLike ? "heart.fill" : "heart"
                return .none
            case .toShareTapped:
                print("공유하기")
                return .none
            case .toDownloadTapped:
                print("사진첩에 저장")
                return .none
            case .orientationChanged(let isLandscape):
                state.isLandscape = isLandscape
                return .none
            }
        }
    }
}
