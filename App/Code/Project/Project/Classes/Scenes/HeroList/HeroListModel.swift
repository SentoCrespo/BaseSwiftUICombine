import Foundation
import Combine
import Domain

/// Domain definition for the scene
struct HeroListModel {
    
    // MARK: - Variables
    var heroes: [Hero] = []
    var heroesFiltered: [Hero] = []
    var searchText: String = ""
    
    /// General purpose variables
    struct Context {
        
    }
    
}
