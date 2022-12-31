//
//  GyroManager.swift
//  GyroModule
//
//  Created by Jose on 31/12/2022.
//

import Foundation
import CoreMotion
import Combine

class GyroManager: NSObject {
    
    @Published var roll: Double = 0
    @Published var pitch: Double = 0
    @Published var yaw: Double = 0
    
    var manager = CMMotionManager()
    
    public func connect() {
        manager.deviceMotionUpdateInterval  = 0.2
        manager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motionData: CMDeviceMotion?, NSError) -> Void in
            if NSError == nil, let data = motionData {
                DispatchQueue.main.async{
                    // Normalize values and convert from radians to degrees
                    self.outputRPY(data: data)
                }
            }
        })
    }
    
    private func outputRPY(data: CMDeviceMotion) {
        let q: CMQuaternion = data.attitude.quaternion
        // Roll: atan2(2.0 * (q.z * q.y + q.w * q.x) , 1.0 - 2.0 * (q.x * q.x + q.y * q.y))
        // Pitch: asin(2.0 * (q.y * q.w - q.z * q.x))
        // Yaw: atan2(2.0 * (q.z * q.w + q.x * q.y) , -1.0 + 2.0 * (q.w * q.w + q.x * q.x))
        roll    = asin(2.0 * (q.y * q.w - q.z * q.x)) * 180 / Double.pi
        pitch   = atan2(2.0*(q.y*q.z + q.w*q.x), q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z) * 180 / Double.pi
        yaw     = asin(2.0 * (q.y * q.w - q.z * q.x)) * 180 / Double.pi
    }
}
