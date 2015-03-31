%??????????? ?????????? ???????? ?????????? MLT-3
function c = MLT3coder(b,fs)
    s = size(b);
    s = s(1);
    disp(s);
    f = b;
    currentLine = 0;
    %up - 1
    direction = 1;
    for k=1:s
        disp(b(s - k + 1));
        v = b(s - k + 1);
        if(v == 0)
            f(k) = currentLine;
        else
            if(direction == 1 && currentLine == 1)
                direction = -1;
                f(k) = 0;
                currentLine = 0;
            else
                if(direction == -1 && currentLine == -1)
                    direction = 1;
                    f(k) = 0;
                    currentLine = 0;
                else
                    if (direction == 1 && currentLine ~= 1)
                        currentLine = currentLine + 1;
                        f(k) = currentLine;
                        disp('_');
                        disp(k);
                    else
                        if(direction == -1 && currentLine ~= -1)
                            currentLine = currentLine - 1;
                            f(k) = currentLine;
                        end
                    end
                end
            end 
        end               
    end 
    c = kron(f, ones(fs,1));
end