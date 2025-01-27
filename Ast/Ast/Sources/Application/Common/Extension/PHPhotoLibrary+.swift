//
//  PHPhotoLibrary+.swift
//  Ast
//
//  Created by 변윤나 on 1/27/25.
//

import Photos

extension PHPhotoLibrary {
    enum AuthorizationStatus {
        case notDetermined
        case restricted
        case denied
        case authorized
    }

    static func requestAuth() async -> AuthorizationStatus {
        let status = await PHPhotoLibrary.authorizationStatus()
        return convertAuthorizationStatus(status)
    }
    
    private static func convertAuthorizationStatus(_ status: PHAuthorizationStatus) -> AuthorizationStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            fatalError("New case added to PHAuthorizationStatus")
        }
    }
}
