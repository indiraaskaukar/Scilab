function y = filtfilt2(b,a,x)


 if (isempty(b)|isempty(a)|isempty(x))
        y = [];
        return
    end
    [p,q] = size(x);
    if (q>1)&(p>1)
        y = x;
        for i=1:q  % loop over columns
           y(:,i) = filtfilt(b,a,x(:,i));
        end
        return
        error('Only works for vector input.')
    end
    if p==1
        x = x(:);   // convert row to column
    end
    len = size(x,1);   // length of input
    b = b(:).';
    a = a(:).';
    lb = length(b);
    la = length(a);
    lfilt = max(lb,la);

    lfact = 3*(lfilt-1);  // length of edge transients
    
    if (len<=lfact),    // input data too short!
        error('Data length must be more than 3 times filter order.');
    end


    if lb < lfilt, b(lfilt)=0; end   //% zero-pad if necessary
    if la < lfilt, a(lfilt)=0; end

    rows = [1:lfilt-1  2:lfilt-1  1:lfilt-2];
    cols = [ones(1,lfilt-1) 2:lfilt-1  2:lfilt-1];
    data = [1+a(2) a(3:lfilt) ones(1,lfilt-2)  -ones(1,lfilt-2)];
    sp = sparse([rows',cols'],data);
    temp1=b(2:lfilt).';
    temp2=a(2:lfilt).';
    zi = sp \ ( temp1 - temp2*b(1) );
    

    y = [2*x(1)-x((lfact+1):-1:2);x;2*x(len)-x((len-1):-1:len-lfact)];

    y = filter(b,a,y,zi*y(1));
    y = y(length(y):-1:1);
    y = filter(b,a,y,zi*y(1));
    y = y(length(y):-1:1);
    

    y([1:lfact len+lfact+(1:lfact)]) = [];

    if p == 1
        y = y.'; 
    end
 endfunction
