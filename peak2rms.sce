    //INDIRA ASKAUKAR
function out = peak2rms(in,orientation)


//peak2rms: peak magnitude to RMS value.

//  OUT=peak2rms(IN)

//  The function calculates the ratio of the peak  magnitude of given signal or vector to its root mean square value.

//  If the input IN is a matrix, the output of function is magnitude of peak to RMS value, of each column stored in a row vector OUT.

//  When the orientation is not specified for N dimensional array, it is taken as the index of the first dimension of IN that is greater than 1 and calculation is done along that orientation.


//  OUT=peak2rms(IN,orientation)

//  When the orientation is specified the output is calculated along that dimension.

//  The orientation can be specified as r for ratio of peak magnitude to RMS value of columns 

//For peak2RMS value of rows of matrix orientation should be  c.

//  When the elements of IN are COMPLEX, the absolute value of the element is used to calculate the output.

//EXAMPLES:
//1)To calculate peak2rms of a vector:
//IN=[6 19 10 25]
//OUT=peak2rms(IN)
//The output should be 1.4927036  
 

//2)To calculate peak2rms of rows of matrix:
//IN=[1 3 5;2 4 6;7 8 9]
// OUT=peak2rms(IN,'c')
//The output should be OUT=
    // 1.4638501  
    //1.3887301  
    //1.119186 

//3)To calculate peak magnitude to RMS value of sinusoid:
    //t=0:0.6:9
   //IN=cos(6*%pi*t);
   //OUT= peak2rms(IN)
   //The output should be
   //OUT= 1.3719887

     
    if argn(2)==1
        //calculating the Root Mean Square value
    a=abs(in)
    a=a.^2
    s=mean(a,"m")
    rmsvalue=sqrt(s)
    peak = max(abs(in),"m")
    rmsq = rmsvalue
  
else
    //Calculation of the RMS value
    a=abs(in)
    a=a.^2
    s=mean(a,orientation)
    rmsvalue=sqrt(s)
   [peak,k] = max(abs(in),orientation)
    rmsq = rmsvalue
  
end
    //Calculation of Ratio of peak to the Root Mean square value
if isempty(peak)
  out = rmsq;
else
  out = peak ./ rmsq;
end
