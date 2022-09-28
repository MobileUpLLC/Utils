//
//  File.swift
//  
//
//  Created by vitalii on 28.09.2022.
//

import UIKit

public protocol StoryboardInitable: Initable {

    static var storyboardId: String { get }
    static var storyboardName: String { get }
}

public extension StoryboardInitable {

    static var storyboardId: String { String(describing: Self.self) }
    static var storyboardName: String { String(describing: Self.self) }
}

public extension StoryboardInitable where Self: UIViewController {

    static func initiate() -> Self {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
            .instantiateViewController(identifier: storyboardId) as! Self
    }
}
