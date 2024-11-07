@testable import Project
import Foundation
import Testing
import SwiftUI

@Suite(.serialized)
class SceneDelegateTests {
    
    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private var delegate: SceneDelegate?
    // swiftlint:disable:next weak_delegate
    private var compositeDelegate: CompositeSceneDelegate?
    // swiftlint:disable:next weak_delegate
    private var mockDelegate: SceneDelegateMock?
    
    // MARK: - Life Cycle
    init() {
        delegate = SceneDelegate.shared
        compositeDelegate = delegate?.sceneDelegate as? CompositeSceneDelegate
        mockDelegate = compositeDelegate?.delegate(
            type: SceneDelegateMock.self
        )
    }
    
    deinit {
        delegate = nil
        compositeDelegate = nil
        mockDelegate = nil
    }
    
}

// MARK: - App Delegate
extension SceneDelegateTests {
    
    @Test
    func applicationDidFinishLaunchingWithOptions() {
        // Given
        let application = UIApplication.shared
        let launchingOptions: [UIApplication.LaunchOptionsKey: Any] = [:]
       
        // When
        _ = delegate?.application(application, didFinishLaunchingWithOptions: launchingOptions)
        
        // Then
        let method = "didFinishLaunchingWithOptions"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func applicationWillResignActive() {
        // Given
        let application = UIApplication.shared
            
        // When
        delegate?.applicationWillResignActive(application)
        
        // Then
        let method = "applicationWillResignActive"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func applicationDidEnterBackground() {
        // Given
        let application = UIApplication.shared
            
        // When
        delegate?.applicationDidEnterBackground(application)
        
        // Then
        let method = "applicationDidEnterBackground"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func applicationWillEnterForeground() {
        // Given
        let application = UIApplication.shared
        
        // When
        delegate?.applicationWillEnterForeground(application)
        
        // Then
        let method = "applicationWillEnterForeground"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func applicationWillTerminate() {
        // Given
        let application = UIApplication.shared
        
        // When
        delegate?.applicationWillTerminate(application)
        
        // Then
        let method = "applicationWillTerminate"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func openUrlOptions() {
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
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func didRegisterForRemoteNotificationsWithDeviceToken() {
        // Given
        let application = UIApplication.shared
        let deviceToken = "MyToken".data(using: .utf8)!
        
        // When
        delegate?.application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
        
        // Then
        let method = "didRegisterForRemoteNotificationsWithDeviceToken"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func didFailToRegisterForRemoteNotificationsWithError() {
        // Given
        let application = UIApplication.shared
        let error: Error = NSError(domain: "Fail", code: 500, userInfo: [:]) as Error
       
        // When
        delegate?.application(
            application,
            didFailToRegisterForRemoteNotificationsWithError: error
        )
        
        // Then
        let method = "didFailToRegisterForRemoteNotificationsWithError"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func didReceiveRemoteNotification() {
        // Given
        let application = UIApplication.shared
        let userInfo: [AnyHashable: Any] = [:]
        
        // When
        delegate?.application(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: { backgroundFetchResult in
                
        })
        
        // Then
        let method = "didReceiveRemoteNotification"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateTests {
    
    @Test
    func sceneDidDisconnect() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidDisconnect(scene)

        // Then
        let method = "sceneDidDisconnect"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func sceneDidBecomeActive() {

        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidBecomeActive(scene)

        // Then
        let method = "sceneDidBecomeActive"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func sceneWillResignActive() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneWillResignActive(scene)

        // Then
        let method = "sceneWillResignActive"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func sceneWillEnterForeground() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneWillEnterForeground(scene)

        // Then
        let method = "sceneWillEnterForeground"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func sceneDidEnterBackground() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidEnterBackground(scene)

        // Then
        let method = "sceneDidEnterBackground"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func sceneOpenURLContexts() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let urlContexts: Set<UIOpenURLContext> = []

        // When
        delegate?.scene(scene, openURLContexts: urlContexts)

        // Then
        let method = "openURLContexts"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func stateRestorationActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        _ = delegate?.stateRestorationActivity(for: scene)

        // Then
        let method = "stateRestorationActivity"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func willContinueUserActivityWithType() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let activityType: String = ""

        // When
        delegate?.scene(scene, willContinueUserActivityWithType: activityType)

        // Then
        let method = "willContinueUserActivityWithType"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func continueUserActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let bundleId = Bundle(for: SceneDelegateTests.self).bundleIdentifier!
        let activityType: NSUserActivity = NSUserActivity(activityType: bundleId)

        // When
        delegate?.scene(scene, continue: activityType)

        // Then
        let method = "continueUserActivity"
        #expect(mockDelegate!.methodCalled[method]!)
    }

    @Test
    func didFailToContinueUserActivityWithType() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let activityType: String = ""
        let error: Error = NSError(domain: "Could not run", code: 500, userInfo: [:])

        // When
        delegate?.scene(scene, didFailToContinueUserActivityWithType: activityType, error: error)

        // Then
        let method = "didFailToContinueUserActivityWithType"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
    @Test
    func didUpdateUserActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let bundleId = Bundle(for: SceneDelegateTests.self).bundleIdentifier!
        let activityType: NSUserActivity = NSUserActivity(activityType: bundleId)

        // When
        delegate?.scene(scene, didUpdate: activityType)

        // Then
        let method = "didUpdateUserActivity"
        #expect(mockDelegate!.methodCalled[method]!)
    }
    
}
