//
//  File.swift
//  
//
//  Created by Nikolai Timonin on 10.01.2023.
//

import SwiftUI

public struct ViewPreview: UIViewRepresentable {
    private let viewBuilder: () -> UIView

    public init(builder: @escaping () -> UIView) {
        self.viewBuilder = builder
    }

    public func makeUIView(context: Context) -> some UIView {
        viewBuilder()
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) { }
}
