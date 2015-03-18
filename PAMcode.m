function f = PAM5code(a)
    s = size(a);
    f = 1:s(2);
    for i = 1 : 2 : s(2)
        if (a(i) == 1)
            if (a(i+1) == 1)
                f(i) = 2;
                f(i + 1) = 2;
            else
                f(i) = 1;
                f(i + 1) = 1;
            end
        else
           if (a(i+1) == 1)
               f(i) = -1;
               f(i + 1) = -1;
           else
                f(i) = -2;
                f(i + 1) = -2;
            end 
        end
    end
end