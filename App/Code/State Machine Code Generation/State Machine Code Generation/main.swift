#!/usr/bin/env swift

import Cocoa
import Foundation

print("""
Info :: Reading Bundle Url
\(URL(string: Bundle.main.bundlePath)!)
""")


let rootPath = URL(string: "/Volumes/Storage/Projects/BaseProject/SwiftUICombine/App/Code/Project/Project/Classes/Scenes/Registration/Main")!

let fileUrls = scanFiles(rootPath: rootPath)
let filesDot = fileUrls.filter { $0.pathExtension ==  "gv" }

print("File(s) found: \(filesDot)")

//let processedDot = filesDot
//    .compactMap { (path: URL) -> String? in
//        return readContent(path: path)
//    }
//    .map { (content: String) -> [String] in
//        let lines = content
//            .split(separator: "\n")
//            .map { String($0) }
//        return lines
//    }
//    .map {
//        return processDot(lines: $0)
//    }

let file = filesDot.first!
let content = readContent(path: file)!
let lines = content
    .split(separator: "\n")
    .map { String($0) }

let processedDot = processDot(lines: lines)

let generatedCode = generateModel(
    states: processedDot.0,
    events: processedDot.1,
    effects: processedDot.2,
    transitions: processedDot.3
)

let generatedPath = URL(fileURLWithPath: "/Volumes/Storage/Projects/BaseProject/SwiftUICombine/App/Code/Project/Project/Classes/Scenes/Registration/Main/MainModelGenerated.swift")
store(content: generatedCode, path: generatedPath)


func scanFiles(rootPath: URL) -> [URL] {
    let fileManager = FileManager.default
    
    guard let fileUrls = try? fileManager.contentsOfDirectory(
        at: rootPath,
        includingPropertiesForKeys: nil) else {
            return []
    }
    
    return fileUrls
}
    
func readContent(path: URL) -> String? {
    
    guard let content = try? String(
        contentsOf: path,
        encoding: .utf8) else {
        return nil
    }
    
    return content
    
}

func store(content: String, path: URL) {
    do {
        try content.write(to: path, atomically: true, encoding: .utf8)
    } catch let error {
        print(error)
    }
}

struct State {
    var index: Int
    var label: String
    var isInitial: Bool
}

struct Transition {
    var from: Int
    var to: Int
    var event: String
    var effect: String?
}

enum DotProcessingState {
    case searching
    case states
    case transitions
}

typealias ProcessDotResult = (
    states: [State],
    events: [String],
    effects: [String],
    transitions: [Transition]
)
func processDot(lines: [String]) -> ProcessDotResult {
    
    var states: [State] = []
    var events: [String] = []
    var effects: [String] = []
    var transitions: [Transition] = []
    
    var dotProcessingState: DotProcessingState = .searching
    
    // Extract information
    lines.enumerated().forEach { (index, line) in
        
        if line.contains("// States") {
            dotProcessingState = .states
        }
        
        if line.contains("// Transitions") {
            dotProcessingState = .transitions
        }
        
        switch dotProcessingState {
        case .searching:
            print("\(index): Discarding line - \(line)")
            break
        case .states:
            print("\(index): State - \(line)")
            if let state = processState(line: line) {
                states.append(state)
            }
        case .transitions:
            print("\(index): Transition - \(line)")
            if let transition = processTransition(line: line) {
                transitions.append(transition)
            }
            
        }

    }
    
    // Events
    events = transitions
        .map { $0.event }
        .unique()
    
    // Effects
    effects = transitions
        .compactMap { $0.effect }
        .unique()
    
    let result = ProcessDotResult(states, events, effects, transitions)
    return result
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

func processState(line: String) -> State? {
    
    let sanitizedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let index = sanitizedLine
        .split(separator: " ")
        .first?
        .compactMap { String($0) }
        .compactMap { Int($0) }
        .first
    
    guard let state = index else {
        print("No state found")
        return nil
    }
    
    // Label
    let regexLabel = "label=\"[a-zA-Z(,)]+\""
    guard let substrRange = sanitizedLine.range(of: regexLabel, options: .regularExpression) else {
        print("No label found")
        return nil
    }
    let label = sanitizedLine[substrRange]
        .replacingOccurrences(of: "label=", with: "")
        .replacingOccurrences(of: "\"", with: "")
    
    // Initial state
    var isInitial = false
    let regexInitialState = "peripheries=\\d"
    if let substrRange = sanitizedLine.range(of: regexInitialState, options: .regularExpression) {
        let peripheries = sanitizedLine[substrRange]
            .replacingOccurrences(of: "peripheries=", with: "")
        if peripheries == "2" {
            isInitial = true
        }
    }
    
    let result = State(
        index: state,
        label: label,
        isInitial: isInitial
    )
    
    return result
}

func processTransition(line: String) -> Transition? {
    
    let sanitizedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // State from -> to
    let regexFromTo = "\\d -> \\d"
    guard let substrRange = sanitizedLine.range(of: regexFromTo, options: .regularExpression) else {
        print("No states from -> to found")
        return nil
    }
    let stateFromTo = sanitizedLine[substrRange]
    let components = stateFromTo
        .components(separatedBy: " -> ")
        .map { String($0) }
    guard components.count > 1 else {
        print("Bad format in states from -> to")
        return nil
    }
    let stateFrom = Int(components.first!)!
    let stateTo = Int(components.last!)!
    
    // Label
    let regexLabel = "label=\"[a-zA-Z(,) >>]+\""
    guard let substrRange2 = sanitizedLine.range(of: regexLabel, options: .regularExpression) else {
        print("No label found")
        return nil
    }
    let label = sanitizedLine[substrRange2]
        .replacingOccurrences(of: "label=", with: "")
        .replacingOccurrences(of: "\"", with: "")
    
    let components2 = label
        .components(separatedBy: " >> ")
        .map { String($0) }
    
    guard components2.isEmpty == false else {
        print("No event found")
        return nil
    }
    
    let event = components2.first!
    let effect = components2.count > 1 ? components2.last : nil

    
    let result = Transition(
        from: stateFrom,
        to: stateTo,
        event: event,
        effect: effect
    )
    return result
    
}

func generateModel(states: [State], events: [String], effects: [String], transitions: [Transition]) -> String {
    
    var result: [String] = []
    
    result.append("// swiftlint:disable all")
    
    result.append("extension MainModel {")
    
    // States
    result.append("/// State machine for the scene")
    result.append("enum State: StateType {")
    
    let statesFormatted = states.map { "case \($0.label)" }
    
    result.append(contentsOf: statesFormatted)
    result.append("}")
    
    // Initial State
    let initialState = states.first(where: { $0.isInitial })!
    result.append("static let initialState: State = .\(initialState.label)")

    // Events
    result.append("/// An action happened")
    result.append("enum Event: EventType {")
    let eventsFormatted = events
        .map { "case \($0)" }
    result.append(contentsOf: eventsFormatted)
    result.append("}")
    
    // Initial Event
    let initialEvent = transitions.first(where: { $0.from == 0 && $0.to == 1 })!
    result.append("static let initialEvent: Event = .\(initialEvent.event)")
    
    // Effects
    result.append("/// Instructions to trigger logic")
    result.append("enum Effect: EffectType {")
    let effectsFormatted = effects.map { "case \($0)" }
    result.append(contentsOf: effectsFormatted)
    result.append("}")
    
    // Transitions
    
    result.append("// MARK: - Transitions")
    result.append("// Finite State Machine definition")
    result.append("static func createTransitions() -> ModuleTransition {")
    result.append("let result: ModuleTransition = { state, event in")
    result.append("switch (state, event) {")
        
    let transitionsFormatted: [String] = transitions.map { transition in
        // State from
        let stateFrom = states.first(where: { state in
            return state.index == transition.from
        })
        let stateFromFormatted = stateFrom != nil ? ".\(stateFrom!.label)" : "_"
        
        // State to
        let stateTo = states.first(where: { state in
            return state.index == transition.to
        })!
        
        let event = transition.event
        let eventFromWithValues: Bool = event.contains("(")
        var eventFromFormatted: String = event
        if eventFromWithValues {
            if let eventValues = event.slice(from: "(", to: ")") {
                eventFromFormatted = event
                    .replacingOccurrences(
                        of: eventValues,
                        with: eventValues.loweringFirstLetter()
                    )
                    .replacingOccurrences(
                        of: "(",
                        with: "(let "
                    )
            }
            
            // TODO: ^Just lower case first letter of value
        }
        let effect: String = transition.effect != nil ? ".\(transition.effect!)" : "nil"
        let transitionFormatted: [String] = [
            "case (\(stateFromFormatted), .\(eventFromFormatted)):",
            "return (nextState: .\(stateTo.label), effect: \(effect))"
            ]
        return transitionFormatted.joined(separator: "\n")
    }
    
    result.append(contentsOf: transitionsFormatted)
    result.append("default:")
    result.append("assertionFailure(\"Invalid transition from '\\(state)' with '\\(event)'\")")
    result.append("return (nextState: state, effect: nil)")
    result.append("}")
    result.append("}")
    result.append("return result")
    result.append("}")
    result.append("}")
    
    // TODO: Get main name MainModel ~> SceneModel
    result.append("extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}")
    result.append("extension MainModel.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}")
    result.append("extension MainModel.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}")

    
    return result.joined(separator: "\n")

}

extension String {
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

extension String {
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
