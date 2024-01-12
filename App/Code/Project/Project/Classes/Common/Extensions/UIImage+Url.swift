import Foundation
import UIKit

import Kingfisher

extension UIImageView {
    typealias ImageHandler = (_ image: UIImage?) -> Void
    
    func setImage(with urlString: String?, completion: ImageHandler? = nil) {
        // Set indicator type
        var kf = self.kf
        kf.indicatorType = .activity
        
        // Check for a valid URL
        guard let url = urlString else {
            self.kf.setImage(with: URL(string: ""))
            completion?(nil)
            return
        }
        
        // Fetch the remote image
        self.kf.setImage(with: URL(string: url)) { result in
            switch result {
            case .success(let value):
                completion?(value.image)
            case .failure:
                completion?(nil)
            }
        }
    }
    
    /// Cancels active image download from url
    func cancelRemoteImage() {
        self.kf.cancelDownloadTask()
    }
    
}
