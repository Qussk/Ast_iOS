//
//  DailyItemUI.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture

//MARK: 컨텐츠 - 일일
struct DailyUI: View {
    let store: StoreOf<HomeFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewStore.leadDays, id: \.self) { item in
                        LazyVStack {
                            DailyItemUI(
                                store: store,
                                item: item
                            )
                            .padding(.horizontal, 18)
                        }
                    }
                }
                .padding(.vertical, 10)
                .onAppear(){
                    viewStore.send(.setDailyLead)
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}


struct DailyItemUI: View {
    let store: StoreOf<HomeFeature>
    let item: HomeFeature.LeadDaily

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)

                LazyVStack(alignment: .leading, spacing: 10) {
                    LazyHStack(alignment: .bottom, spacing: 10) {
                        Text("\(item.rank)위")
                            .fontColor(.h4, color: .b1)
                            .multilineTextAlignment(.leading)
                        Text(item.astroNm.getNameDescription())
                            .fontColor(.h1, color: .b1)
                        Text(item.astroNm.getEmoji())
                            .font(.system(size: 24))
                        Spacer()
                        Text("\(String(describing: item.rank.getTopRank()))")
                            .font(.system(size: 24))
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 16)
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    
                    LazyVStack(alignment: .leading, spacing: 10) {
                        Text(item.content)
                            .fontColor(.h7, color: .b1)
                            .lineSpacing(5)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.top, 8)
                            .padding(.trailing, 16)
                    }
                    .frame(maxWidth: screenSize.width, maxHeight: .infinity)
                    .fixedSize(horizontal: false, vertical: true)

                    LazyHStack(spacing: 0) {
                        Text("행운의 열쇠 : ")
                            .fontColor(.h6, color: .b1)
                        Text(item.luckyKey)
                            .fontColor(.h7, color: .b1)
                        Spacer()
                        
                        Text("행운의 컬러 : ")
                            .fontColor(.h6, color: .b1)
                        Text(item.luckyColor)
                            .fontColor(.h7, color: .b1)
                    }
                    .padding(.top, 12)
                    .padding(.trailing, 36)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: true)
                    
                    LazyHStack(spacing: 0) {
                        Text("행운의 음식 : ")
                            .fontColor(.h6, color: .b1)
                        Text(item.luckyFood)
                            .fontColor(.h7, color: .b1)
                        Spacer()
                        
                        Text("행운의 자음 : ")
                            .fontColor(.h6, color: .b1)
                        Text(item.luckyFood)
                            .fontColor(.h7, color: .b1)
                    }
                    .padding(.top, -4)
                    .padding(.bottom, 10)
                    .padding(.trailing, 36)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: true)
                    
                    DailyItemLikeUI(store: store, item: item)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .onTapGesture {
                    viewStore.send(.dailySelectionPopup)
                }
            }
            .clearFullScreenCover(store: store.scope(state: \.$dailyPopup, action: { .dailyPopup($0) }), content: {
                store in
                DonationPopupUI(store: store)
            })
        }
    }
}

struct DailyItemLikeUI: View {
    let store: StoreOf<HomeFeature>
    let item: HomeFeature.LeadDaily
    @State private var activityItem: ActivityItem?

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            LazyHStack(spacing: 12) {
                let img: any View = DailyItemUI(store: store, item: item)

                Button {
                    viewStore.send(.toShareTapped)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        shareImage(img)
                    }
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
                Button {
                    viewStore.send(.toDownloadTapped)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        downloadImage(img)
                    }
                } label: {
                    Image(systemName: "arrow.down.to.line")
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
                Button {
                    viewStore.send(.toLikeTapped)
                } label: {
                    Image(systemName: viewStore.isLikeImagenamed)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 0)
            .transaction({ transaction in
                transaction.disablesAnimations = true
            })
            .activitySheet($activityItem)
        }
    }
    
    //MARK: Function
    func downloadImage<V: View>(_ view: V) {
        let image = view.snapshot()
        let responder = WritePhotosResponder()
        UIImageWriteToSavedPhotosAlbum(image, responder, #selector(WritePhotosResponder.completedSavedPhotos(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func shareImage<V: View>(_ view: V) {
        let image = view.snapshot()
        activityItem = ActivityItem(items: image)
    }

}


final class WritePhotosResponder: NSObject {
    @objc func completedSavedPhotos(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer) {
        if let error {
            print(error)
        } else {
            UIApplication.topmostViewController()?.showToast(message: "저장이 완료 되었습니다!")
        }
    }
}
