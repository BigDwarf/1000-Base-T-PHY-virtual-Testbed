function [ t_PAM5,PAM5_stream,fs] = PAM_5( bit_stream,sfs,fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[row_number,row_lenght]=size(bit_stream);
dt=1/fs/sfs;
t_PAM5=0:dt:(row_lenght/2)*(1/fs)-dt;
if(mod(row_lenght,2)==0)
    new_stream=zeros(row_number,row_lenght);
    new_stream=bit_stream;
else
    new_stream=zeros(row_number,row_lenght+1);
    new_stream(:,1:row_lenght)=bit_stream;
end
[row_number,row_lenght]=size(new_stream);
PAM5_stream=zeros(row_number,row_lenght/2*sfs);
for i=1:row_number
    index=1;
    bit_index=1;
    for j=row_lenght-1:-2:1
       if(new_stream(i,j)==0)
           if(new_stream(i,j+1)==0)
                PAM5_stream(i,index:bit_index*sfs)=-2;
           else
                PAM5_stream(i,index:bit_index*sfs)=-1;
           end
       else
           if(new_stream(i,j+1)==0)
                PAM5_stream(i,index:bit_index*sfs)=1;
           else
                PAM5_stream(i,index:bit_index*sfs)=2;
           end
       end
       index=bit_index*sfs+1;
       bit_index=bit_index+1;
    end
end

fs = 1/dt;
end

