function Androgel_Replay_Trial

%% outside the magnet performance section -- for replay section

global KEYS w Phase2 Phase1 select allRects COLORS loaddir1 DIMS TIME_BASELINE xkeys macbook AllData;


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%find the mfilesdir by figuring out where show_faces.m is kept
[mfilesdir,name,ext] = fileparts(which('Androgel_Replay_Trial.m'));

%get the parent directory, which is one level up from mfilesdir
[parentdir,~,~] =fileparts(mfilesdir);


%create the paths to the other directories, starting from the parent
%directory
savedir = [parentdir filesep 'Results/Phase2_Results/'];
loaddir1 = [parentdir filesep 'Results/Phase1_AllFiles/'];
loaddir2 = [parentdir filesep 'Results/Phase2_Results/'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


KEYS=struct;
KEYS.LEFT=KbName('LeftArrow');
KEYS.RIGHT=KbName('RightArrow');

%Set colors
black = [0 0 0];
white = [255 255 255];
red = [255 0 0];
blue = [0 0 255];
green = [0 255 0];


COLORS.WHITE=[255 255 255];
COLORS.BLACK=[0 0 0];
COLORS.RED=[255 0 0 ];
COLORS.BLUE=[0 0 255];
COLORS.GREEN=[0 255 0];


commandwindow

%%% Fix this
sub = input('Enter Subject ID:'); %Get subject ID number

%Open Screen Window and set preferences
screennumber =max(Screen('Screens')); %gets screen number
screennumber2 =min(Screen('Screens'));

%change screen resolution
Screen('Resolution',0,1024,768,[],32);

[w, wrect] = Screen('OpenWindow', screennumber);
[xdim, ydim] = Screen('WindowSize', screennumber);
% Screen('Preference', 'VisualDebugLevel', 3);
% Screen('Preference', 'SuppressAllWarnings', 1);
Screen('TextFont', w, 'Arial');
Screen('TextStyle', w, 1);
Screen('TextSize',w,45);

DIMS=struct;
DIMS.xdim=xdim;
DIMS.ydim=ydim;
DIMS.XCENTER=fix(xdim/2);
DIMS.YCENTER=fix(ydim/2);


%set up locations for all the stimuli
allRects=setUpRectangles();

Screen('FillRect', w, black);
DrawFormattedText(w,'Press tab to begin...','center','center',COLORS.WHITE);
Screen('Flip', w);

KbWait;

load([loaddir2 'Phase2_' num2str(sub) '.mat']);
Phase2.ReplayDateTime = datestr(clock);


%get time baseline (in case we want to record timestamps
TIME_BASELINE=GetSecs; 

Phase2.OUTSIDE_REPLAY_BASELINE=TIME_BASELINE;

for trial = 1:length(Phase2.AllData.ReplayData.Opponent)
    
    
doReplayTrial(trial);

end



Screen('TextSize',w,24);
Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'Task complete.\nPlease signal the experimenter for further instructions.','center','center',COLORS.WHITE);
Screen('Flip', w);
WaitSecs(5.0);

Screen('CloseAll');

%save over old subject phase 2 data with appended results section
save([savedir 'Phase2_' num2str(Phase2.SubjectID)],'Phase2');
end

function doReplayTrial(trial)

global w DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1;

load([loaddir1 num2str(Phase2.AllData.ReplayData.Opponent(trial)) '.mat']);
  
opponentPhoto=Phase1.SubjectPhoto;
    
    Screen('TextSize',w,45);
    Screen('FillRect',w,COLORS.BLACK);
    DrawFormattedText(w,'+','center','center',COLORS.WHITE);
    Screen('Flip', w);
    WaitSecs(4);
    
    choice=Phase2.AllData.ReplayData.ReplayChoice(trial);
    
    if choice==1
        select='top';
        choicetext='Compete';
    elseif choice==3
        select='bottom';
        choicetext='Piece Rate';
    end
    
    drawPhotoAndOptions(Phase1.SubjectPhoto,select);
    Screen('Flip', w);
    WaitSecs(5);
       
    
    temptext=sprintf('Press any key to start %s run.',choicetext);
    
    %displays photo and choice for .5s
    Screen('TextSize',w,45);
    drawPhotoAndOptions(Phase1.SubjectPhoto,select);
    CenterTextOnPoint(w,temptext,DIMS.XCENTER,allRects.rate1_coords(2),COLORS.WHITE);
    Screen('Flip',w);
      
    
    while 1 %waits for any key to be pressed, was using a pause here but pause accepts any key input to continue which can cause issues
        [Down Secs Code] = KbCheck();
        if Down == 1
            break;
        end
    end
    

%now do the actual equations
doEquationTrials(trial,opponentPhoto);

%record all the timing data (unless in practice mode)
% 
%    Phase2.AllData.faceOnset(trial)= faceOnset;
%    Phase2.AllData.choicesOnset(trial)= choicesOnset;
%    Phase2.AllData.choiceRespTime(trial)= choiceResp;
%    Phase2.AllData.ratingsOnset(trial)= ratingsOnset;
%    Phase2.AllData.rateRespTime(trial)= rateResp;
%    Phase2.AllData.startEqnRespTime(trial)= startEqnResp;      



Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'+','center','center',COLORS.WHITE);
Screen('Flip',w);


end

function doEquationTrials(trial,opponentPhoto)

global w DIMS Phase2 Phase1 KEYS xkeys macbook COLORS allRects select TIME_BASELINE;

%Display The boxes for half second before displaying equations
Screen('FrameRect', w, COLORS.WHITE, allRects.eqrect);
Screen('FrameRect', w, COLORS.WHITE, allRects.falseRect_left);
Screen('FrameRect', w, COLORS.WHITE, allRects.trueRect_right);
Screen('TextSize', w, 60) %make text larger during the loop
Screen('Flip', w);
WaitSecs(.5);



%% Main While loop
equation_num = 1;
random_round = randsample(20,1); %Chooses which round from phase1 subject will be competing against

equationRunStart = GetSecs;
timeelapsed=0;
timeexpired=0;
num_answered=0;

while timeelapsed <=  10
    
    
    if Phase2.AllData.ReplayData.ReplayChoice(trial) == 1 %Decision was made to compete when subject was shown
        %Choose which round you will compete against
        %save which round competing against
        if equation_num <= size(Phase1.Equation, 1) && ~isempty(Phase1.Equation{equation_num,random_round}) %use competitor's equation
            
            %                 Phase2.True(equation_num,trial) = Phase1.True(equation_num,random_round);
            displayeqn = Phase1.Equation{equation_num,random_round};
            Phase2.AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=Phase1.True(equation_num,random_round);
        else %generate new equation
            
            %Generate the equation
            [displayeqn eqnCorrect] = generateEquation;
            Phase2.AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=eqnCorrect;
        end
        
        
    elseif Phase2.AllData.ReplayData.ReplayChoice(trial) == 3
        
        %Generate the equation
        [displayeqn eqnCorrect] = generateEquation;
        Phase2.AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=eqnCorrect;
    end
    
    %check to see if we've run out of time before continuing
    timeelapsed = GetSecs - equationRunStart;
    if timeelapsed >= 10
        timeexpired = 1;
        break;
    end
    
    %record the Equation that was displayed
    %         Phase2.Equation{equation_num,trial} = displayeqn;
    Phase2.AllData.ReplayData.EquationData.Equations{equation_num,trial}=displayeqn;
    
    %draw the stimuli
    drawPhotoAndOptions(opponentPhoto,select);
    drawEquation(displayeqn);
    eqnOnset=Screen('Flip', w);
    %         Phase2.DisplayTime(equation_num,trial) = GetSecs;
    %         WaitSecs(.5);
    
    
    while timeexpired == 0 %secondary while loop
  
        [KeyIsDown2, responseSecs, KeyCode2] = KbCheck();
        
        timeelapsed = GetSecs - equationRunStart;
        
        if KeyIsDown2 == 1 && KeyCode2(KEYS.LEFT) && timeelapsed <= 10 %selects false
            
            %highlight selection in COLORS.RED
            drawPhotoAndOptions(opponentPhoto,select);
            drawEquation(displayeqn,'false');
            Screen('Flip', w);
            WaitSecs(.05);
            %                 Phase2.Response(equation_num,trial) = 0;
            Phase2.AllData.ReplayData.EquationData.Response{equation_num,trial}=0;
            Phase2.AllData.ReplayData.EquationData.RT{equation_num,trial}=responseSecs-eqnOnset;
            num_answered=num_answered+1;

            break;
            
        elseif KeyIsDown2 == 1 && KeyCode2(KEYS.RIGHT) && timeelapsed <= 10 %selects true
            
            %highlight selection in COLORS.RED
            drawPhotoAndOptions(opponentPhoto,select);
            drawEquation(displayeqn,'true');
            Screen('Flip', w);
            WaitSecs(.05);
            %                 Phase2.Response(equation_num,trial) = 1;
            Phase2.AllData.ReplayData.EquationData.Response{equation_num,trial}=1;
            Phase2.AllData.ReplayData.EquationData.RT{equation_num,trial}=responseSecs-eqnOnset;
            num_answered=num_answered+1;
            break;
        elseif timeelapsed >=10
            
            %time is up
            timeexpired = 1;
            break;
            
        end
        
        Phase2.AllData.ReplayData.EquationData.Timestamps{equation_num,trial}=responseSecs-TIME_BASELINE;
        %             Phase2.ResponseTime(equation_num,trial) = Phase2.SolutionChoiceTime(equation_num,trial) - Phase2.DisplayTime(equation_num,trial);
        
        if timeexpired == 1
            %                 Phase2.ResponseTime(equation_num,trial) = 0;
            break;
        end

    end
    
     %redraw and pause for 1/2 second
     drawPhotoAndOptions(opponentPhoto,select);
     drawEquation(displayeqn);
     Screen('Flip', w);
     WaitSecs(0.5);
    
    %Determine if responses are correct
    if timeexpired == 0
        if (KeyCode2(KEYS.LEFT) &&  Phase2.AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}==0)  || (KeyCode2(KEYS.RIGHT) && Phase2.AllData.ReplayData.EquationData.TrueFalse{equation_num,trial} == 1)
            Phase2.AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 1; %answer is correct
        else
            Phase2.AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 0; %answer is incorrect
        end
    elseif timeexpired == 1 && num_answered>0
        Phase2.AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 0;
    end
    
    timeelapsed = GetSecs - equationRunStart;
    equation_num = equation_num+1; %add one to counter and restart main while loop
end %while loop

Phase2.AllData.ReplayData.EquationData.TotalTime{trial}=GetSecs-equationRunStart;


TextDraw('Time Expired', w, 60, 1/2, 2/3, COLORS.RED);
Screen('PutImage', w, opponentPhoto, allRects.photorect);
DrawFormattedText(w,'+','center','center',COLORS.WHITE);
Screen('Flip', w);
WaitSecs(2);


%determine how many correct answers
if num_answered==0;
    Phase2.AllData.ReplayData.Score(trial)=0; %no equations answered
else
    Phase2.AllData.ReplayData.Score(trial)=sum([Phase2.AllData.ReplayData.EquationData.Accuracy{:,trial}]);
end


if Phase2.AllData.ReplayData.ReplayChoice(trial)==1 %competition trial
    opponent_score=Phase1.Score(random_round);
    
    if Phase2.AllData.ReplayData.Score(trial) > opponent_score || (Phase2.AllData.ReplayData.Score(trial)==opponent_score && Phase2.AllData.ReplayData.EquationData.TotalTime{trial}< Phase1.TotalResponseTime(random_round))
        
        Phase2.AllData.ReplayData.WinLose(trial)=1;
    else
        Phase2.AllData.ReplayData.WinLose(trial)=0;
    end
end

end



