//
//  File.swift
//  
//
//  Created by Nikolai Timonin on 10.01.2023.
//

import SwiftUI

public struct ViewControllerPreview: UIViewControllerRepresentable {
    private let viewContrllerBulder: () -> UIViewController
    
    public init(builder: @escaping () -> UIViewController) {
        self.viewContrllerBulder = builder
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        viewContrllerBulder()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
