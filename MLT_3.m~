function [t_MLT3,MLT3_stream,fs] =MLT_3( bit_stream,sfs,fs )
[row_number,row_lenght]=size(bit_stream);
MLT3_stream=zeros(row_number,row_lenght.*sfs);
k=0;
prev_lvl=0; 
dt=(1/fs)/sfs;
t_MLT3=0:dt:(row_lenght)*(1/fs)-dt;
for i=1:row_number
    index=1;
    bit_index=1;
    for j=row_lenght:-1:1
        if(bit_stream(i,j)==1)
            if(k==0)
                MLT3_stream(i,index:bit_index*sfs)=prev_lvl+1;
                if(MLT3_stream(i,index)>1)
                    k=1;
                    MLT3_stream(i,index:bit_index*sfs)=0;
                end
            else
               MLT3_stream(i,index:bit_index*sfs)=prev_lvl-1;
                if(MLT3_stream(i,index)<-1)
                    k=0;
                    MLT3_stream(i,index:bit_index*sfs)=0;
                end
            end
        else
            MLT3_stream(i,index:bit_index*sfs)=prev_lvl;
        end
        prev_lvl=MLT3_stream(i,index);
        index=bit_index*sfs+1;
        bit_index=bit_index+1;
    end
end
fs = 1/dt;
end

