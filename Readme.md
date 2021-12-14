#  Readme

## Code Generation
This project uses code generation with:

### Sourcery
Every target contains a config file to generate associated code
as well as a build phase
Custom templates can be found in Autogenerated/CustomTemplates

### State Machine
There's a project State Machine Code Generation that needs to be run
in order to generate the states and transitions
It will look for any .gv file and generate associated code.
