function t=evaluate(expr)
    s = size(expr);
    if length(s)~=2
        disp('dimention of fact must be 2');
        return;
    end
    
    n=s(1,1);
    t=zeros(n,1);
    for i=1:n
        %split
        str = expr(i,:);%get 1line
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
            disp(['[',num2str(i),']predicate not exist']);
            continue;
        end
        
        %first check fact
        if exist([directory,'/',predicate,'_fact.dat'],'file')
            fileID = fopen([directory,'/',predicate,'_fact.dat'],'r');
            factStr = fgetl(fileID);
            while ischar(factStr)&&~t(i,1)
                t(i,1) = strcmp(factStr,argStr);
                factStr = fgetl(fileID);
                if ~ischar(factStr)
                    break;
                end
            end
            fclose(fileID);
        end
         
        %second check chain
        if exist([directory,'/',predicate,'_chain.dat'],'file')
            fileID = fopen([directory,'/',predicate,'_chain.dat'],'r');
            chainStr = fgetl(fileID);
            while ischar(chainStr)||~t(i,1)
                for j=1:argNum
                    chainStr=strrep(chainStr, [',X',num2str(j)], [',',char(argList(j))]);
                end
                chainList = strsplit(chainStr,':');
                tmp=0;
                for j=1:length(chainList)
                    tmp=tmp+evaluate(char(chainList(j)));
                end
                t(i,1)=t(i,1)||(tmp==length(chainList));
                chainStr = fgetl(fileID);
                if ~ischar(chainStr)
                    break;
                end
            end
            fclose(fileID);
        end
    end
end