import Foundation

extension String {

    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom ..< endIndex)?.lowerBound).map { substringTo in
                return String(self[substringFrom ..< substringTo])
            }
        }
        
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func loweringFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }

    mutating func lowerFirstLetter() {
        self = self.loweringFirstLetter()
    }
    
}
