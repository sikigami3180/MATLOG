function clearFactAndChain()
    if exist('predicate*','dir')
        rmdir('predicate*','s');
    end
end