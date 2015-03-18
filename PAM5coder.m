function g = PAM5coder(a) 
    n1 = size(a); 
    disp(a);
    disp(n1);
    n = n1(2)/4;
    disp(class(n));
    k = 1; 
    g = zeros(4,n,'int32'); 
    to = n1(2); 
        for i = 1 : 8 : to 
            g(1,k) = a(i); 
            g(1,k+1) = a(i+1); 
            g(2,k) = a(i+2); 
            g(2,k+1) = a(i+3); 
            g(3,k) = a(i+4); 
            g(3,k+1) = a(i+5); 
            g(4,k) = a(i+6); 
            g(4,k+1) = a(i+7); 
            k = k+2; 
        end
end