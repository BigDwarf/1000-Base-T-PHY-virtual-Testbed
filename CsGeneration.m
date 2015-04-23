function f = CsGeneration(sd67, csPrev)
    f = 1:3;
    f(1) = csPrev(3);
    f(2) = xor(sd67(1),csPrev(1));
    f(3) = xor(sd67(2), csPrev(2));

end