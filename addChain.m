%add chain
%format: predicate,argNum,
%chain1,cArgNum1,cArg1-1,...,
%chain2,cArgNum2,cArg2-1,...
%cArg < argNum
function addChain(chain)
    s = size(chain);
    if length(s)~=2
        disp('dimention of fact must be 2');
        return;
    end
    n=s(1,1);
    
    for i=1:n
        %split
        str = chain(i,:);%get 1line
        %erase space
        str=strrep(str, ' ', '');
        c = strsplit(str,',');%split with ,
        if length(c)<5
            disp(['[',num2str(i),']dataNum is few']);
            continue;
        end
        
        %parse
        predicate = cell2mat(c(1));
        argNum = sscanf(char(c(2)), '%d*');
        
        j=4;
        data=[];
        f=1;
        %this is not good code...
        %it should not change size of matrix in the loop...
        while j<=length(c)&&f
            data=[data,char(c(j-1)),',',char(c(j)),','];
            cArgNum = sscanf(char(c(j)), '%d*');
            index = j+cArgNum;
            j=j+1;
            while j<=index&&j<=length(c)&&f
                if isempty(sscanf(char(c(j)), '%d*'))
                    disp(['[',num2str(i),']cArg is not num']);
                    f=0;
                elseif sscanf(char(c(j)), '%d*')>argNum
                    disp(['[',num2str(i),']cArg is out of length']);
                    f=0;
                else
                    data=[data,'X',char(c(j))];
                    cArgNum=cArgNum-1;
                    if cArgNum==0
                        data=[data,':'];
                    else
                        data=[data,','];
                    end
                    j=j+1;
                end
            end
            j=j+1;
            if cArgNum~=0
                disp(['[',num2str(i),']cArg is wrong']);
                f=0;
            end
        end
        
        if f==1
            %check exist directory
            directory = ['predicate',num2str(argNum)];
            if exist(directory,'dir')==0
                mkdir(directory);
            end
        
            %open file
            fileID = fopen([directory,'/',predicate,'_chain.dat'],'a');

            %write file
            fprintf(fileID,'%s\n',data(1:length(data)-1));%last char is not used.

            %close file
            fclose(fileID);
        end
    end
end