function f = array2Number(a)
 length = size(a,2);
 prevN = 1;
 f = 0;
for i = 1: length
    f = f + prevN * a(length - i + 1);
    prevN = prevN * 2;
end