//
//  PhotoManager.swift
//  Ast
//
//  Created by 변윤나 on 1/27/25.
//

import Photos


class PhotoManager {
    enum PermissionStatus {
        case notDetermined, authorized, denied
    }
    
    static let shared = PhotoManager()
    var permissionStatus: PermissionStatus = .notDetermined
    
    func checkPhotoLibraryPermissionStatus() -> PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            self.permissionStatus = .authorized
        case .denied, .restricted:
            self.permissionStatus = .denied
        case .notDetermined:
            self.permissionStatus = .notDetermined
        case .limited:
            self.permissionStatus = .notDetermined
        @unknown default:
            self.permissionStatus = .notDetermined
        }
        
        return self.permissionStatus
    }
    
    func requestPhotoLibraryPermissionIfNeeded() async -> Bool {
        let status = checkPhotoLibraryPermissionStatus()
        
        switch status {
        case .authorized:
            return true
        case .denied:
            return false
        case .notDetermined:
            return await requestPhotoLibraryPermission()
        }
    }
    
    private func requestPhotoLibraryPermission() async -> Bool {
        let granted = await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    self.permissionStatus = status == .authorized ? .authorized : .denied
                    continuation.resume(returning: status == .authorized)
                }
            }
        }
        
        return granted
    }
}

