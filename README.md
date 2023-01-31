# HWLib
This repo host under developing HW components for my research interest. Besides, some components might be delivered to the creator.

## Dependency
- You need to install GHDL and GTKWave
  - To install them in Ubuntu or OSX, execute command below in the terminal:

```
sudo apt install ghdl gtkwave 
```

## File structure
```
.
├── README.md
├── document
├── source
└── testbench
```
- `document` folder contains documentation of this repo
- `source` folder contains all hardware components
- `testbench` folder contains all corresponding tests for each component

## How to run testbench?
To test the `fp_relu` component run:
```
make TESTBENCH=fp_relu
```
and then you will see output like below:
```
testbench/fp_relu_tb.vhd:67:9:@215ns:(report note): The correct value should be 0 while relu_output is 0
testbench/fp_relu_tb.vhd:71:9:@225ns:(report note): The correct value should be 0 while relu_output is 0
testbench/fp_relu_tb.vhd:75:9:@235ns:(report note): The correct value should be 0 while relu_output is 0
testbench/fp_relu_tb.vhd:79:9:@245ns:(report note): The correct value should be 17 while relu_output is 0
testbench/fp_relu_tb.vhd:83:9:@255ns:(report note): The correct value should be 1 while relu_output is 1
testbench/fp_relu_tb.vhd:87:9:@265ns:(report note): The correct value should be 0 while relu_output is 0
testbench/fp_relu_tb.vhd:91:9:@275ns:(report note): The correct value should be 127 while relu_output is 127
testbench/fp_relu_tb.vhd:95:9:@285ns:(report note): The correct value should be 0 while relu_output is 0
/usr/bin/ghdl-mcode:info: simulation stopped by --stop-time @1us
```
all outputs match the expected value, which means the test passed.

## Todo

- [x] interface definition
- [x] we need the implementation of `hard_sigmoid` function
	- [x] test coverage
- [x] we need the implementation of `hard_tanh` function
	- [x] test coverage
- [x] implementation of the `Relu` function
	- [x] test coverage
- [x] implementation of the full functional `linear layer`
	- [x] test coverage
- [ ] Automate the test value check part with the `assert` statement.

