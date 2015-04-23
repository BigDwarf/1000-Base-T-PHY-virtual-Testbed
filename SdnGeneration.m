function f = SdnGeneration(TXD, Scn,cs8)
 f = 1:9;
 for i =1:8
    f(i) = xor(TXD(i), Scn(i));
 end
 f(9) = cs8;
end