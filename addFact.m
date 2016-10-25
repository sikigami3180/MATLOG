%add fact
%format: predicate,argNum,arg1,arg2,...,argN
function addFact(fact)
    s = size(fact);
    if length(s)~=2
        disp('dimention of fact must be 2');
        return;
    end
    n=s(1,1);
    
    for i=1:n
        %split
        str = fact(i,:);%get 1line
        %erase space
        str=strrep(str, ' ', '');
        c = strsplit(str,',');%split with ,
        if length(c)<3
            disp(['[',num2str(i),']dataNum is few']);
            continue;
        end
        
        %parse
        predicate = cell2mat(c(1));
        argNum = sscanf(char(c(2)), '%d*');
        argList = c(3:length(c));
        argStr = str( length(char(c(1)))+length(char(c(2)))+3:length(str) );
        if length(argList)~=argNum
            disp(['[',num2str(i),']argNum is wrong']);
            continue;
        end
        
        %check exist directory
        directory = ['predicate',num2str(argNum)];
        if exist(directory,'dir')==0
            mkdir(directory);
        end

        %open file
        fileID = fopen([directory,'/',predicate,'_fact.dat'],'a');

        %write file
        fprintf(fileID,'%s\n',argStr);

        %close file
        fclose(fileID);
    end
end