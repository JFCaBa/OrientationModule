//
//  ViewController.swift
//  GyroModule
//
//  Created by Jose on 31/12/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblRoll: UILabel!
    @IBOutlet weak var lblPitch: UILabel!
    @IBOutlet weak var lblYaw: UILabel!
    
    // MARK: - Ivars
    var viewModel = ViewModel()
    var subscribers: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup bingings
        setupBindings()
        // Start capturing data
        viewModel.start()
    }

    fileprivate func setupBindings() {
        viewModel.myPitchPublisher
            .assign(to: \.text, on: lblPitch)
            .store(in: &subscribers)
        
        viewModel.myYawPublisher
            .assign(to: \.text, on: lblYaw)
            .store(in: &subscribers)
        
        viewModel.myRollPublisher
            .assign(to: \.text, on: lblRoll)
            .store(in: &subscribers)
        
    }
}

