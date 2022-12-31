//
//  ViewModel.swift
//  GyroModule
//
//  Created by Jose on 31/12/2022.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    let gyroManager = GyroManager()
    
    var myYawPublisher: AnyPublisher<String?, Never> {
        gyroManager.$yaw
            .compactMap{String(format: "%0.1f", $0)}
            .eraseToAnyPublisher()
    }
    
    var myPitchPublisher: AnyPublisher<String?, Never> {
        gyroManager.$pitch
            .compactMap{String(format: "%0.1f", $0)}
            .eraseToAnyPublisher()
    }
    
    var myRollPublisher: AnyPublisher<String?, Never> {
        gyroManager.$roll
            .compactMap{String(format: "%0.1f", $0)}
            .eraseToAnyPublisher()
    }
    
    // MARK: - Public functions
    public func start() {
        gyroManager.connect()
    }
}
