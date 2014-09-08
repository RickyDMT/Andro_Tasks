function [displayeqn correct]=generateEquation


%This will produce an equation of the form a + b - c + d with a solution
%between 1 and 9
%%
eqn = makeNewEqn;
eqnsol = eval(eqn);

if eqnsol <1 || 9 < eqnsol
    while eqnsol <1 || 9 < eqnsol
        eqn = makeNewEqn;
        eqnsol = eval(eqn);
    end
end  
    
    %determine true/false
    a = round(rand);
    if a == 0 %answer is true
        displayeqn = [eqn '=' num2str(eqnsol)];
        correct=1;
        %         Phase2.True(eqation_num,trial) = 1;
        
    elseif a == 1 %answer is false
        
        %must determine whether false answer should be off by 1 or 2
        falsecondition = round(rand);
        
        if falsecondition == 0 %answers off by 1
            b = round(rand); %Generate false answers here
            if b == 0 && eqnsol < 9 || b == 1 && eqnsol == 1 %Answers off by 1
                displaysol = eqnsol + 1;
            elseif  b == 1 && eqnsol > 1 || b == 0 && eqnsol == 9
                displaysol = eqnsol - 1;
            end
            
        elseif falsecondition == 1 %answers off by 2
            
            b = round(rand); %chooses whether answers should be above or below correct answer
            if b == 0 && eqnsol < 8 || b == 1 && eqnsol == 1 || b == 1 && eqnsol == 2 %Answers off by 2
                displaysol = eqnsol + 2;
            elseif  b == 1 && eqnsol > 2 || b == 0 && eqnsol == 9 || b == 0 && eqnsol == 8
                displaysol = eqnsol - 2;
            end
        end
        
        correct=0;
        %         Phase2.True(eqation_num,trial) = 0; %#ok<*IJCL>
        displayeqn = [eqn '=' num2str(displaysol)];
        
        
        
    end
    
end



function eqn = makeNewEqn
numbers = [1:9];
plusminus = Shuffle(char('+', '-'));

eqnvect = [numbers(ceil(9*rand)), numbers(ceil(9*rand)), numbers(ceil(9*rand))];

%Makes sure all numbers are unique
if eqnvect(1) == eqnvect(2) || eqnvect(1) == eqnvect(3) || eqnvect(2) == eqnvect(3)
    
    while eqnvect(1) == eqnvect(2) || eqnvect(1) == eqnvect(3) || eqnvect(2) == eqnvect(3)
        
        eqnvect = [numbers(ceil(9*rand)), numbers(ceil(9*rand)), numbers(ceil(9*rand))];
        
    end
end


eqn = [num2str(eqnvect(1)) plusminus(1) num2str(eqnvect(2)) plusminus(2) num2str(eqnvect(3))];
end
