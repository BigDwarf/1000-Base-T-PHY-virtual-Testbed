function [resultX resultY resultG, newScr] = LFSRieee(scr1)

resultLength = 4;
resultX = 1:resultLength;
resultY = 1:resultLength;
resultG = 1:resultLength;


resultY(1) = scr1(1);
resultY(2) = xor(scr1(4), scr1(9));
resultY(3) = xor(scr1(7), scr1(17));
x1 = xor(scr1(10), scr1(15));
x2 = xor(x1, scr1(20));
resultY(4) = xor(x2, scr1(25));

resultX(1) = xor(scr1(5), scr1(7));
resultX(2) = xor(scr1(15), xor(scr1(13), xor(scr1(10), scr1(8))));
resultX(3) = xor(scr1(23), xor(scr1(21), xor(scr1(13), scr1(11))));
resultX(4) = mod(scr1(31) + scr1(29) + scr1(26) + scr1(24) + scr1(21) + scr1(19) + scr1(16) + scr1(14), 2);


resultY(1) = scr1(1);
resultY(2) = xor(scr1(4), scr1(9));
resultY(3) = xor(scr1(7), scr1(17));
x1 = xor(scr1(10), scr1(15));
x2 = xor(x1, scr1(20));
resultY(4) = xor(x2, scr1(24));

resultX(1) = xor(scr1(5), scr1(7));
resultX(2) = xor(scr1(15), xor(scr1(13), xor(scr1(10), scr1(8))));
resultX(3) = xor(scr1(23), xor(scr1(21), xor(scr1(13), scr1(11))));
resultX(4) = mod(scr1(31) + scr1(29) + scr1(26) + scr1(24) + scr1(21) + scr1(19) + scr1(16) + scr1(14),2);


resultG(1) = xor(scr1(2), scr1(6));
resultG(2) = xor(scr1(5), xor(scr1(9), xor(scr1(10), scr1(14))));
resultG(3) = xor(scr1(8), xor(scr1(12), xor(scr1(18), scr1(22))));
resultG(4) = mod(scr1(11) + scr1(15) + scr1(16) + scr1(20) + scr1(21) + scr1(25) + scr1(26) + scr1(29), 2);

newScr = 1:33;
newScr(1) = xor(1, xor(scr1(13), scr1(33)));
for i=2:33;
    newScr(i) = scr1(i-1);
end
end