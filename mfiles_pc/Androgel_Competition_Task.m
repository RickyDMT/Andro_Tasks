function Androgel_Competition_Task(ID)

%Script for Androgel Competition Study
%Modified by Pablo Morales and Jason Hubbard, May 2014
%Featuring Ricky DMT on the gutbucket.

%clear variables
% clear %clears workspace
clc %clears command window
DEBUG=0;
Screen('Preference','SkipSyncTests',1); %%%DEBUG needs to be changed to zero when we actually run it

clearvars -global

global KEYS w w2 AllData Phase1 select allRects COLORS loaddir1 DIMS TIME_BASELINE xkeys macbook;


%%
%to list devices, use this command:
[keyboardIndices, productNames] = GetKeyboardIndices;

isxkeys=strcmp(productNames,'Xkeys');

xkeys=keyboardIndices(isxkeys);
macbook = keyboardIndices(strcmp(productNames,'Apple Internal Keyboard / Trackpad'));

if isempty(macbook)
    macbook=1; %ELK 5/28
    
end

if isempty(xkeys)
    xkeys=macbook;
end

xkeys
macbook

KEYS.xkeys=xkeys;
KEYS.macbook=macbook;
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%find the mfilesdir by figuring out where show_faces.m is kept
[mfilesdir,name,ext] = fileparts(which('Androgel_Competition_Task.m'));

%get the parent directory, which is one level up from mfilesdir
[parentdir,~,~] =fileparts(mfilesdir);


%create the paths to the other directories, starting from the parent
%directory
savedir = [parentdir filesep 'Results' filesep];
% textsavedir = [parentdir filesep 'Results/AllData_Text/'];
% loaddir1 = [parentdir filesep 'Results/Phase1_AllFiles/'];
% assignmentsdir = [parentdir filesep 'Assignments/'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% BioPac Setup
%This readies the BioPac unit. Uses io64 mex file from
%http://apps.usd.edu/coglab/psyc770/IO64.html with "address" hard coded
%into outp.m file (i.e., 8224 for room 133, 12320 for room 135). For other
%computers, find the parallel port address and input that hex value as a
%dec into the outp.m file.

%Trigger pulses coded in doCompeteTrial.m
config_io;
outp(0);


%%

if exist('ID','var')==0
    
    prompt={'SUBJECT ID' 'Do Competition? (1=Yes 0=No)' 'Do Feedback? (1=Yes 0=No)' 'xkeys index#' 'macbook index#'};
    defAns={'4444' '1' '1',num2str(xkeys),num2str(macbook)};
    
    answer=inputdlg(prompt,'Please input subject info',1,defAns);
    
    ID=str2double(answer{1});
    doPart1and2=str2double(answer{2});
    doPart3=str2double(answer{3});
    xkeys=str2double(answer{4});
    macbook=str2double(answer{5});
    
else
    
    doPart1and2=1;
    doPart3=1;
    % xkeys=str2double(answer{4});
    % macbook=str2double(answer{5});
    
end
%ListenChar(2);
%HideCursor;
KbName('UnifyKeyNames');

rng(ID,'twister');

AllData=Androgel_Design(ID);




% ID = input('Enter Subject ID:'); %Get subject ID number

% load([assignmentsdir num2str(ID)]);
AllData.TimeDate = datestr(clock);


numtrials=length(AllData.Opponent);


%PTB Setup
%Get proper key codes for answers
KbName('UnifyKeyNames');
left = KbName('leftarrow');
right = KbName('rightarrow');
up = KbName('uparrow');
down = KbName('downarrow');
tab = KbName('tab');
one = KbName('1!');
two = KbName('2@');
three = KbName('3#');
four = KbName('4$');
five = KbName('5%');
six = KbName('6^');
seven = KbName('7&');
eight = KbName('8*');
nine = KbName('9(');
zero = KbName('0)');

KEYS.LEFT=left;
KEYS.RIGHT=right;
KEYS.ONE=one;
KEYS.TWO=two;
KEYS.THREE=three;
KEYS.FOUR=four;

%Set colors
black = [0 0 0];
white = [255 255 255];
red = [255 0 0];
blue = [0 0 255];
green = [0 255 0];


%Set colors
COLORS.BLACK = [0 0 0];
COLORS.WHITE = [255 255 255];
COLORS.RED = [255 0 0];
COLORS.BLUE = [0 0 255];
COLORS.GREEN = [0 255 0];
COLORS.YELLOW = [255 255 0];

%Open Screen Window and set preferences


% 
% screennumber =max(Screen('Screens')); %gets screen number
% screennumber2 =min(Screen('Screens'));


screennumber =1; %min(Screen('Screens')); %gets screen number
screennumber2 = 2; %max(Screen('Screens'));


%change screen resolution
Screen('Resolution',screennumber,1024,768,[],32);

if screennumber~=screennumber2
    Screen('Resolution',screennumber2,1024,768,[],32);
end


[w, wrect] = Screen('OpenWindow', screennumber,0);
[xdim, ydim] = Screen('WindowSize', screennumber);
% Screen('Preference', 'VisualDebugLevel', 3);
% Screen('Preference', 'SuppressAllWarnings', 1);
Screen('TextFont', w, 'Arial');
Screen('TextStyle', w, 1);
Screen('TextSize',w,35);



if screennumber~=screennumber2
    
    [w2, wrect2] = Screen('OpenWindow', screennumber2,0);
    Screen('TextFont', w2, 'Arial');
    Screen('TextStyle', w2, 1);
    Screen('TextSize',w2,35);
    
end


if screennumber==screennumber2
    
    w2=w;
    
end

%%% For debugging purposes so it can run on one monitor
%     w=w2;


DIMS=struct;
DIMS.xdim=xdim;
DIMS.ydim=ydim;
DIMS.XCENTER=fix(xdim/2);
DIMS.YCENTER=fix(ydim/2);


%set up locations for all the stimuli
allRects=setUpRectangles();

%%
%Biopac: Pulse Ch1 x3 to show start of competition task
for startpulse = 1:3;
    outp(1);
    WaitSecs(.20);
    outp(0);
    WaitSecs(.05);
end

%%
if doPart1and2==1
    %%%%%%%%%%%%%%%%%%%%%%%% PART 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    % Part 1 begins here
    Screen('FillRect',w,COLORS.BLACK);
    DrawFormattedText(w,'Part 1\nPress any key to continue.','center','center',white);
    Screen('Flip', w);
    
    if w~=w2
        
        Screen('FillRect',w2,COLORS.BLACK);
        DrawFormattedText(w2,'Part 1\nPress any key to continue.','center','center',white);
        Screen('Flip', w2);
        
    end
    
    
    while 1 %waits for any key
        [Down Secs Code] = KbCheck();
        if Down == 1
            break;
        end
    end
    
    
    %Won't need this.
%     DrawFormattedText(w,'Part 1\nSyncing with scanner...','center','center',white);
%     Screen('Flip', w);
%     
%     while 1 %waits for trigger pulse from scanner (')
%         [Down Secs keyCode] = KbCheck(xkeys);
% %     [Down Secs keyCode] = KbCheck(macbook); %uncomment this if you want
% %     it to proceed using mac keyboard
%         if Down == 1 && keyCode(52)
%             TIME_BASELINE=Secs;
%             break;
%         end
%     end


    TIME_BASELINE=GetSecs;
    AllData.TIME_BASELINE=TIME_BASELINE;
    
    
%     Screen('FillRect', w, black);
%     DrawFormattedText(w,'+','center','center',white);
%     Screen('Flip', w);
%     
%      Screen('FillRect', w2, black);
%     DrawFormattedText(w2,'+','center','center',white);
%     Screen('Flip', w2);
%   
   
    
    WaitSecs(.5);
    
    
    %LOOP THROUGH EACH TRIAL.
    numtrials=length(AllData.Opponent);
    choice_positions=CoinFlip(numtrials,.50);
    
    
    
    for trial=1:numtrials;
        
        
        if trial==1
            % Part 1 begins here
            Screen('FillRect',w,COLORS.BLACK);
            DrawFormattedText(w,'Part 1\nPress any key to continue.','center','center',white);
            Screen('Flip', w);
            if w~=w2
                Screen('FillRect',w2,COLORS.BLACK);
                DrawFormattedText(w2,'Part 1\nPress any key to continue.','center','center',white);
                Screen('Flip', w2);
            end
        end
        
        
        %when we reach second run, wait for experimenter...
        if trial>1 && AllData.Run(trial)~=AllData.Run(trial-1)
            
            %%%%%%%%%%%%%%%%%%START PART 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % End part 1, scanner stops, scanner restarts
            
              %save this along the way, just in case..
%               save([assignmentsdir num2str(AllData.SubjectID) '_Part1Backup.mat'],'AllData');  
            
            DrawFormattedText(w,'Part 1 complete.\nPrepare for part 2. \nPress tab to continue','center','center',white);
            Screen('Flip', w);
            
            DrawFormattedText(w2,'Part 1 complete.\nPrepare for part 2. \nPress tab to continue','center','center',white);
            Screen('Flip', w2);
            
            while 1 %waits for tab key to be pressed
                [Down Secs Code] = KbCheck();
                if Down == 1 && Code(tab)
                    break;
                end
            end
            
            %ELK: Remove dat shit.
%             DrawFormattedText(w,'Part 2.\nSyncing with scanner...','center','center',white);
%             Screen('Flip', w);
%             
%             while 1
%                 [Down Secs Code] = KbCheck(xkeys);
%                 if Down == 1 && Code(52)
%                     TIME_BASELINE=Secs;
%                     break;
%                 end
%             end
            
%             TIME_BASELINE=GetSecs;
%             AllData.R2_BASELINE=TIME_BASELINE;
            
            Screen('FillRect', w, black);
            DrawFormattedText(w,'+','center','center',COLORS.WHITE);
            Screen('Flip', w);
%             %Biopac: Pulse Ch1 for "+".
                outp(1);
                
%             if AllData.Observe(trial)==1
%                 Screen('FillRect', w2, black);
%                 DrawFormattedText(w2,'+','center','center',white);
%                 Screen('Flip', w2);
%             elseif AllData.Observe(trial)==0
%                 Screen('FillRect', w2, black);
%                 DrawFormattedText(w2,'This is a private trial.','center','center',white);
%                 Screen('Flip', w2);
%             end
            
            WaitSecs(.5);
        end
        
        
        
        %randomise position of choices on each trial
        position=choice_positions(trial);
        
        dothedo = 100+trial;
        %this actually draws everything for the trials
        doCompeteTrial(trial,position);
        
    end
  
  %save this along the way, in case we need to start up at part 3 only..
%   save([assignmentsdir num2str(AllData.SubjectID) '_Part2Backup.mat'],'AllData');  
     
end


if doPart3==1
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN PART3%%%%%%%%%%%%%%%%%%%%%%%%%%
%Biopac: For start of Replay, pulse Ch1 x4
for startcomp2pulse = 1:4;
    outp(1);
    WaitSecs(.20);
    outp(0);
    WaitSecs(.05);
end

    %%%loading this file is for debug purposes
    if doPart1and2 == 0; 
    load('C:\Users\elk\Desktop\Code\Results\AllData_511.mat');
    end
     
    Screen('TextSize',w,30);
    
    Screen('FillRect',w,COLORS.BLACK);
    DrawFormattedText(w,'Part 1 Complete\n\nPrepare for part 2. \n\nPress tab to continue.','center','center',COLORS.WHITE);
    Screen('Flip', w);
    
    if w~=w2
    
    Screen('TextSize',w2,30);
    
    Screen('FillRect',w2,COLORS.BLACK);
    DrawFormattedText(w2,'Part 1 Complete\n\nPrepare for part 2. \n\nPress tab to continue.','center','center',COLORS.WHITE);
    Screen('Flip', w2);
    
    end
    
    
    while 1 %waits for tab key to be pressed
        [Down Secs Code] = KbCheck();%
        if Down == 1 && Code(tab)
            break;
        end
    end
    
    
    %instructions
    Screen('FillRect',w,COLORS.BLACK);
    DrawFormattedText(w,'Now you will see individuals you \ncompeted against and whether you won or lost. \n\nThen you will choose if you want to \ncompete against that individual one more time. \nAfterwards you will play one randomly drawn choice. \n\nPress tab to continue.','center','center',COLORS.WHITE,85,[],[],1.5);
    Screen('Flip',w);
   
    if w~=w2
        
        Screen('FillRect',w2,COLORS.BLACK);
        DrawFormattedText(w2,'Now you will see individuals you \ncompeted against and whether you won or lost. \n\nThen you will choose if you want to \ncompete against that individual one more time. \nAfterwards you will play one randomly drawn choice. \n\nPress tab to continue.','center','center',COLORS.WHITE,85,[],[],1.5);
        Screen('Flip',w2);
        
    end
    
    WaitSecs(1.0);
    
    while 1 %waits for tab key to be pressed
        [Down Secs Code] = KbCheck();%
        if Down == 1 && Code(tab)
            break
        end
    end
%     
%     DrawFormattedText(w,'Part 3.\nSyncing with scanner...','center','center',COLORS.WHITE);
%     Screen('Flip',w);
    
    %ELK: Remove that shit
%     while 1 %waits for trigger pulse from scanner (')
%         [Down Secs Code] = KbCheck(xkeys);
%         if Down == 1 && Code(52)
%             TIME_BASELINE=Secs;
%             break;
%         end
%     end
%     
    TIME_BASELINE=GetSecs;
    AllData.R3_BASELINE=TIME_BASELINE;
    
%     
%     Screen('TextSize',w,45);
%     Screen('FillRect', w, black);
%     DrawFormattedText(w,'+','center','center',COLORS.WHITE);
%     Screen('Flip', w);
%     
%     Screen('TextSize',w2,45);
%     Screen('FillRect', w2, black);
%     DrawFormattedText(w2,'+','center','center',COLORS.WHITE);
%     Screen('Flip', w2);
%     
%   
%     WaitSecs(.5);
    
%     competeTrials=find(AllData.TrialType==1 & AllData.Choice==1);
    competeTrials=find(AllData.TrialType==2);
    
    AllData.ReplayData=struct;
    AllData.ReplayData.TrialType=AllData.TrialType(competeTrials);
    AllData.ReplayData.LongWait=AllData.LongWait(competeTrials);
    AllData.ReplayData.Gender=AllData.Gender(competeTrials);
    AllData.ReplayData.Higher=AllData.Higher(competeTrials);
    AllData.ReplayData.Observe=AllData.Observe(competeTrials);
    AllData.ReplayData.Opponent=AllData.Opponent(competeTrials);
    AllData.ReplayData.WinLoseFirstTry=AllData.WinLose(competeTrials);
    AllData.ReplayData.ReplayChoice=nan(length(competeTrials),1);
    AllData.ReplayData.Score=nan(length(competeTrials),1);
%     AllData.ReplayData.WinLose=nan(length(competeTrials),1);
    AllData.ReplayData.OpponentPhoto=AllData.OpponentPhoto(competeTrials);
    
    
    %Data for equation rounds
    AllData.ReplayData.EquationData=struct;
    AllData.ReplayData.EquationData.Equations=cell(1,1);
    AllData.ReplayData.EquationData.TrueFalse=cell(1,1);
    AllData.ReplayData.EquationData.RT=cell(1,1);
    AllData.ReplayData.EquationData.Timestamps=cell(1,1);
    AllData.ReplayData.EquationData.Response=cell(1,1);
    AllData.ReplayData.EquationData.Accuracy=cell(1,1);
    
    
    
    AllData.ReplayData.resultsOnset= nan(length(competeTrials),1);
    AllData.ReplayData.choicesOnset= nan(length(competeTrials),1);
    AllData.ReplayData.choiceRespTime= nan(length(competeTrials),1);
    AllData.ReplayData.Choice_RT= nan(length(competeTrials),1);
    AllData.ReplayData.Did_Replay= zeros(length(competeTrials),1);
    AllData.ReplayData.Replay_WinLose= nan(length(competeTrials),1);
    AllData.ReplayData.OpponentEquation= cell(length(competeTrials),1);
    AllData.ReplayData.OpponentEquationTrue= cell(length(competeTrials),1);
    AllData.ReplayData.OpponentTotalRT= nan(length(competeTrials),1);
    AllData.ReplayData.OpponentScore= nan(length(competeTrials),1);
%     AllData.ReplayData.Choice= nan(length(competeTrials),1);
    AllData.ReplayData.Start_Equation_RT= nan(length(competeTrials),1);
    
    load('OpponentPool.mat');
    
    
%     replaytrial=randsample(16,1);
    
for i=1:length(competeTrials);
    
    opponent_id=AllData.ReplayData.Opponent(i);
    sub = num2str(opponent_id);
    subfield=['s',sub];
    
    replaytrial = randsample(16,1)+4;
    
    if AllData.ReplayData.Gender(i)==0;
        
        gender='Men';
        
    else gender='Women';
        
    end
    
    if AllData.ReplayData.Higher(i)==1;
        
        level='Higher';
        
    else level='Lower';
        
    end
    
    AllData.ReplayData.OpponentEquation{i}=OpponentSubset.(gender).(level).(subfield).Equation(:,replaytrial);
    AllData.ReplayData.OpponentEquationTrue{i}=OpponentSubset.(gender).(level).(subfield).True(:,replaytrial);
    AllData.ReplayData.OpponentScore(i)=OpponentSubset.(gender).(level).(subfield).Score(replaytrial);
    AllData.ReplayData.OpponentTotalRT(i)=OpponentSubset.(gender).(level).(subfield).TotalResponseTime(replaytrial);
    
end
    
%     cd(loaddir1);
    
    randomize_positions=CoinFlip(length(competeTrials),.5);
    
    for trial=1:length(competeTrials);
        
        current_opponent=AllData.ReplayData.Opponent(trial);
        
Screen('TextSize',w,35);
Screen('FillRect', w, black);    
DrawFormattedText(w,'+','center','center',COLORS.WHITE);
Screen('Flip',w);
%Biopac: Pulse Ch1 for "+"
outp(1);

if AllData.ReplayData.Observe(trial)==1 && w~=w2
    Screen('TextSize',w2,35);
    Screen('FillRect', w2, black);
    DrawFormattedText(w2,'+','center','center',COLORS.WHITE);
    Screen('Flip',w2);
elseif AllData.ReplayData.Observe(trial)==0 && w~=w2
    Screen('TextSize',w2,35);
    Screen('FillRect', w2, black);
    DrawFormattedText(w2,'This is a private trial.','center','center',COLORS.WHITE);
    Screen('Flip', w2);
end
    WaitSecs(.5); 
    
%         load([num2str(current_opponent) '.mat']);
        
        feedbacktext='';
        
        if AllData.ReplayData.WinLoseFirstTry(trial)==0
            feedbacktext='LOST';
        elseif AllData.ReplayData.WinLoseFirstTry(trial)==1
            feedbacktext='WON';
        end
        
        
        feedbacktext=['In this competition\nyou ' feedbacktext];
        
        Screen('TextSize',w,35);
        Screen('TextSize',w2,35);
        
        %%%
%         Screen('PutImage',w,Phase1.SubjectPhoto,allRects.photorect);


        Screen('PutImage',w,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
        %drawStatus(trial,'replay',w);
        resultsOnset=Screen('Flip',w);
        %Biopac: Pulse Ch2 for face
        outp(2);
        
        if AllData.ReplayData.Observe(trial)==1 && w~=w2
            Screen('PutImage',w2,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
            %drawStatus(trial,'replay',w2);
            resultsOnset=Screen('Flip',w2);
        end
        
        WaitSecs(3)
        
        Screen('PutImage',w,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
%         DrawFormattedText(w,feedbacktext,'center',allRects.option1_coords(2),COLORS.WHITE);
        drawObserve(trial,'replay',w);
        %drawStatus(trial,'replay',w);
        resultsOnset=Screen('Flip',w);
        
        %Biopac: Pulse Ch4 for public, Ch5 for private
        if AllData.ReplayData.Observe(trial)==1
            outp(4);
        elseif AllData.ReplayData.Observe(trial)==0
            outp(5);
        end
        
        if AllData.ReplayData.Observe(trial)==1 && w~=w2
            Screen('PutImage',w2,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
            %         DrawFormattedText(w,feedbacktext,'center',allRects.option1_coords(2),COLORS.WHITE);
            drawObserve(trial,'replay',w2);
            %drawStatus(trial,'replay',w2);
            resultsOnset=Screen('Flip',w2);
        end
        
        WaitSecs(3)
        
        Screen('PutImage',w,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
        DrawFormattedText(w,feedbacktext,'center',allRects.option1_coords(2),COLORS.WHITE,[],[],[],1.5);
        drawObserve(trial,'replay',w);
        %drawStatus(trial,'replay',w);
        resultsOnset=Screen('Flip',w);
        
        %Biopac: Pulse Ch40 for Win, Ch48 for Lose
        if AllData.ReplayData.WinLoseFirstTry(trial)==0
            %Lose
            outp(48);
        elseif AllData.ReplayData.WinLoseFirstTry(trial)==1
            %Win
            outp(40);
        end
        
        if AllData.ReplayData.Observe(trial)==1 && w~=w2
            Screen('PutImage',w2,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
            DrawFormattedText(w2,feedbacktext,'center',allRects.option1_coords(2),COLORS.WHITE,[],[],[],1.5);
            drawObserve(trial,'replay',w2);
            %drawStatus(trial,'replay',w2);
            resultsOnset=Screen('Flip',w2);
        end
        
        
        AllData.ReplayData.resultsOnset(trial)=resultsOnset-TIME_BASELINE;
        
        
        if AllData.ReplayData.LongWait == 1
            WaitSecs(3);
        else
            WaitSecs(3);
        end
        
        
        position=randomize_positions(trial);
        
        if position==0
            choiceleft='Replay';
            choiceright='Piece Rate';
        elseif position==1
            choiceleft='Piece Rate';
            choiceright='Replay';
        end
        
        
        Screen('PutImage',w,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
        Screen('TextSize',w,35);
        CenterTextOnPoint(w,'Do you want to compete again\n against this individual?',DIMS.XCENTER,allRects.option1_coords(2),COLORS.WHITE);
        drawChoices(trial,choiceleft,choiceright,[],w);
        drawObserve(trial,'replay',w);
        %drawStatus(trial,'replay',w);
        choicesOnset=Screen('Flip',w);
        %Biopac: Pulse Ch8 for options
        outp(8);
        
        if AllData.ReplayData.Observe(trial)==1 && w~=w2
            Screen('PutImage',w2,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
            Screen('TextSize',w2,35);
            CenterTextOnPoint(w2,'Do you want to compete again\n against this individual?',DIMS.XCENTER,allRects.option1_coords(2),COLORS.WHITE);
            drawChoices(trial,choiceleft,choiceright,[],w2);
            drawObserve(trial,'replay',w2);
            %drawStatus(trial,'replay',w2);
            choicesOnset=Screen('Flip',w2);
        end
        
        AllData.ReplayData.choicesOnset(trial)=choicesOnset-TIME_BASELINE;
        
        startsecs=GetSecs;
        
        while 1
            [Down responseSecs Code] = KbCheck();
            if Down==1 && (Code(KEYS.LEFT) || Code(KEYS.RIGHT));
                Screen('PutImage',w,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
                Screen('TextSize',w,35);
                CenterTextOnPoint(w,'Do you want to compete again\n against this individual?',DIMS.XCENTER,allRects.option1_coords(2),COLORS.WHITE);
                drawChoices(trial,choiceleft,choiceright,Code,w);
                drawObserve(trial,'replay',w);
                %drawStatus(trial,'replay',w);
                Screen('Flip',w);            
                rt=responseSecs-startsecs;
                
                
                if  AllData.ReplayData.Observe(trial)==1 && w~=w2
                    Screen('PutImage',w2,AllData.ReplayData.OpponentPhoto{trial},allRects.photorect);
                    Screen('TextSize',w2,35);
                    CenterTextOnPoint(w2,'Do you want to compete again\n against this individual?',DIMS.XCENTER,allRects.option1_coords(2),COLORS.WHITE);
                    drawChoices(trial,choiceleft,choiceright,Code,w2);
                    drawObserve(trial,'replay',w2);
                    %drawStatus(trial,'replay',w2);
                    Screen('Flip',w2);
                end
                 WaitSecs(.25); 
                break;
            end
        end
        
AllData.ReplayData.choiceRespTime(trial)=responseSecs-TIME_BASELINE;
AllData.ReplayData.Choice_RT(trial)=rt;
        
        %to prevent crashing.
        choice=-99;
        
        
        %determine the choice
        if Code(KEYS.LEFT) && position==0  %%%Replay
            choice=1;
        elseif Code(KEYS.RIGHT) && position==0 %%%Piece Rate
            choice=3;
        elseif Code(KEYS.LEFT) && position==1 %%%Piece rate
            choice=3;
        elseif Code(KEYS.RIGHT) && position==1  %%%Replay
            choice=1;
        end
        
        
        AllData.ReplayData.ReplayChoice(trial)=choice;
        
        Screen('TextSize',w,35);
        Screen('FillRect',w,COLORS.BLACK);
        DrawFormattedText(w,'+','center','center',COLORS.WHITE);
        Screen('Flip', w);
        %Biopac: Pulse Ch1 for "+"
        outp(1);
        
        Screen('TextSize',w2,35);
        Screen('FillRect',w2,COLORS.BLACK);
        DrawFormattedText(w2,'+','center','center',COLORS.WHITE);
        Screen('Flip', w2);
        
        
        if AllData.ReplayData.LongWait == 1
            WaitSecs(2);    %ELK: Reduced to 2 to account for additional time from BioPac
        else
            WaitSecs(2);    %ELK: Reduced to 2 to account for additional time from BioPac
        end
        
        
    end
    
end

%Biopac: For start of actual trial, pulse Ch1 x5
for startcomp2pulse = 1:5;
    outp(1);
    WaitSecs(.20);
    outp(0);
    WaitSecs(.05);
end


%%% This is where they will do the randomly drawn replay trial


DrawFormattedText(w,'Now you will play one \nrandomly drawn choice. \n\nPress tab to continue.','center','center',COLORS.WHITE,[],[],[],1.5);
Screen('Flip', w);

if w~=w2
    
    DrawFormattedText(w2,'Now you will play one \nrandomly drawn choice. \n\nPress tab to continue.','center','center',COLORS.WHITE,[],[],[],1.5);
    Screen('Flip', w2);
    
end

while 1 %waits for tab key to be pressed
    [Down Secs Code] = KbCheck();
    if Down == 1 && Code(tab)
        break;
    end
end;

replayopponent=randsample(16,1);

% replay_positions=CoinFlip(1,.50); 

AllData.ReplayData.Did_Replay(replayopponent)=1;
AllData.ReplayData.OpponentScore(replayopponent)=AllData.ReplayData.OpponentScore(replayopponent);

doReplayTrial(replayopponent);


% ListenChar;
ShowCursor;

%ELK: Update to "...for participating in this phase of the study."
DrawFormattedText(w,'Thank you for participating\n in this part of the study!','center','center',COLORS.WHITE,[],[],[],1.5);
Screen('Flip', w);

if w~=w2
    
    DrawFormattedText(w2,'Thank you for participating\n in this part of the study!','center','center',COLORS.WHITE,[],[],[],1.5);
    Screen('Flip', w2);
    
end
%%

%save this along the way, just in case..
%  save([assignmentsdir num2str(AllData.SubjectID) '_Part3Backup.mat'],'AllData');  

% %save our complete data
save([savedir 'AllData_' num2str(AllData.SUBID(1)) '.mat'],'AllData');
%%


WaitSecs(5);
Screen('CloseAll');
end