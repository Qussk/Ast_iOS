//
//  ClearFullScreenCover.swift
//  Ast
//
//  Created by 변윤나 on 1/26/25.
//

import SwiftUI
import ComposableArchitecture

extension View {
    func clearFullScreenCover<State, Action, Content: View>(
        store: Store<PresentationState<State>, PresentationAction<Action>>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (_ store: Store<State, Action>) -> Content
    ) -> some View {
        fullScreenCover(store: store) { store in
            ZStack {
                content(store)
            }
            .background(TransparentBackground())
        }
    }
    
    func clearFullScreenCover<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        fullScreenCover(isPresented: isPresented, content: {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        })
    }
}

struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
