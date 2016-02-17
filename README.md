# Scilab
rssq

Root sum squared value

The function calculates the root of the squared value of each element along the dimension specified.

Calling Sequence

out=rssq(in)

out=rssq(in,orientation)

Arguments
Input:

•	in
               Vector or Matrix of real or complex elements.

•	orientation

1.	a string with possible values "r", "c" or "m"
2.	a number with positive integer value.
	m gives the first non singleton orientation of input, which is also the default orientation when not specified.


Output:

	out

a scalar with real value when input is a vector.
when input is a matrix, out is root sum squared value along the orientation specified or the default one when not specified.


NOTE: THE ORIENTATION CONSIDERED WHEN NOT SPECIFIED IS, THE INDEX OF FIRST DIMENSION OF INPUT "IN",GREATER THAN 1.


Description

	For vector as input, the output is the square root of the sum of squared elements of input.


	When a matrix is given as input the output is rssq value in the orientation specified.

The orientation can be given as integers or string with values "r","c" or "m".

1.	rssq(in,1) or rssq(in,'r') calculates the rssq values of columns of matrix.The output in this case is a row vector with rssq value of each column of in.

       2.    rssq(in,2) or rssq(in,'c') calculates the rssq values of rows of matrix,where the output would be a       
              column vector having rssq value of each row of in.

3.    The default orientation is choosen to be the index of first dimension of input greater than 1.
              Hence rssq(in) is equivalent to rssq(in,"m").


	For an N dimensional array the orientation is the index of first dimension of the array.


If the elements of matrix are complex the absolute values are considered in the calculation.


 Examples:

1)To calculate rssq of a vector:

IN=[2 4 6]

OUT=rssq(IN)

The output should be 7.4833148

2)To calculate rssq of rows of matrix:

IN=[1 3 5;2 4 6;7 8 9]

OUT=rssq(IN,2) or OUT=rssq(IN,'c')

The output should be OUT=

    5.9160798  
    7.4833148  
    13.928388
    

3)To calculate rssq of columns of matrix:

IN=[1 3 5;2 4 6;7 8 9]

OUT=rssq(IN,1) or OUT=rssq(IN,'r')

The output should be

 OUT= 7.3484692    9.4339811    11.916375  


4)To calculate rssq of a columns of complex matrix:

IN=[5+%i*3 2+%i*4; 3+%i*6 1+%i*2]

OUT=rssq(IN,1) or OUT=rssq(IN,'r')

The output should be OUT= 8.8881944 5.


5) To calculate rssq of a sinusoid:

t=0:0.6:3

IN=cos(2*%pi*t)

OUT=rssq(IN)

The output should be OUT= 1.8708287

References:

1)MATLAB help document.



