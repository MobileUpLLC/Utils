//
//  ItemsStackView.swift
//  
//
//  Created by Nikolai Timonin on 29.03.2023.
//

import UIKit

open class ItemsStackView<Item: Any, ItemView: UIView>: BaseView {
    public let innerStack = UIStackView()
    var items: [Item] {
        didSet {
            updateContent()
        }
    }
    
    private let contentBuilder: (Item) -> ItemView
    private let edgeInsets: UIEdgeInsets
    
    open override func initSetup() {
        super.initSetup()
        
        layoutViews()
        updateContent()
    }
    
    public init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat = .zero,
        edgeInsets: UIEdgeInsets = .zero,
        items: [Item] = [],
        content: @escaping (Item) -> ItemView
    ) {
        innerStack.axis = axis
        innerStack.distribution = distribution
        innerStack.alignment = alignment
        innerStack.spacing = spacing
        
        contentBuilder = content
        self.items = items
        self.edgeInsets = edgeInsets
        
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public required init(fromCodeWithFrame frame: CGRect) {
        fatalError("init(fromCodeWithFrame:) has not been implemented")
    }
    
    private func layoutViews() {
        addSubview(innerStack)
        innerStack.translatesAutoresizingMaskIntoConstraints = false
        
        innerStack.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top).isActive = true
        innerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom).isActive = true
        innerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left).isActive = true
        innerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right).isActive = true
    }
    
    private func updateContent() {
        innerStack.removeAllArangedSubviews()
        items.forEach { item in
            let itemView = contentBuilder(item)
            innerStack.addArrangedSubview(itemView)
        }
    }
}
