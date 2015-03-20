function f = scn_generating(sx,sy, tx_enable, tx_mode,n, n0)
    f = 1:8;
    if (tx_mode == 2)
        f(1) = 0;
    else
        f(1) = sy(1);
    end
    if (tx_mode == 2)
        f(2) = 0;
        f(3) = 0;
        f(4) = 0;
    else
        mr = mod(n-n0, 2);
        if (mr == 0)
            f(2) = sy(2);
            f(3) = sy(3);
            f(4) = sy(4);
        
        else
            oneM = [1 1 1];
            syM = 1:3;
            syM(1) = sy(1);
            syM(2) = sy(2);
            syM(3) = sy(3);
            res = xor(oneM, syM);
            f(2) = res(1);
            f(3) = res(2);
            f(4) = res(3);
        end
            
    end

    if (tx_enable == 1)
    f(5) = sx(1);
    f(6) = sx(2);
    f(7) = sx(3);
    f(8) = sx(4);
    else
        f(5) = 0;
        f(6) = 0;
        f(7) = 0;
        f(8) = 0;
    end


end