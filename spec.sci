function varargout = spectrogram(x,varargin)

//frequency axis allocation. The Default one is x axis.
faxisloc = 'xaxis';
if((argn(2)>1) & (type(varargin($))==10)) & (or(strcmpi(varargin($),{'yaxis','xaxis'}))),
if strcmpi(varargin($),'yaxis') then
faxisloc = 'yaxis';
end
varargin(end)=[];
end

if(argn(2)<1 & argn(2)>6)
error;
end
if(argn(1)<0 & argn(1)>4)
error;
end

Nx=length(x);
if (argn(2)==1) then
    noverlap=0.5;
    ncol=8;
    lwin=length(x)/8;

elseif(argn(2)==3)
    temp=noverlap;
    if(temp>length(win))
        error
    end
    
elseif(argn(2)==4)
    N=nfft;

else(argn(2)==5);
    
    if(Fs==[])
        Fs=1;
    else
        Fs=2*%pi;
    end
end
//calculate length of window
lwin=length(win);

//convert x and win into columns
x = x(:);
win = win(:);

//calculate the number of columns of S(i.e STFT output)
ncol=fix((Nx-noverlap)/(lwin-noverlap));

//pre-process input
col = 1 + (0:(ncol-1))*(lwin-noverlap);
row = (1:lwin);
xin=zeros(lwin,ncol);

//place x in columns of xin with proper overlaps
xin(:) = x(row(:,ones(1,ncol))+col(ones(lwin,1),:)-1);

//windoew the xin segments
xin = win(:,ones(1,ncol)).*xin;

[y,f] = computeDFT(xin,n,Fs);
if ~freqvecspecified & xisreal then
 f=psdfreqvec('npts',nfft,'Fs',Fs,'Range','Half');
 y=y(1:length(f),:);
end
t=((col-1)+((lwin)/2)')/Fs;


//outputs
select nargout,
case 0,
    // use surface to display spectrogram
    [Pxx,W] = compute_PSD(win,y,nfft,f,options,Fs,esttype);
    displayspectrogram(t,f,Pxx,isFsNormalized,faxisloc);
case 1,
    varargout = {y};
case 2,
    varargout = {y,f};
case 3,
        varargout = {y,f,t};
case 4,
        Pxx = compute_PSD(win,y,nfft,f,options,Fs,esttype);
        varargout = {y,f,t,Pxx};
end

////////////////////////////////////////////////////////////////////////////
function inputcheck (x)
    //verify type of input signal
    if isempty(x)|issparse|~isa(x,'double') then
        error(message('signal:spectrogram:mustBedouble','X')
    end
    if min(size(x))~=1,then
        error(message('signal:spectrogram:mustbevector','X'));
        
    end
endfunction
/////////////////////////////////////////////////////////////////////////////
   function displayspectrogram(t,f,Pxx,isFsnormalized,faxisloc)
       //Cell array of the standard frequency units strings
frequnitstrs = getfrequnitstrs;
if isFsnormalized, 
    idx = 1;
    f = f/pi; // Normalize the freq axis
else
    idx = 2;
end

newplot;
if strcmpi(faxisloc,'yaxis'),
    if length(t)==1
        // surf requires a matrix for the third input.
        args = {[0 t],f,10*log10(abs([Pxx Pxx])+eps)};
    else
        args = {t,f,10*log10(abs(Pxx)+eps)};
    end
    

    //Axis labels
    xlbl = getString(message('signal:spectrogram:Time'));
    ylbl = frequnitstrs{idx};
else
    if length(t)==1
        args = {f,[0 t],10*log10(abs([Pxx' Pxx'])+eps)};
    else
        args = {f,t,10*log10(abs(Pxx')+eps)};
    end
    xlbl = frequnitstrs{idx};
    ylbl = getString(message('signal:spectrogram:Time'));
end
hndl = surf(args{:},'EdgeColor','none');

axis xy; axis tight;
colormap(jet);

// AZ = 0, EL = 90 is directly overhead and the default 2-D view.
view(0,90);

ylabel(ylbl);
xlabel(xlbl);

endfunction
/////////////////////////////////////////////////////////////////////////////////
function [Pxx,W] = compute_PSD(win,y,nfft,f,options,Fs,esttype)
// Evaluate the window normalization constant.  A 1/N factor has been
// omitted since it will cancel below.
U = win'*win;     % Compensates for the power of the window.
Sxx = y.*conj(y)/U; % Auto spectrum.

// The computepsd function expects NFFT to be a scalar
if length(nfft) > 1, nfft = length(nfft); end

//Compute the one-sided or two-sided PSD [Power/freq]. Also compute
// the corresponding half or whole power spectrum [Power].
[Pxx,W] = computepsd(Sxx,f,options.range,nfft,Fs,esttype);
endfunction
////////////////////////////////////////////////////////////////////////////

endfunction



    
    
