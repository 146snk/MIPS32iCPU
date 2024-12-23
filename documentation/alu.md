## Look Ahead Standard ALU (LASALU)
LASALU is being implemented as a standard arithmetic and logical unit used for simple standard integer 
operations.
The rationale of the design of the ALU is based on the Look-Ahead Carry Adder, which is a fast adder 
with 3-gate delay.

Traditional Ripple Carry adder computes its results as follows:

S = A xor B xor C<sub>in</sub>

C<sub>out</sub> = AB + C<sub>in</sub>(A+B)

While ripple carry adder splits the Carry term into two parts: Carry Generation (C<sub>g</sub>)
and Carry Propagation (C<sub>p</sub>). 
Each of these terms corresponds to one part of the Carry result of C<sub>out</sub>, 
by defining C<sub>out</sub> as follows: 

C<sub>out</sub> = C<sub>g</sub> + C<sub>in</sub>C<sub>p</sub>,

where C<sub>g</sub> = AB; C<sub>p</sub> = A+B.

By substituting the C<sub>in</sub> of each bit to the last bit, we can create a 
carry logic with three gate delay only. 
Figure below shows the design of Look Ahead Carry Adder. 

![Structure of Look Ahead Carry Adder](/figures/adder.png "Structure of Look Ahead Carry Adder")

Note that there are already components for bitwise AND, OR as well as XOR, which can be reused for 
logical operations. By adding xor gates for controlling addition or subtraction operations, the LASALU 
is formed.
Figure below shows the datapaths of LASALU:
![Datapath of LASALU](/figures/lasalu.png "Datapath of LASALU")

LASALU also supports SLT and SLTI instructions, by performing sub operation and output zero flag as alu_out,
as well as LUI instruction, by loading intermediate to upper half word.

Supported instructions and aluops are as follows:
|operation|aluop|
|---------|-----|
|add|0000|
|addu|0001|
|sub|0010|
|subu|0011|
|**---**|**---**|
|and|0100|
|or|0101|
|xor|0110|
|nor|0111|
|**---**|**---**|
|slt|1010|
|sltu|1011|
|**---**|**---**|
|lui|1111|

## Shifter
The shifter is being implemented supporting the following isntructions:
|operation|shiftop|
|-----|-----|
|SLL|000|
|SRL|010|
|SRA|011|
|SLLV|100|
|SRLV|110|
|SRAV|111|

