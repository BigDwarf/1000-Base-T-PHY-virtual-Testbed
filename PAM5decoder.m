function f = PAM5decoder(a)
    inputSize = size(a);
    numberOfChannel = inputSize(1);
    length = inputSize(2);
    f = 1:numberOfChannel*length;
    
    numberOfPair = 0;
    si = size(f);
    si = si(2);
    for i = 1: 8 : si
        f(si - i + 1) = a(1, numberOfPair*2 + 1);
        f (si - i ) = a (1, numberOfPair*2 + 2);
        f(si - i - 1) = a(2, numberOfPair*2 + 1);
        f(si - i - 2) = a(2, numberOfPair*2 + 2);
        f(si - i - 3) = a(3, numberOfPair*2 + 1);
        f(si - i - 4) = a(3, numberOfPair*2 + 2);
        f(si - i - 5) = a(4, numberOfPair*2 + 1);
        f(si - i - 6) = a(4, numberOfPair*2 + 2);
        i = i+7;
        numberOfPair = numberOfPair + 1;
    
      
    end
    


end