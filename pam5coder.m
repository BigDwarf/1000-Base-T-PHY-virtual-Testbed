function [t,a] = pam5coder(TXD)
isFirst = 1;

txdSize = size(TXD);
csFirst = [0, 0, 0];
newScr = 1:33;
csPrev = 1:3;
table1 = 256:4;
table2 = 256:4;
[table1,table2] = initializeTables();
currentResult = 1:4;
t = 1:txdSize*4;
a = 1:txdSize*4;
for i = 1:txdSize(2)/4;
    if (isFirst == 1)
        newScr = [1, 0 , 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1];
    end
    [sx,sy,sg,newScr] = LFSRieee(newScr);
    scn = ScnGeneration(sx,sy);
    
    if (isFirst == 1)
        sdn = SdnGeneration(TXD, scn,csFirst(3));
        csPrev = csFirst;
    else
        sdn = SdnGeneration(TXD,scn, csPrev(3));
    end
    cs = CsGeneration([sdn(7), sdn(8)],csPrev);
    
    csPrev = cs;
    
    numberOfTables = sdn(9);
    numberOfColumn = array2Number([sdn(1), sdn(2), sdn(3),sdn(4),sdn(5),sdn(6)]) - 1;  
    numberOfRows  = array2Number([sdn(7),sdn(8),sdn(9)]);
    if (numberOfTables == 0)
      if (numberOfRows == 0)
          currentResult = table1(numberOfColumn + 1,:);
      else
          if (numberOfRows == 2)
              currentResult = table1(numberOfColumn + 2,:);
          else
              if ( numberOfRows == 4)
                  currentResult = table1(numberOfColumn + 3,:);
              else
                  currentResult = table1(numberOfColumn + 4,:);
              end
          end
      end
    else
        if (numberOfRows == 1)
          currentResult = table2(numberOfColumn + 1,:);
        else
          if (numberOfRows == 3)
              currentResult = table2(numberOfColumn + 2,:);
          else
              if ( numberOfRows == 5)
                  currentResult = table2(numberOfColumn + 3,:);
              else
                  currentResult = table2(numberOfColumn + 4,:);
              
              end    
          end
        end
    end
    disp(currentResult);
    t((i-1)*4 + 1) = currentResult(1);
    t((i-1)*4 + 2) = currentResult(2);
    t((i-1)*4 + 3) = currentResult(3);
    t((i-1)*4 + 4) = currentResult(4);
    sn = SnGeneration(sg);
    a((i-1)*4 + 1) = sn(1)* currentResult(1);
    a((i-1)*4 + 2) = sn(2)* currentResult(2);
    a((i-1)*4 + 3) = sn(3)* currentResult(3);
    a((i-1)*4 + 4) = sn(4)* currentResult(4);
    if( isFirst == 1)
        isFirst = 0;
    end
    
end
end