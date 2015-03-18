function f = PAM5decoder(a)
    inputSize = size(a);
    numberOfChannel = inputSize(1);
    length = inputSize(2);
    f = 1:numberOfChannel*length;
    
    numberOfPair = 0;
    si = size(f);
    for i = 1: 8 : si(2)
        f(i) = a(1, numberOfPair*2 + 1);
        f (i + 1) = a (1, numberOfPair*2 + 2);
        f(i + 2) = a(2, numberOfPair*2 + 1);
        f(i + 3) = a(2, numberOfPair*2 + 2);
        f(i + 4) = a(3, numberOfPair*2 + 1);
        f(i + 5) = a(3, numberOfPair*2 + 2);
        f(i + 6) = a(4, numberOfPair*2 + 1);
        f(i + 7) = a(4, numberOfPair*2 + 2);
        i = i+7;
        numberOfPair = numberOfPair + 1;
    
      
    end
    


end
