function [data] = repeat(str, n)
data = str;
    for i = 1 : n-1
        data = strcat(data,str);
    end
end