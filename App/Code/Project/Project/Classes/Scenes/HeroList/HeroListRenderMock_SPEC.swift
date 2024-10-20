import Foundation
import Domain
@testable import Project

class HeroListRenderMock: HeroListRender {
    
    private(set) var isToDetailsCalled = false
    private(set) var selectedHero: Hero?
    
    override func toDetails(hero: Hero) {
        isToDetailsCalled = true
        selectedHero = hero
    }
    
}
