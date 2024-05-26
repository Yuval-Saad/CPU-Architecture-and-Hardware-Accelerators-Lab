DUT:
AdderSub.vhd - file which contains the Adder/Subtractor entity. Gets two vectors, and sub_cont bit (specify add or sub op) and returns a vector which is the result and a carry bit. Uses submodule or Full Adder. for more specification read work assignment or pdf.
aux_package.vhd - package that contains declaration of top & FA entities.
FA.vhd - implementation of full adder entity.
Logic.vhd - file which contains the Logic entity. Gets two vectors, and op vector (ALUFN). and returns a vector which is the result. for more specification read work assignment or pdf.
Shifter.vhd - file which contains the Shifter entity. Gets two vectors, and dir bit (specify shift left or right) and returns a vector which is the result and a carry bit. for more specification read work assignment or pdf.
Top.vhd - contains the entity and architecture of an ALU module as described in the assignment. for more specification read assignment or pdf.



