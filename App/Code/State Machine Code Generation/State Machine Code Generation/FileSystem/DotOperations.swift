import Foundation

struct DotOperations {
    
    // MARK: - Properties
    var fileManager: FileManager
    
    // MARK: - Life Cycle
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
}

// MARK: - Public Methods
extension DotOperations {

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
        
        let result = ProcessDotResult(
            states: states,
            events: events,
            effects: effects,
            transitions: transitions
        )
        return result
    }
    
    func generateModel(name: String, processDot: ProcessDotResult) -> String {
        
        // Read template content
        var generatedCode = autoStateMachineModelTemplate
        
        // Version
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{VERSION}}",
            with: Constants.version
        )
        
        // Model Name
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{MODEL_NAME}}",
            with: name
        )
        
        // State values
        let statesFormatted = processDot.states
            .map { "case \($0.label)" }
            .joined(separator: "\n\t\t")
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{STATE_CASES}}",
            with: statesFormatted
        )
        // Initial State
        let initialState = processDot.states
            .first(where: { $0.isInitial })
            .map { $0.label }!
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{STATE_INITIAL}}",
            with: initialState
        )
        
        // Events
        let eventsFormatted = processDot.events
            .map { "case \($0)" }
            .joined(separator: "\n\t\t")
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{EVENT_CASES}}",
            with: eventsFormatted
        )
        
        // Initial Event
        let initialEvent = processDot.transitions
            .first(where: { $0.from == 0 && $0.to == 1 })
            .map { $0.event }!
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{EVENT_INITIAL}}",
            with: initialEvent
        )
        
        // Effects
        let effectsFormatted = processDot.effects
            .map { "case \($0)" }
            .joined(separator: "\n\t\t")
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{EFFECT_CASES}}",
            with: effectsFormatted
        )
        
        // Transitions
        let transitions: [String] = processDot.transitions.map { transition in
            // State from
            let stateFrom = processDot.states.first(where: { state in
                return state.index == transition.from
            })
            let stateFromFormatted = stateFrom != nil ? ".\(stateFrom!.label)" : "_"
            
            // State to
            let stateTo = processDot.states.first(where: { state in
                return state.index == transition.to
            })!
            
            let event = transition.event
            let eventFromWithValues: Bool = event.contains("(")
            var eventFromFormatted: String = event
            if eventFromWithValues {
//                if let eventValues = event.slice(from: "(", to: ")") {
//                    eventFromFormatted = event
//                        .replacingOccurrences(
//                            of: eventValues,
//                            with: eventValues.loweringFirstLetter()
//                    )
//                        .replacingOccurrences(
//                            of: "(",
//                            with: "(let "
//                    )
//                }
                eventFromFormatted = event
                    .split(separator: "(")
                    .map { String($0) }
                    .first ?? ""
            }
            let effect: String = transition.effect != nil ? ".\(transition.effect!)" : "nil"
            let transitionFormatted: [String] = [
                "case (\(stateFromFormatted), .\(eventFromFormatted)):",
                "return (nextState: .\(stateTo.label), effect: \(effect))"
            ]
            return transitionFormatted.joined(separator: "\n\t\t\t\t")
        }
        
        let transitionsFormatted = transitions.joined(separator: "\n\t\t\t")
        generatedCode = generatedCode.replacingOccurrences(
            of: "{{TRANSITION_CASES}}",
            with: transitionsFormatted
        )
        
        return generatedCode
        
    }
    
}

// MARK: - Private Methods
private extension DotOperations {
    
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
    
}
