## State Machine Scene

### Definition

The architecture is defined in a way that it's a state machine.

1) Define a .gv file using the visual tool here:
[Graphviz](https://dreampuf.github.io/GraphvizOnline/)

2) Run the project in the workspace named: 
```
State Machine Code Generation
```

It will look for .gv files and create the model file in a  
`{SCENE}Model_Generated.swift` file containing the:
- States
- Initial State
- Events (An action happened)
- Effects (Instructions to trigger logic)
- Transitions (Move from one state to another)
