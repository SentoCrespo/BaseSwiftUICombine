#!/usr/bin/env swift

import Cocoa
import Foundation


let bundlePath = FileOperations.path(bundle: Bundle.main)
print("""
    Info :: Bundle Url
    \(bundlePath)
""")

let basePathString = "/Volumes/Storage/Projects/BaseProject/SwiftUICombine/App/Code/Project/Project/Classes"
let rootPath = URL(string: basePathString)!

/// Find .gv files
let fileOperations = FileOperations()
let files = fileOperations.findFiles(rootPath: rootPath, fileExtension: "gv")
print("File(s) found: \(files)")

/// Process each file to read it, generate the code and store it
files.forEach { filepath in
    
    let filename = FileOperations.fileName(path: filepath)
    print(">>> Processing '\(filename)'")
    let fileContentResult = fileOperations.readContent(path: filepath)
    
    switch fileContentResult {
    case .failure(let error):
        print(error)
        exit(1)
        
    case .success(let fileContent):
        // Extract Lines
        let lines: [String] = fileContent
            .split(separator: "\n")
            .map { String($0) }
        
        let dotOperations = DotOperations()
        
        // Extract struct values
        let processedDot = dotOperations.processDot(lines: lines)
        
        // Generate the code
        let generatedCode = dotOperations.generateModel(
            name: filename + "Model",
            processDot: processedDot
        )
        
        // Store the generated code in a file
        let generatedFilename = filename + "Model_Generated.swift"
        let generatedPath = filepath.deletingLastPathComponent().appendingPathComponent(generatedFilename)
        let storeResult = fileOperations.store(path: generatedPath, content: generatedCode)
        switch storeResult {
        case .success:
            print("** Generated file at '\(generatedPath)'")
            
        case .failure(let error):
            print("** Could not store file at '\(generatedPath)' - \(error)")
            break
        }
    
    }
    
}

exit(0)
