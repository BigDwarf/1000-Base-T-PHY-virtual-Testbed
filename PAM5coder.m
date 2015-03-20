function g = PAM5coder(a) 
    n1 = size(a); 
    n = n1(2)/4;
    k = 1; 
    g = zeros(4,n,'int32'); 
    to = n1(2); 
        for i = 1 : 8 : to 
            g(1,k) = a(to - i + 1); 
            g(1,k+1) = a(to - i); 
            g(2,k) = a(to - i - 1); 
            g(2,k+1) = a(to - i - 2); 
            g(3,k) = a(to - i - 3); 
            g(3,k+1) = a(to - i - 4); 
            g(4,k) = a(to - i - 5); 
            g(4,k+1) = a(to - i - 6); 
            k = k+2; 
        end
end