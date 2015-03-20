function f = MLT3decoder(a)
     s = size(a);
     if (s(1) < s(2))
         s = s(2);
     else
         s = s(1);
     end
    if(a(1) == 1)
        f(s) = 1;
     else f(1) = 0;
    end
    
    for i = 2 : s
        if(a(i) == a(i-1))
            f(s - i + 1) = 0;
        else
            f(s - i + 1) = 1;
            
        end
    end
        
end