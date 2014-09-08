%%% This master script can run the competition task, prosocial task, and
%%% can show the overall feedback. If you need to run any specific scipt on
%%% its own, you can do so by entering the appropriate inputs into the
%%% dialogue box
%%
clear all

prompt={'SUBJECT ID' 'Do Task #1? (1=Yes 0=No)' 'Do Task #2? (1=Yes 0=No)' 'Do Results? (1=Yes 0=No)'};
defAns={'4444' '1' '1' '1'};

answer=inputdlg(prompt,'Please input subject info',1,defAns);

ID=str2double(answer{1});
do_comp=str2double(answer{2});
do_prosocial=str2double(answer{3});
do_results=str2double(answer{4});

%%

%%% This is the script for the Competition Task
if do_comp == 1
    
Androgel_Competition_Task(ID);

end

%%% This is the script for the Prosocial Task
if do_prosocial == 1
    
    prosocial_task_dualmon(ID);
    
end

%%% This is the script for the overall results
if do_results == 1
    
    ChoiceFeedback(ID);
    
end