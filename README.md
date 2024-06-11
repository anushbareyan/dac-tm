# Digital to Analog Converter with a Turing Machine

The DAC_TM module converts digital inputs into analog outputs using a Turing Machine approach. 

## Module Overview

### Inputs
- `clk`: Clock signal
- `in`: 4-bit digital input

### Outputs
- `out`: Analog output

## Implementation Details

The implementation consists of the following components:

- **Tape**: Represents the tape of the Turing Machine, initialized with zeros and two placeholders ('x') for the start and end.
- **State**: Represents the state of the finite state machine.
- **Next State**: Represents the next state of the finite state machine.
- **Position (p)**: Represents the position of the tape head.
- **Result (res)**: Represents the result of the conversion.
