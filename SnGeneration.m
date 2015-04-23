function f = SnGeneration(Sg)
f = 1:4;
Srev = 1:4;
Srev(1) = 1;
Srev(2) = 1;
Srev(3) = 1;
Srev(4) = 1;
if (xor(Srev(1), Sg(1)) == 0)
    f(1) = 1;
else
    f(1) = -1;
end
if (xor(Srev(2), Sg(2)) == 0)
    f(2) = 1;
else
    f(2) = -1;
end
if (xor(Srev(3), Sg(3)) == 0)
    f(3) = 1;
else
    f(3) = -1;
end
if (xor(Srev(4), Sg(4)) == 0)
    f(4) = 1;
else
    f(4) = -1;
end
end