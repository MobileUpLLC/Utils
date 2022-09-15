//
//  DeveloperToolsController.swift
//  Utils
//
//  Created by Petrovich on 07.11.2021.
//

import UIKit
import Pulse
import PulseUI

protocol DeveloperToolsCustomActionDelegate: AnyObject {

    func developerToolCustomActionDidTapped(_ developerTools: DeveloperToolsController)
}

final class DeveloperToolsController: UIViewController, XibInitable {
    
    private enum Constants {
        
        static let animationDuration = 0.2
        static let darkViewAlpha = 0.8
    }
        
    @IBOutlet private var darkView: UIView!
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dark(true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        dark(false)
    }

    private func dark(_ on: Bool) {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.darkView.backgroundColor = on ? UIColor.black.withAlphaComponent(Constants.darkViewAlpha) : .clear
        }
    }

    @IBAction private func customButtonTapped(_ button: UIButton) {
        DeveloperToolsService.customActionDelegate?.developerToolCustomActionDidTapped(self)
    }
    
    @IBAction private func openLogsButtonTapped() {
        UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.present(
            PulseUI.MainViewController(),
            animated: false,
            completion: nil
        )
    }

    @IBAction private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func clear() {
        DeveloperToolsLogger.clearLogs()
    }
}
