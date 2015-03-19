function [ bitStream ] = bitstreamgenerator( nBit )
%   Generator of four bit streams with length nBit
bitStream=round(rand(4,nBit));
end

