%Кодирование информации согласно технологии MLT-3
function f = MLT3coder(b)
    s = size(b);
    f = b;
    currentLine = 0;
    %up - 1
    direction = 1;
    for k=1:s
        v = b(k);
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
end