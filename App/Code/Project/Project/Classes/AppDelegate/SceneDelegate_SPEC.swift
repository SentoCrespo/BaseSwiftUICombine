@testable import Project
import Foundation
import XCTest

class SceneDelegateTests: XCTestCase {
    
    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private var delegate: SceneDelegate?
    // swiftlint:disable:next weak_delegate
    private var compositeDelegate: CompositeSceneDelegate?
    // swiftlint:disable:next weak_delegate
    private var mockDelegate: SceneDelegateMock?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        delegate = SceneDelegate.shared
        compositeDelegate = SceneDelegate.shared.sceneDelegate as? CompositeSceneDelegate
        mockDelegate = compositeDelegate?.delegate(type: SceneDelegateMock.self)
    }
    
    override func tearDown() {
        delegate = nil
        compositeDelegate = nil
        mockDelegate = nil
        
        super.tearDown()
    }
    
}

// MARK: - App Delegate
extension SceneDelegateTests {
    
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
        delegate?.applicationWillResignActive(application)
        
        // Then
        let method = "applicationWillResignActive"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }
    
    func test_applicationDidEnterBackground() {
        
        // Given
        let application = UIApplication.shared
            
        // When
        delegate?.applicationDidEnterBackground(application)
        
        // Then
        let method = "applicationDidEnterBackground"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }
    
    func test_applicationWillEnterForeground() {
        
        // Given
        let application = UIApplication.shared
        
        // When
        delegate?.applicationWillEnterForeground(application)
        
        // Then
        let method = "applicationWillEnterForeground"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }
    
    func test_applicationWillTerminate() {
        
        // Given
        let application = UIApplication.shared
        
        // When
        delegate?.applicationWillTerminate(application)
        
        // Then
        let method = "applicationWillTerminate"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
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
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }
    
    func test_didRegisterForRemoteNotificationsWithDeviceToken() {
        
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
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }

    func test_didFailToRegisterForRemoteNotificationsWithError() {
        
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
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
        
    }
    
    func test_didReceiveRemoteNotification() {
        
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
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
     
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateTests {
    
    func test_sceneDidDisconnect() {

        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidDisconnect(scene)

        // Then
        let method = "sceneDidDisconnect"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_sceneDidBecomeActive() {

        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidBecomeActive(scene)

        // Then
        let method = "sceneDidBecomeActive"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_sceneWillResignActive() {

        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneWillResignActive(scene)

        // Then
        let method = "sceneWillResignActive"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_sceneWillEnterForeground() {

        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneWillEnterForeground(scene)

        // Then
        let method = "sceneWillEnterForeground"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_sceneDidEnterBackground() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        delegate?.sceneDidEnterBackground(scene)

        // Then
        let method = "sceneDidEnterBackground"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_SceneOpenURLContexts() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let urlContexts: Set<UIOpenURLContext> = []

        // When
        delegate?.scene(scene, openURLContexts: urlContexts)

        // Then
        let method = "openURLContexts"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_stateRestorationActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!

        // When
        _ = delegate?.stateRestorationActivity(for: scene)

        // Then
        let method = "stateRestorationActivity"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_willContinueUserActivityWithType() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let activityType: String = ""

        // When
        delegate?.scene(scene, willContinueUserActivityWithType: activityType)

        // Then
        let method = "willContinueUserActivityWithType"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_continueUserActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let bundleId = Bundle(for: SceneDelegateTests.self).bundleIdentifier!
        let activityType: NSUserActivity = NSUserActivity(activityType: bundleId)

        // When
        delegate?.scene(scene, continue: activityType)

        // Then
        let method = "continueUserActivity"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }

    func test_didFailToContinueUserActivityWithType() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let activityType: String = ""
        let error: Error = NSError(domain: "Could not run", code: 500, userInfo: [:])

        // When
        delegate?.scene(scene, didFailToContinueUserActivityWithType: activityType, error: error)

        // Then
        let method = "didFailToContinueUserActivityWithType"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }
    
    func test_didUpdateUserActivity() {
        // Given
        let session = UIApplication.shared.openSessions.first!
        let scene = session.scene!
        let bundleId = Bundle(for: SceneDelegateTests.self).bundleIdentifier!
        let activityType: NSUserActivity = NSUserActivity(activityType: bundleId)

        // When
        delegate?.scene(scene, didUpdate: activityType)

        // Then
        let method = "didUpdateUserActivity"
        XCTAssertNotNil(mockDelegate!.methodCalled[method])
    }
    
}
