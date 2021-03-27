//
//  UIView+Preview.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/24/21.
//

import UIKit
#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIView {
    private struct Preview: UIViewRepresentable {
        // this variable is used for injecting the current view controller
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(view: self)
    }
}
#endif
