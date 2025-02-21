//
//  View+.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI


extension View {
    func fontColor(_ font: Font, color: Color, background: Color? = nil) -> some View {
        self.modifier(FontColor(textColor: color, font: font, backgroundColor: background))
    }
    
    func colors(_ color: Color, background: Color? = nil) -> some View {
        self.modifier(Colors(foregroundColor: color, backgroundColor: background))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func safeAreaInset(type: SafeAreaInsetType) -> CGFloat {
        let window: UIWindow?
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.first
            top = window?.safeAreaInsets.top ?? 0
            bottom = window?.safeAreaInsets.bottom  ?? 0
        } else {
            window = UIApplication.shared.keyWindow
            top = window?.safeAreaInsets.top ?? 0
            bottom = window?.safeAreaInsets.bottom ?? 0
        }
        return type == .top ? top : bottom
    }
    
    @ViewBuilder func unignoresSafeArea(_ edges: Edge.Set = .top) -> some View {
        if edges.contains(.top) || edges.contains(.bottom) {
            self.modifier(PaddingsStatusBar(edges: edges))
        }
        else {
            self
        }
    }

}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension View {
    func getRandomColor() -> Color {
        @AppStorage("savedRandomColor") var savedColorData: Data?
        
        ///저장된 컬러 있으면 AppStorage에 저장된 컬러 사용
        if let colorData = savedColorData,
           let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            return Color(uiColor)
        } else {
            let randomColor = Color.random
            /// 랜덤 컬러를 저장
            if let colorData = Color.saveToStorage(color: randomColor) {
                savedColorData = colorData
            }
            return randomColor
        }
    }
}
