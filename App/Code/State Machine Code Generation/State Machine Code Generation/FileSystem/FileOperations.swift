import Foundation

struct FileOperations {
    
    // MARK: - Properties
    var fileManager: FileManager
    
    // MARK: - Life Cycle
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
}

extension FileOperations {
    
    static func path(bundle: Bundle) -> URL {
        return URL(string: bundle.bundlePath)!
    }
    
    static func fileName(path: URL) -> String {
        let result = path.deletingLastPathComponent().lastPathComponent
        return result
    }
    
    func findFiles(rootPath: URL, fileExtension: String) -> [URL] {
        return findFiles(
            rootPath: rootPath,
            criteria: { filePath in
                return filePath.hasSuffix(fileExtension)
        })
    }
    
    typealias CriteriaHandler = (String) -> (Bool)
    func findFiles(rootPath: URL, criteria: CriteriaHandler) -> [URL] {
        let rootPathString = rootPath.absoluteString
        let enumerator = self.fileManager.enumerator(atPath: rootPathString)
        var result: [URL] = []
        while let element = enumerator?.nextObject() as? String {
            if criteria(element) {
                let filePath = rootPath.appendingPathComponent(element)
                let filePathDirectory = URL(fileURLWithPath: filePath.absoluteString)
                result.append(filePathDirectory)
            }
        }
        return result
    }
    
    func readContent(path: URL, encoding: String.Encoding = .utf8) -> Result<String, Error> {
        do {
            let content = try String(contentsOf: path, encoding: encoding)
            return Result.success(content)
        } catch let error {
            return Result.failure(error)
        }
    }

    func store(path: URL, content: String, encoding: String.Encoding = .utf8) -> Result<Empty, Error> {
        do {
            try content.write(to: path, atomically: true, encoding: encoding)
            return Result.success(empty)
        } catch let error {
            return Result.failure(error)
        }
    }
    
}
