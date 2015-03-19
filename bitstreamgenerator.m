function [ bitStream ] = bitstreamgenerator( nBit , nRow )
%   Generator of four bit streams with length nBit
bitStream=round(rand(nRow,nBit));
end

