function ChoiceFeedback(ID);

global KEYS w w2 AllData Phase1 select allRects COLORS loaddir1 DIMS TIME_BASELINE xkeys macbook;

%%

%find the mfilesdir by figuring out where show_faces.m is kept
[mfilesdir,name,ext] = fileparts(which('ChoiceFeedback.m'));

%get the parent directory, which is one level up from mfilesdir
[parentdir,~,~] =fileparts(mfilesdir);


%create the paths to the other directories, starting from the parent
%directory
resultsDir = [parentdir filesep 'Results' filesep];

cd(resultsDir);

DEBUG=0;
Screen('Preference','SkipSyncTests',1); %%%DEBUG needs to be changed to zero when we actually run it

%Open Screen Window and set preferences

screennumber = 1; %min(Screen('Screens')); %gets screen number
screennumber2 = 2; %max(Screen('Screens'));



%change screen resolution
% Screen('Resolution',screennumber,1024,768,[],32);
% 
% if screennumber~=screennumber2
%    Screen('Resolution',screennumber2,1024,768,[],32);
% end

[w, wrect] = Screen('OpenWindow', screennumber,0);
[xdim, ydim] = Screen('WindowSize', screennumber);
% Screen('Preference', 'VisualDebugLevel', 3);
% Screen('Preference', 'SuppressAllWarnings', 1);
Screen('TextFont', w, 'Arial');
Screen('TextStyle', w, 1);
Screen('TextSize',w,30);
KbName('UnifyKeyNames');



if screennumber~=screennumber2
    
    [w2, wrect2] = Screen('OpenWindow', screennumber2);
    Screen('TextFont', w2, 'Arial');
    Screen('TextStyle', w2, 1);
    Screen('TextSize',w2,30);
    
end


if screennumber==screennumber2
    
    w2=w;
    
end

%%
COLORS.BLACK = [0 0 0];
COLORS.WHITE = [255 255 255];
COLORS.RED = [255 0 0];
COLORS.BLUE = [0 0 255];
COLORS.GREEN = [0 255 0];

DIMS=struct;
DIMS.xdim=xdim;
DIMS.ydim=ydim;
DIMS.XCENTER=fix(xdim/2);
DIMS.YCENTER=fix(ydim/2);

tab = KbName('tab');

load(['AllData_' num2str(ID) '.mat']);
load(['proDMT_' num2str(ID) '.mat']);

%%

    
    %%% This gives you all wins and losses in the non-observe (private) condition that
    %%% were the result of choosing to compete in choice trials
    subset1=AllData.WinLose(AllData.Observe==0 & AllData.TrialType==1 & AllData.Choice==1);
    
    %%% This gives you all wins and losses in the observe (public) condition that
    %%% were the result of choosing to compete in choice trials
    subset2=AllData.WinLose(AllData.Observe==1 & AllData.TrialType==1 & AllData.Choice==1);
    
    %%% Total number of choice competitions in private trials
    totalCompsPrivate=length(subset1);
    %%% Choice competitions won in private trials
    compsWonPrivate=sum(subset1);
    %%% Choice competitions lost in private trials
    compsLostPrivate=totalCompsPrivate-compsWonPrivate;
    
    %%% Total number of choice competitions in public trials
    totalCompsPublic=length(subset2);
    %%% Choice competitions won in public trials
    compsWonPublic=sum(subset2);
    %%% Choice competitions lost in public trials
    compsLostPublic=totalCompsPublic-compsWonPublic;
    


    
%%% This is the total amount of money you could have sacrificed in public
%%% trials
SumDealsPublic=(sum(proDMT.Var.Money_Endowed(proDMT.Var.Observe==1)));
%%% This is the total amount of money you actually sacrificed in public
%%% trials
SumSacrificePublic=sum(proDMT.Data.Amt_Donated(proDMT.Var.Observe==1));
%%% This is the charity's total earnings (with multiplier) in public trals
SumCharityEarningsPublic=sum(proDMT.Data.Amt_Char(proDMT.Var.Observe==1));

% subset3=(proDMT.Var.Money_Endowed(proDMT.Var.Observe==1));

%%% This is the total amount of money you could have sacrificed in private
%%% trials
SumDealsPrivate=sum(proDMT.Var.Money_Endowed(proDMT.Var.Observe==2));
%%% This is the total amount of money you actually sacrificed in private
%%% trials
SumSacrificePrivate=sum(proDMT.Data.Amt_Donated(proDMT.Var.Observe==2));
%%% This is the charity's total earnings (with multiplier) in private trals
SumCharityEarningsPrivate=sum(proDMT.Data.Amt_Char(proDMT.Var.Observe==2));



% subset4=(proDMT.Var.Money_Endowed(proDMT.Var.Observe==2));

%%% This is for debugging to ensure that there are an equal number of
%%% money deals across conditions
% length(find(proDMT.Var.Money_Endowed==4 & proDMT.Var.Observe==2))

%%


Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'Now you will see the overall outcomes of your \nchoices in this experiment. \n\nOutcomes of choices you made in private trials \nwill only be made known to you. \n\nOutcomes of choices you made in public trials \nwill be posted to the website along with your photo. \n\nPress tab to continue.','center','center',COLORS.WHITE,65);
Screen('Flip',w);

if w~=w2
    
    Screen('FillRect',w2,COLORS.BLACK);
 DrawFormattedText(w,'Now you will see the overall outcomes of your \nchoices in this experiment. \n\nOutcomes of choices you made in private trials \nwill only be made known to you. \n\nOutcomes of choices you made in public trials \nwill be posted to the website along with your photo. \n\nPress tab to continue.','center','center',COLORS.WHITE,65);
Screen('Flip',w2);
end

WaitSecs(1.0);

while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();%
    if Down == 1 && Code(tab)
        break
    end
end

% CenterTextOnPoint(w,sprintf('Please choose a lottery to commit to\n Every error will cost $%3.2f',STIM.SWITCH_PENALTY_HIGH),STIM.XCENTER,STIM.YCENTER-250,COLORS.WHITE);

%%% This shows public competition feedback

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You PUBLICLY chose to compete in %d rounds',totalCompsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You WON %d of these rounds',compsWonPublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You LOST %d of these rounds',compsLostPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w);  

Screen('FillRect',w2,COLORS.BLACK);
CenterTextOnPoint(w2,sprintf('You PUBLICLY chose to compete in %d rounds',totalCompsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You WON %d of these rounds',compsWonPublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You LOST %d of these rounds',compsLostPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w2);

WaitSecs(4)

CenterTextOnPoint(w,sprintf('You PUBLICLY chose to compete in %d rounds',totalCompsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You WON %d of these rounds',compsWonPublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You LOST %d of these rounds',compsLostPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w);

CenterTextOnPoint(w2,sprintf('You PUBLICLY chose to compete in %d rounds',totalCompsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You WON %d of these rounds',compsWonPublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You LOST %d of these rounds',compsLostPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w2);

while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();
    if Down == 1 && Code(tab)
        break;  
    end
end

%%% This shows private competition feedback

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You PRIVATELY chose to compete in %d rounds',totalCompsPrivate),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You WON %d of these rounds',compsWonPrivate),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You LOST %d of these rounds',compsLostPrivate),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w);

Screen('FillRect',w2,COLORS.BLACK);
CenterTextOnPoint(w2,sprintf('These results are private.'),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w2);

WaitSecs(4)

CenterTextOnPoint(w,sprintf('You PRIVATELY chose to compete in %d rounds',totalCompsPrivate),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You WON %d of these rounds',compsWonPrivate),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You LOST %d of these rounds',compsLostPrivate),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w);

while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();
    if Down == 1 && Code(tab)
        break;  
    end
end




%%% This shows public prosocial feedback

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You could have PUBLICLY donated $%3.2f',SumDealsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You donated $%3.2f',SumSacrificePublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('FFLC earned $%3.2f',SumCharityEarningsPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w);

Screen('FillRect',w2,COLORS.BLACK);
CenterTextOnPoint(w2,sprintf('You could have PUBLICLY donated $%3.2f',SumDealsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You donated $%3.2f',SumSacrificePublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('FFLC earned $%3.2f',SumCharityEarningsPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w2);

WaitSecs(4)

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You could have PUBLICLY donated $%3.2f',SumDealsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You donated $%3.2f',SumSacrificePublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('FFLC earned $%3.2f',SumCharityEarningsPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w);

Screen('FillRect',w2,COLORS.BLACK);
CenterTextOnPoint(w2,sprintf('You could have PUBLICLY donated $%3.2f',SumDealsPublic),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('You donated $%3.2f',SumSacrificePublic),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('FFLC earned $%3.2f',SumCharityEarningsPublic),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
CenterTextOnPoint(w2,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w2);

while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();
    if Down == 1 && Code(tab)
        break;  
    end
end

%%% This shows private prosocial feedback

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You could have PRIVATELY given up $%3.2f',SumDealsPrivate),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You gave up $%3.2f',SumSacrificePrivate),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('FFLC earned $%3.2f',SumCharityEarningsPrivate),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w);

Screen('FillRect',w2,COLORS.BLACK);
CenterTextOnPoint(w2,sprintf('These results are private.'),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w2);

WaitSecs(4)

Screen('FillRect',w,COLORS.BLACK);
CenterTextOnPoint(w,sprintf('You could have PRIVATELY given up $%3.2f',SumDealsPrivate),DIMS.XCENTER,DIMS.YCENTER-200,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('You gave up $%3.2f',SumSacrificePrivate),DIMS.XCENTER,DIMS.YCENTER-100,COLORS.WHITE);
CenterTextOnPoint(w,sprintf('FFLC earned $%3.2f',SumCharityEarningsPrivate),DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);                                
CenterTextOnPoint(w,sprintf('Press tab to continue'),DIMS.XCENTER,DIMS.YCENTER+100,COLORS.WHITE);
Screen('Flip', w);


while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();
    if Down == 1 && Code(tab)
        break;
    end
end



CenterTextOnPoint(w,'Thank you for participating!',DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w);

CenterTextOnPoint(w2,'Thank you for participating!',DIMS.XCENTER,DIMS.YCENTER,COLORS.WHITE);
Screen('Flip', w2);

WaitSecs(3);

Screen('CloseAll');

end




