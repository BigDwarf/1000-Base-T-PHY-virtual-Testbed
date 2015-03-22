function [data] = repeat(str, n)
    data = (repmat(str ,[1,n])) ;
end