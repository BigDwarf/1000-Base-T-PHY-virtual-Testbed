function f = MLT3decoder(a)
    if(a(1) == 1)
        f(1) = 1;
     else f(1) = 0;
    end
    
    for i = 2 : size(a)
        if(a(i) == a(i-1))
            f(i) = 0;
        else
            f(i) = 1;
            
        end
    end
        
end