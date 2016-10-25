%example
clearFactAndChain();
%!tips! size of string must be same length every row.
addFact(['red,1,fuji   ';'sphere,1,fuji']); % Fuji is red and sphere.
addChain('apple,1,red,1,1,sphere,1,1'); % If X is red and X is sphere then X is an apple.
addChain('sweet,1,apple,1,1'); % If X is an apple then X is sweet.
a1=evaluate('vegetable,1,fuji'); % Is fuji a vegetable? ->false.
a2=evaluate('apple,1,fuji'); % Is fuji an apple? ->true.
a3=evaluate('sweet,1,fuji'); % Is fuji sweet? ->true.(Because fuji is an apple.)

addFact('miyabi,1,I'); % I am miyabi.
addFact('cat,1,kuro'); % Kuro is a cat.
addChain('love,2,miyabi,1,1,cat,1,2'); %If X is miyabi and Y is a cat, then X loves Y.
a4=evaluate('love,2,I,kuro');% Do I love kuro? ->true.
a5=evaluate('love,2,I,dogs');% Do I love dogs? ->false.
[a1 a2 a3 a4 a5]