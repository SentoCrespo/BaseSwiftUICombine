//
//  AppDelegate_SPEC.swift
//  ProjectTests
//
//  Created by Sento Crespo on 10/05/2020.
//

@testable import Project
import Foundation
import XCTest

class AppDelegateTests: XCTestCase {
    
    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private var delegate: AppDelegate?
    // swiftlint:disable:next weak_delegate
    private var compositeDelegate: CompositeAppDelegate?
    // swiftlint:disable:next weak_delegate
    private var mockDelegate: AppDelegateMock?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        delegate = AppDelegate.shared
        compositeDelegate = AppDelegate.shared.appDelegate as? CompositeAppDelegate
        mockDelegate = compositeDelegate?.delegate(type: AppDelegateMock.self)
    }
    
    override func tearDown() {
        delegate = nil
        compositeDelegate = nil
        mockDelegate = nil
        
        super.tearDown()
    }
    
}

extension AppDelegateTests {
    
    func test_applicationDidFinishLaunchingWithOptions() {
        
        // Given
        let application = UIApplication.shared
        let launchingOptions: [UIApplication.LaunchOptionsKey: Any] = [:]
            
        // When
        _ = delegate?.application(application, didFinishLaunchingWithOptions: launchingOptions)
        
        // Then
        let method = "didFinishLaunchingWithOptions"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_applicationWillResignActive() {
        
        // Given
        let application = UIApplication.shared
            
        // When
        _ = delegate?.applicationWillResignActive(application)
        
        // Then
        let method = "applicationWillResignActive"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_applicationDidEnterBackground() {
        
        // Given
        let application = UIApplication.shared
            
        // When
        _ = delegate?.applicationDidEnterBackground(application)
        
        // Then
        let method = "applicationDidEnterBackground"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_applicationWillEnterForeground() {
        
        // Given
        let application = UIApplication.shared
        
        // When
        _ = delegate?.applicationWillEnterForeground(application)
        
        // Then
        let method = "applicationWillEnterForeground"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_applicationWillTerminate() {
        
        // Given
        let application = UIApplication.shared
        
        // When
        _ = delegate?.applicationWillTerminate(application)
        
        // Then
        let method = "applicationWillTerminate"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_openUrlOptions() {
        
        // Given
        let application = UIApplication.shared
        let url = URL(string: "https://my.test.com")!
        let options: [UIApplication.OpenURLOptionsKey: Any] = [:]
            
        // When
        _ = delegate?.application(
            application,
            open: url,
            options: options
        )
        
        // Then
        let method = "openUrlOptions"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_didRegisterForRemoteNotificationsWithDeviceToken() {
        
        // Given
        let application = UIApplication.shared
        let deviceToken = "MyToken".data(using: .utf8)!
            
        // When
        _ = delegate?.application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
        
        // Then
        let method = "didRegisterForRemoteNotificationsWithDeviceToken"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }

    func test_didFailToRegisterForRemoteNotificationsWithError() {
        
        // Given
        let application = UIApplication.shared
        let error: Error = NSError(domain: "Fail", code: 500, userInfo: [:]) as Error
            
        // When
        _ = delegate?.application(
            application,
            didFailToRegisterForRemoteNotificationsWithError: error
        )
        
        // Then
        let method = "didFailToRegisterForRemoteNotificationsWithError"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
        
    }
    
    func test_didReceiveRemoteNotification() {
        
        // Given
        let application = UIApplication.shared
        let userInfo: [AnyHashable: Any] = [:]
        
        // When
        _ = delegate?.application(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: { backgroundFetchResult in
                
        })
        
        // Then
        let method = "didReceiveRemoteNotification"
        let result = mockDelegate!.methodCalled[method]!
        XCTAssertTrue(result)
     
    }
    
}
