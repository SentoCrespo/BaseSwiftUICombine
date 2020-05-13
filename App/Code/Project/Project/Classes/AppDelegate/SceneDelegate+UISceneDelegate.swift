import Foundation

// MARK: - UISceneDelegate
extension SceneDelegate: UISceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Call the composite delegate
        sceneDelegate.scene?(
            scene,
            willConnectTo: session,
            options: connectionOptions
        )
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidDisconnect?(scene)
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidBecomeActive?(scene)
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneWillResignActive?(scene)
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneWillEnterForeground?(scene)
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidEnterBackground?(scene)
        
    }
    
}
