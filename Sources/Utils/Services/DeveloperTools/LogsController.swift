//
//  LogsController.swift
//  Utils
//
//  Created by Petrovich on 07.11.2021.
//

import UIKit

enum LogLevel {
    
    case low
    case high
}

class DeveloperToolsLogger {
    
    public static func collectedLogs() -> String {
        return .empty
    }
    
    public static func clear() { }
}

final class LogsController: UIViewController, XibInitable {
        
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var filterButtons: [UIButton]!
    
    private var selectedTypes: [LogLevel] {
        return filterButtons.compactMap({ (button: UIButton) -> LogLevel? in
//            return button.isSelected ? LogLevel(value: button.tag) : nil
            return nil
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        textView.text = DeveloperToolsLogger.collectedLogs()
    }

    @IBAction private func close() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func copyButtonTapped() {
        UIPasteboard.general.string = DeveloperToolsLogger.collectedLogs()
    }

    @IBAction private func filterLogs(_ sender: UIButton) {
        sender.isSelected = sender.isSelected == false
//        textView.text = DeveloperToolsLogger.collectedLogs(selectedTypes)
    }
}
