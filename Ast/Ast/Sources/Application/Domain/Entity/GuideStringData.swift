//
//  InfomationData.swift
//  Ast
//
//  Created by 변윤나 on 1/29/25.
//

import Foundation


struct GuideStringData: Equatable, Hashable {
    let idx: Int
    let title: String
    let contents: Contents
    
    init(idx: Int, title: String, contents: Contents) {
        self.idx = idx
        self.title = title
        self.contents = contents
    }
}
struct Contents: Equatable, Hashable {
    let subTitle: String
    let contents: [String]
    let subContents: [String]
    
    init(subTitle: String, contents: [String], subContents: [String]) {
        self.subTitle = subTitle
        self.contents = contents
        self.subContents = subContents
    }
}

struct Guide: Hashable {
    ///점성술 용어 : 태양궁,달궁,상숭궁,행성, 황도대,하우스,천궁도,특정기간의 영향등
    static let concept: [GuideStringData] =
    [GuideStringData(
        idx: 0,
        title: "1. 태양궁 (Sun Sign)",
        contents: Contents(
            subTitle: "",
            contents: [
                "태어난 날 기준으로 결정되는 별자리입니다.",
                "흔히 알고 있는 \"12별자리\"가 여기에 해당하며, 사람의 핵심 성격, 자아, 의지를 상징합니다.",
                "예: 양자리, 사자자리, 천칭자리 등"
            ],
            subContents: []
        )
    ),
     GuideStringData(
        idx: 1,
        title: "2. 달궁 (Moon Sign)",
        contents: Contents(
            subTitle: "",
            contents: [
                "태어난 시간과 장소를 기준으로 달이 위치한 별자리입니다.",
                "감정, 내면의 자아, 무의식적인 반응을 나타냅니다.",
                "예: 달이 물고기자리에 있다면 감수성이 풍부하고 상상력이 많다고 해석될 수 있음."
            ],
            subContents: []
        )
     ),
     GuideStringData(
        idx: 2,
        title: "3. 상승궁 (Ascendant, Rising Sign)",
        contents: Contents(
            subTitle: "",
            contents: [
                "태어난 시간에 동쪽 지평선에 떠오른 별자리입니다.",
                "첫인상, 외적인 태도, 타인에게 보이는 모습과 관련됩니다.",
                "예: 상숭궁이 쌍둥이자리라면 사교적이고 호기심이 많아 보일 수 있음."
            ],
            subContents: []
        )
     ),
     GuideStringData(
        idx: 3,
        title: "4. 행성 (Planets)",
        contents: Contents(
            subTitle: "",
            contents: [
                "각 행성은 특정한 성격, 에너지, 주체를 상징합니다. 각 행성이 특정 별자리에 있을 때 그 성격이 영향을 미칩니다."
            ],
            subContents: [
                "태양 : 자아, 생명력",
                "달 : 감정, 내면",
                "수성 : 의사소통, 사고",
                "금성 : 사랑, 미적 감각",
                "화성 : 행동, 욕망",
                "목성 : 행운, 확장",
                "토성 : 책임, 한계",
                "천왕성 : 변화, 혁신",
                "해왕성 : 꿈, 영감",
                "명왕성 : 변형, 재생"
            ]
        )
     ),
     GuideStringData(
        idx: 4,
        title: "5. 황도대 (Zodiac)",
        contents: Contents(
            subTitle: "",
            contents: [
                "12개의 별자리(양자리~물고기자리)가 황도를 따라 배열된 구역을 나타냅니다.",
                "각 별자리는 특정한 성격적 특성과 에너지를 가집니다."
            ],
            subContents: []
        )
     ),
     GuideStringData(
        idx: 5,
        title: "6. 하우스 (House)",
        contents: Contents(
            subTitle: "",
            contents: [
                "점성술 차트에서 하늘을 12개 구역으로 나누어 나타낸 것으로, 각각 삶의 특정 영역을 상징합니다."
            ],
            subContents: [
                "1하우스 (자아, 외모, 첫인상)",
                "2하우스 (돈, 소유, 가치관)",
                "3하우스 (의사소통, 학습, 형제자매)",
                "4하우스 (가족, 집, 뿌리, 안정감) ",
                "5하우스 (창의성, 연애, 즐거움, 자기표현)",
                "6하우스 (일상, 건강, 직업, 봉사)",
                "7하우스 (파트너십, 인간관계, 결혼)",
                "8하우스 (죽음, 변화, 재생, 심리, 깊이 있는 관계)",
                "9하우스 (철학, 여행, 종교, 고등교육)",
                "10하우스 (사회적 명성, 직업, 목표, 야망)",
                "11하우스 (우정, 커뮤니티, 희망, 혁신)",
                "12하우스 (잠재의식, 영성, 꿈, 고독, 희생)"
            ]
        )
     ),
     GuideStringData(
        idx: 6,
        title: "7. 천궁도 (Natal Chart)",
        contents: Contents(
            subTitle: "",
            contents: [
                "태어난 시간과 장소를 기준으로 하늘의 행성과 별자리 위치를 나타낸 지도입니다.",
                "이를 분석하여 개인의 성격, 강점, 약점, 운명을 해석합니다."
            ],
            subContents: []
        )
     ),
     GuideStringData(
        idx: 7,
        title: "8. 특정 기간의 영향",
        contents: Contents(
            subTitle: "",
            contents: [
                "행성과 별자리가 특정 시기나 달마다 다른 별자리에 들어가며 영향을 미칩니다. 이를 \"천체 이동(transits)\" 또는 \"달의 주기(linar cycles)\"로 부릅니다."
            ],
            subContents: [
                "수성 역행(Mercury Retrograde): 수성이 역행 할 때 의사소통 문제, 기술적 오류 등이 자주 일어난다고 여김.",
                "신월(New Moon): 새로운 시작의 에너지.",
                "보름달(Full Moon): 감정의 고조, 성취감."
            ]
        )
     ),
     GuideStringData(
        idx: 8,
        title: "9. 기타 용어",
        contents: Contents(
            subTitle: "",
            contents: [
                "중천궁(Midheaven, MC): 성공, 경력, 사회적 지위와 관련된 별자리.",
                "점성학적 트랜짓(Astrological Transits): 특정 행성이 현재 하늘에서 개인의 천궁도에 미치는 영향.",
                "태양의 귀환(Solar Return): 생일마다 태양이 출생 천궁도의 태양 위치로 돌아오는 것. 새로운 한 해의 테마를 나타냄."
                
            ],
            subContents: [
            ]
        )
     )]
    
    ///하우스
    static let house: [GuideStringData] = [
        GuideStringData(
            idx: 0,
            title: "1 하우스 (Ascendant, 상승궁 포함)",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 자아, 외모, 첫인상, 개성",
                ],
                subContents: [
                    ":🪞💁🏻‍♀️✨",
                    "첫인상, 개인의 외적인 모습, 세상에 보여지는 방식. 자신이 어떤 사람인지 보여주는 '외적 자아'를 상징합니다."
                ]
            )
        ),
        GuideStringData(
            idx: 1,
            title: "2 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 소유, 돈, 물질적 자원, 가치",
                ],
                subContents: [
                    ":💰💎💳",
                    "재정 상황, 소유욕, 물질적인 안정감등 자신이 중요하게 여기는 가치를 나타냅니다."
                ]
            )
        ),
        GuideStringData(
            idx: 2,
            title: "3 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 형재자매, 이웃, 소통, 학습",
                ],
                subContents: [
                    ":💬👬🏼📝",
                    "커뮤니케이션 방식, 일상적 대화, 학습 능력등 가까운 인간관계를 다룹니다."
                ]
            )
        ),
        GuideStringData(
            idx: 3,
            title: "4 하우스 (IC, 천저궁 포함)",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 가정, 뿌리, 가족, 사적 영역",
                ],
                subContents: [
                    ":🏡👩🏻‍🍼🛋",
                    "가정환경, 부모와의 관계등 내면의 안정감을 의미하며 개인의 '기반'을 나타냄."
                ]
            )
        ),
        GuideStringData(
            idx: 4,
            title: "5 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 창의성, 연애, 즐거움, 자기표현",
                ],
                subContents: [
                    ":🎨🕺🏻🎺",
                    "연애, 창조적인 활동, 여가, 놀이등 자신이 즐거움을 느끼는 영역을 나타냅니다."
                ]
            )
        ),
        GuideStringData(
            idx: 5,
            title: "6 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 일상, 건강, 직업, 봉사",
                ],
                subContents: [
                    ":🏋🏼🥕📆",
                    "직업윤리, 건강 관리, 습관, 책임등 일상적인 책임에 관련됩니다. 섬세함과 봉사하는 태도를 나타냄."
                ]
            )
        ),
        GuideStringData(
            idx: 6,
            title: "7 하우스 (Descendant, 하강궁 포함)",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 반려, 동반자, 결혼",
                ],
                subContents: [
                    ":👩🏻‍❤️‍👨🏻🫶🏼💍",
                    "개인적인 파트너십(로맨스나 결혼, 비지니스도 포함)의 중요한 1대 1관계를 나타냅니다."
                ]
            )
        ),
        GuideStringData(
            idx: 7,
            title: "8 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 공동 자산, 변형, 심리적 깊이",
                ],
                subContents: [
                    ":🔥💛☠️",
                    "재정적 공유(유산, 대출등), 심리적 변화, 성적인 에너지. 끝과 새로운 시작을 상징합니다."
                ]
            )
        ),
        GuideStringData(
            idx: 8,
            title: "9 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 철학, 여행, 종교, 고등교육",
                ],
                subContents: [
                    ":✈️📖🕌",
                    "세계관, 믿음, 고등교육, 장거리 여행등 탐험과 확장을 나타냅니다."
                ]
            )
        ),
        GuideStringData(
            idx: 9,
            title: "10 하우스 (MC 중천궁 포함)",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 사회적 명성, 직업, 목표, 야망",
                ],
                subContents: [
                    ":🏆⛳️🏌🏼‍♂️",
                    "목표, 사회적 역할, 직업적 성취등 개인이 사회에서 가지는 위치를 나타냅니다."
                ]
            )
        ),
        GuideStringData(
            idx: 10,
            title: "11 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 우정, 커뮤니티, 희망, 혁신",
                ],
                subContents: [
                    ":🙌🏻🌍🚀",
                    "우정, 단체 활동, 사회적 활동등 꿈을 이루기 위해 함께하는 환경, 사람들을 상징합니다."
                ]
            )
        ),
        GuideStringData(
            idx: 11,
            title: "12 하우스",
            contents: Contents(
                subTitle: "",
                contents: [
                    "상징: 잠재의식, 영성, 꿈, 고독, 희생",
                ],
                subContents: [
                    ":🌙🌀😌",
                    "내면의 세계, 꿈, 과거의 상처, 영적 깨달음등 무의식과 내면속 보이지 않는 것들에 관련이 깊습니다."
                ]
            )
        ),
    ]
}

