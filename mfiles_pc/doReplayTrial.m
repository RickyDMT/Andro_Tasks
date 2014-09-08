function doReplayTrial(trial,position)

global w w2 DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1 AllData;

choice=AllData.ReplayData.ReplayChoice(trial);

if choice==1
    select='top';
    choicetext='Compete';
elseif choice==3
    select='bottom';
    choicetext='Piece Rate';
end

% if position==0
%     
%     switch AllData.ReplayData.TrialType(trial)
%         
%         %Choice
%         case {1}
%             choice_left = 'Compete';
%             choice_right = 'Piece Rate';
%             color_left = COLORS.WHITE;
%             color_right = COLORS.WHITE;
%             select='none';
%         case {2}
%             %mandatory compete
%             choice_left = 'Compete';
%             choice_right = 'Invalid Key';
%             color_left = COLORS.GREEN;
%             color_right = COLORS.WHITE;
%             select='top';
%         case {3}
%             %mandatory piece rate
%             choice_left = 'Piece Rate';
%             choice_right = 'Invalid Key';
%             color_left = COLORS.WHITE;
%             color_right = COLORS.GREEN;
%             select='bottom';
%             
%     end
% elseif position==1
%     
%     switch AllData.ReplayData.TrialType(trial)
%         case {1}
%             %choice
%             choice_left = 'Piece Rate';
%             choice_right = 'Compete';
%             color_left = COLORS.WHITE;
%             color_right = COLORS.WHITE;
%             select='none';
%             
%         case {2}
%             %mandatory compete
%             choice_left = 'Invalid Key';
%             choice_right = 'Compete';
%             color_right = COLORS.WHITE;
%             color_left = COLORS.GREEN;
%             select='top';
%             
%         case {3}
%             %mandatory piece rate
%             choice_left = 'Invalid Key';
%             choice_right = 'Piece Rate';
%             color_left = COLORS.WHITE;
%             color_right = COLORS.GREEN;
%             select='bottom';
%             
%     end
% end

current_opponent=AllData.ReplayData.Opponent(trial);

%load opponent's data
% load([loaddir1 num2str(current_opponent) '.mat']);


DrawFormattedText(w,'+','center','center',COLORS.WHITE);
Screen('Flip',w);
%BIOPAC: Pulse Ch1 for "+"
outp(1);

if AllData.ReplayData.Observe(trial)==1  && w~=w2
    DrawFormattedText(w2,'+','center','center',COLORS.WHITE);
    Screen('Flip',w2);
elseif AllData.ReplayData.Observe(trial)==0  && w~=w2
    DrawFormattedText(w2,'This is a private trial.','center','center',COLORS.WHITE);
    Screen('Flip', w2);
end

WaitSecs(2.0);


opponentPhoto=AllData.ReplayData.OpponentPhoto{trial};

%draw photo and options
drawPhotoAndOptions(opponentPhoto,select,w);
%drawStatus(trial,'replay',w);
% drawObserve(trial);
faceOnset=Screen('Flip', w);
%Biopac: Pulse Ch2 for face
outp(2);

faceOnset=faceOnset-TIME_BASELINE;


if AllData.ReplayData.Observe(trial)==1  && w~=w2
    drawPhotoAndOptions(opponentPhoto,select,w2);
    %drawStatus(trial,'replay',w2);
    % drawObserve(trial);
    faceOnset=Screen('Flip', w2);
end

% We will change this to make the overall script faster
% 33% of trials wait 12 seconds instead of 4
if AllData.ReplayData.LongWait(trial) == 1
    WaitSecs(3);
else
    WaitSecs(3);
end


%%% This is where we should sequentially present the status and observe
%%% information

% drawPhotoAndOptions(opponentPhoto,select);
% drawStatus(trial);
% % drawObserve(trial);
% faceOnset=Screen('Flip', w);
% 
% WaitSecs(2)


drawPhotoAndOptions(opponentPhoto,select,w);
%drawStatus(trial,'replay',w);
drawObserve(trial,'replay',w);
Screen('Flip', w);
%Biopac: Pulse Ch4 for public, Ch5 for private
if AllData.ReplayData.Observe(trial)==1
    outp(4);
elseif AllData.ReplayData.Observe(trial)==0
    outp(5);
end

if AllData.ReplayData.Observe(trial)==1  && w~=w2
    drawPhotoAndOptions(opponentPhoto,select,w2);
    %drawStatus(trial,'replay',w2);
    drawObserve(trial,'replay',w2);
    Screen('Flip', w2);
end;

WaitSecs(3)

% %display options so they can make response
% Screen('TextSize', w,45);
% drawPhotoAndOptions(opponentPhoto,select);
% drawChoices(trial,choice_left,choice_right);
% drawStatus(trial);
% drawObserve(trial);
% choicesOnset=Screen('Flip', w);
% 
% choicesOnset=choicesOnset-TIME_BASELINE;
% 
% %change font size back
% Screen('TextSize',w,45);
% 
% %wait for response
% 
% startsecs=GetSecs;
% 
% while 1
%     [keyisdown, responseSecs, keycode] = KbCheck(xkeys);
%     %         [ pressed, firstPress]=KbQueueCheck(xkeys);
%     disp('trial')
%     trial
%     AllData.ReplayData.TrialType(trial)
%     position
%     
%     switch AllData.ReplayData.TrialType(trial)
%         case {1},
%             
%             if (keyisdown) && (keycode(KEYS.LEFT) || keycode(KEYS.RIGHT))
%                 choiceResp=responseSecs - TIME_BASELINE;
%                 rt=responseSecs-startsecs;
%                 break;
%             end
%             
%         otherwise,
%       
%             switch position
%                 case {0},
%                     if (keyisdown) && (keycode(KEYS.LEFT))
%                         choiceResp=responseSecs - TIME_BASELINE;
%                         rt=responseSecs-startsecs;
%                         break;
%                     end
%                     
%                 case {1},
%                     if (keyisdown) && (keycode(KEYS.RIGHT))
%                         choiceResp=responseSecs - TIME_BASELINE;
%                         rt=responseSecs-startsecs;
%                         break;
%                     end
%             end  
%     end
%     
%     
%     
%     
% %     if position==1 && AllData.ReplayData.TrialType(trial)==2
% %         
% %         if (keyisdown) && (keycode(KEYS.LEFT))
% %             choiceResp=responseSecs - TIME_BASELINE;
% %             rt=responseSecs-startsecs;
% %             break;
% %         end
% %         
% %     end
% %     
% %     if position==1 && AllData.ReplayData.TrialType(trial)==3
% %         
% %         if (keyisdown) && (keycode(KEYS.LEFT))
% %             choiceResp=responseSecs - TIME_BASELINE;
% %             rt=responseSecs-startsecs;
% %             break;
% %         end
% %         
% %     end
% %     
% %     if position==2 && AllData.ReplayData.TrialType(trial)==2
% %         
% %         if (keyisdown) && (keycode(KEYS.RIGHT))
% %             choiceResp=responseSecs - TIME_BASELINE;
% %             rt=responseSecs-startsecs;
% %             break;
% %         end
% %         
% %     end
% %     
% %      if position==2 && AllData.ReplayData.TrialType(trial)==3
% %         
% %         if (keyisdown) && (keycode(KEYS.RIGHT))
% %             choiceResp=responseSecs - TIME_BASELINE;
% %             rt=responseSecs-startsecs;
% %             break;
% %         end
% %         
% %      end
% %        
% %      if AllData.ReplayData.TrialType(trial)==1
% %          
% %          if (keyisdown) && (keycode(KEYS.LEFT) || keycode(KEYS.RIGHT))
% %              choiceResp=responseSecs - TIME_BASELINE;
% %              rt=responseSecs-startsecs;
% %              break;
% %          end
% %      end
%     
%     
% end
% 
% AllData.ReplayData.Choice_RT(trial)=rt;
% 
% 
% %initialize to blank string, to keep things from crashing, just in
% %case...
% choice='';
% 
% 
% 
% %on choice trials, highlight the choice
% if AllData.ReplayData.TrialType(trial)==1
%     if position==0 && keycode(KEYS.LEFT)
%         color_left=COLORS.GREEN;
%         choice=choice_left;
%     elseif position==0 && keycode(KEYS.RIGHT)
%         color_right=COLORS.GREEN;
%         choice=choice_right;
%     elseif position==1 && keycode(KEYS.LEFT)
%         color_right=COLORS.GREEN;
%         choice=choice_left;
%     elseif position==1 && keycode(KEYS.RIGHT)
%         color_left=COLORS.GREEN;
%         choice=choice_right;
%     end
%     
% else
%     if position==0
%         choice=choice_left;
%     elseif position==1
%         choice=choice_right;
%     end
%     
% end

%record their choice
if strcmp(choice,'Compete')
%     AllData.ReplayData.ReplayChoice(trial)=1 %This means they chose compete;
    select='top';
elseif strcmp(choice,'Piece Rate') %This means they chose piece rate;
%     AllData.ReplayData.ReplayChoice(trial)=3;
    select='bottom';
% else
%     AllData.ReplayData.ReplayChoice(trial)=3;
end
% 
% 
% 
% %response feedback (highlights in COLORS.GREEN for .25s)
% drawPhotoAndOptions(opponentPhoto,select);
% drawChoices(trial,choice_left,choice_right,keycode);
% drawStatus(trial);
% drawObserve(trial);
% choiceFeedback=Screen('Flip',w);
% WaitSecs(.25);
% 
% % choiceFeedback=choiceFeedback-TIME_BASELINE;
% 
% 
% %Blank screen for half second after decision
% drawPhotoAndOptions(opponentPhoto,select);
% drawStatus(trial);
% drawObserve(trial);
% Screen('Flip', w);
% WaitSecs(0.5);
% 
% 
% %ask for rating of satisfaction
% Screen('TextSize',w,45);
% CenterTextOnPoint(w,'How satisfied are you?',allRects.option1_coords(1),fix(DIMS.ydim/2+170),COLORS.WHITE);
% drawPhotoAndOptions(opponentPhoto,select);
% drawRatings();
% drawStatus(trial);
% drawObserve(trial);
% ratingsOnset=Screen('Flip', w);
% 
% ratingsOnset=ratingsOnset-TIME_BASELINE;
% 
% %wait for response, display visual feedback for .25s
% 
% startsecs=GetSecs;
% 
% while 1
%     [keyisdown, rateResponseSecs, keycode] = KbCheck(xkeys);
%     
%     if (keyisdown==1 && (keycode(KEYS.ONE) || keycode(KEYS.TWO) || keycode(KEYS.THREE) || keycode(KEYS.FOUR)))
%        
%         drawPhotoAndOptions(opponentPhoto,select);
%         Screen('TextSize',w,45);
%         CenterTextOnPoint(w,'How satisfied are you?',allRects.option1_coords(1),fix(DIMS.ydim/2+170),COLORS.WHITE);
%         drawRatings(keycode);
%         drawStatus(trial);
%         drawObserve(trial);
%         Screen('Flip',w);
%         WaitSecs(.25);
%         rateResp= rateResponseSecs-TIME_BASELINE;
%         rt=rateResponseSecs-startsecs;
%         break;
%     end
% end
% 
% AllData.ReplayData.Rating_RT(trial)=rt;
% 
% 
% response=find(keycode);
% 
% if length(find(keycode))>1
%     
%     response=keycode(1);
%     
% elseif isempty(find(keycode))
%     response=-999;
% end
% 
% rating=-999;
% 
% switch response
%     case {KEYS.ONE}
%         rating=1;
%     case {KEYS.TWO}
%         rating=2;
%     case {KEYS.THREE}
%         rating=3;
%     case {KEYS.FOUR}
%         rating=4;
% end
% 
% 
% %record rating
% AllData.ReplayData.Rating(trial)=rating;



temptext=sprintf('Press any key to start %s run.',choicetext);

%displays photo and choice for .5s
Screen('TextSize',w,45);
drawPhotoAndOptions(opponentPhoto,select,w);
CenterTextOnPoint(w,temptext,DIMS.XCENTER,allRects.rate1_coords(2),COLORS.WHITE);
%drawStatus(trial,'replay',w);
drawObserve(trial,'replay',w);
Screen('Flip',w);

if AllData.ReplayData.Observe(trial)==1  && w~=w2
    Screen('TextSize',w2,45);
    drawPhotoAndOptions(opponentPhoto,select,w2);
    CenterTextOnPoint(w2,temptext,DIMS.XCENTER,allRects.rate1_coords(2),COLORS.WHITE);
    %drawStatus(trial,'replay',w2);
    drawObserve(trial,'replay',w2);
    Screen('Flip',w2);
end


KbReleaseWait;

startsecs=GetSecs;

%wait for response
while 1
    [keyisdown, responseSecs, keycode] = KbCheck();
    %         [ pressed, firstPress]=KbQueueCheck(xkeys);
    
    if (keyisdown && ~keycode(52))
        startEqnResp= responseSecs-TIME_BASELINE;
        rt=responseSecs-startsecs;
        %Biopac: Pulse Ch32 at start of Math. Reset to 0 buried in
        %doEquationTrials
        outp(32);
        
        break;
    end
end

AllData.ReplayData.Start_Equation_RT(trial)=rt;


%now do the actual equations
doEquationTrials(trial,opponentPhoto);

%record all the timing data (unless in practice mode)
% if practice==0
%    AllData.ReplayData.faceOnset(trial)= faceOnset
%    AllData.ReplayData.choicesOnset(trial)= choicesOnset
%    AllData.ReplayData.choiceRespTime(trial)= choiceResp
%    AllData.ReplayData.ratingsOnset(trial)= ratingsOnset
%    AllData.ReplayData.rateRespTime(trial)= rateResp
%    AllData.ReplayData.startEqnRespTime(trial)= startEqnResp      
% % end


Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'+','center','center',COLORS.WHITE);
Screen('Flip',w);
%Biopac: Pulse Ch1 for "+"
outp(1);

Screen('FillRect',w2,COLORS.BLACK);
DrawFormattedText(w2,'+','center','center',COLORS.WHITE);
Screen('Flip',w2);

% 33% of trials wait 12 seconds instead of 4
if AllData.ReplayData.LongWait(trial) == 1
    WaitSecs(3);
else
    WaitSecs(3);
end

%Biopac: Reset to 0.
outp(0);

end

function doEquationTrials(trial,opponentPhoto)
global w w2 DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1 AllData; 

%Display The boxes for half second before displaying equations
Screen('FrameRect', w, COLORS.WHITE, allRects.eqrect);
Screen('FrameRect', w, COLORS.WHITE, allRects.falseRect_left);
Screen('FrameRect', w, COLORS.WHITE, allRects.trueRect_right);
Screen('TextSize', w, 60) %make text larger during the loop
%drawStatus(trial,'replay',w);
drawObserve(trial,'replay',w);
Screen('Flip', w);

if AllData.ReplayData.Observe(trial)==1  && w~=w2
    Screen('FrameRect', w2, COLORS.WHITE, allRects.eqrect);
    Screen('FrameRect', w2, COLORS.WHITE, allRects.falseRect_left);
    Screen('FrameRect', w2, COLORS.WHITE, allRects.trueRect_right);
    Screen('TextSize', w2, 60) %make text larger during the loop
    %drawStatus(trial,'replay',w2);
    drawObserve(trial,'replay',w2);
    Screen('Flip', w2); 
end

WaitSecs(.5);



%% Main While loop
equation_num = 1;
% random_round = randsample(16,1)+4; %Chooses which round from phase1 subject will be competing against, excluding first 4 practice trials.

equationRunStart = GetSecs;
timeelapsed=0;
timeexpired=0;
num_answered=0;

while timeelapsed <=  10
    
    
    if AllData.ReplayData.ReplayChoice(trial) == 1 %Decision was made to compete when subject was shown
        %Choose which round you will compete against
        %save which round competing against
        current_equations=AllData.ReplayData.OpponentEquation{trial};
        current_true=AllData.ReplayData.OpponentEquationTrue{trial};
        if equation_num <= size(current_equations, 1) && ~isempty(current_equations{equation_num}) %use competitor's equation
%             
%             %                 Phase2.True(equation_num,trial) = Phase1.True(equation_num,random_round);
            displayeqn = current_equations{equation_num};
            AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=current_true(equation_num);
        else %generate new equation
            
            %Generate the equation
            [displayeqn eqnCorrect] = generateEquation;
            AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=eqnCorrect;
        end
%         
        
    elseif AllData.ReplayData.ReplayChoice(trial) == 2 || AllData.ReplayData.ReplayChoice(trial) == 3
        
        %Generate the equation
        [displayeqn eqnCorrect] = generateEquation;
        AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}=eqnCorrect;
    end
%     

    %check to see if we've run out of time before continuing
    timeelapsed = GetSecs - equationRunStart;
    if timeelapsed >= 10
        timeexpired = 1;
        break;
    end
    
    %record the Equation that was displayed
    %         Phase2.Equation{equation_num,trial} = displayeqn;
    AllData.ReplayData.EquationData.Equations{equation_num,trial}=displayeqn;
    
     %draw the stimuli
    drawPhotoAndOptions(opponentPhoto,select,w);
    drawEquation(displayeqn,[],w);
    %drawStatus(trial,'replay',w);
    drawObserve(trial,'replay',w);
    eqnOnset=Screen('Flip', w);
   
    if AllData.ReplayData.Observe(trial)==1  && w~=w2
        drawPhotoAndOptions(opponentPhoto,select,w2);
        drawEquation(displayeqn,[],w2);
        %drawStatus(trial,'replay',w2);
        drawObserve(trial,'replay',w2);
        eqnOnset=Screen('Flip', w2);
    end
    %         Phase2.DisplayTime(equation_num,trial) = GetSecs;
    %         WaitSecs(.5);
    
    
    while timeexpired == 0 %secondary while loop
  
        [KeyIsDown2, responseSecs, KeyCode2] = KbCheck();
        
        timeelapsed = GetSecs - equationRunStart;
        
        if KeyIsDown2 == 1 && KeyCode2(KEYS.LEFT) && timeelapsed <= 10 %selects false
            
           
            %highlight selection in COLORS.RED
            drawPhotoAndOptions(opponentPhoto,select,w);
            drawEquation(displayeqn,'false',w);
            %drawStatus(trial,'replay',w);
            drawObserve(trial,'replay',w);
            Screen('Flip', w);
            
            
            if AllData.ReplayData.Observe(trial)==1  && w~=w2
                drawPhotoAndOptions(opponentPhoto,select,w2);
                drawEquation(displayeqn,'false',w2);
                %drawStatus(trial,'replay',w2);
                drawObserve(trial,'replay',w2);
                Screen('Flip', w2);
               
            end
            
            WaitSecs(.05);
            %                 Phase2.Response(equation_num,trial) = 0;
            AllData.ReplayData.EquationData.Response{equation_num,trial}=0;
            AllData.ReplayData.EquationData.RT{equation_num,trial}=responseSecs-eqnOnset;
            num_answered=num_answered+1;

            break;
            
        elseif KeyIsDown2 == 1 && KeyCode2(KEYS.RIGHT) && timeelapsed <= 10 %selects true
            
              %highlight selection in COLORS.RED
            drawPhotoAndOptions(opponentPhoto,select,w);
            drawEquation(displayeqn,'true',w);
            %drawStatus(trial,'replay',w);
            drawObserve(trial,'replay',w);
            Screen('Flip', w);
            
            
            if AllData.ReplayData.Observe(trial)==1  && w~=w2
                drawPhotoAndOptions(opponentPhoto,select,w2);
                drawEquation(displayeqn,'true',w2);
                %drawStatus(trial,'replay',w2);
                drawObserve(trial,'replay',w2);
                Screen('Flip', w2);
                
            end
            
            WaitSecs(.05);
            %                 Phase2.Response(equation_num,trial) = 1;
            AllData.ReplayData.EquationData.Response{equation_num,trial}=1;
            AllData.ReplayData.EquationData.RT{equation_num,trial}=responseSecs-eqnOnset;
            num_answered=num_answered+1;
            break;
        elseif timeelapsed >=10
            
            %time is up
            timeexpired = 1;
            break;
            
        end
        
        AllData.ReplayData.EquationData.Timestamps{equation_num,trial}=responseSecs-TIME_BASELINE;
        %             Phase2.ResponseTime(equation_num,trial) = Phase2.SolutionChoiceTime(equation_num,trial) - Phase2.DisplayTime(equation_num,trial);
        
        if timeexpired == 1
            %                 Phase2.ResponseTime(equation_num,trial) = 0;
            break;
        end

    end
    
       %redraw and pause for 1/2 second
     drawPhotoAndOptions(opponentPhoto,select,w);
     drawEquation(displayeqn,[],w);
     %drawStatus(trial,'replay',w);
     drawObserve(trial,'replay',w);
     Screen('Flip', w);
     
     if AllData.ReplayData.Observe(trial)==1  && w~=w2
         drawPhotoAndOptions(opponentPhoto,select,w2);
         drawEquation(displayeqn,[],w2);
         %drawStatus(trial,'replay',w2);
         drawObserve(trial,'replay',w2);
         Screen('Flip', w2);
     end
     
     WaitSecs(0.5);
    
    %Determine if responses are correct
    if timeexpired == 0
        if (KeyCode2(KEYS.LEFT) &&  AllData.ReplayData.EquationData.TrueFalse{equation_num,trial}==0)  || (KeyCode2(KEYS.RIGHT) && AllData.ReplayData.EquationData.TrueFalse{equation_num,trial} == 1)
            AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 1; %answer is correct
        else
%             AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 0; %answer is incorrect
              AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = -1; %answer is incorrect - Jason updated on 4/4/13
        end
    elseif timeexpired == 1 && num_answered>0
        AllData.ReplayData.EquationData.Accuracy{equation_num,trial} = 0;
    end
    
    timeelapsed = GetSecs - equationRunStart;
    equation_num = equation_num+1; %add one to counter and restart main while loop
end %while loop

AllData.ReplayData.EquationData.TotalTime{trial}=GetSecs-equationRunStart;


% TextDraw('Time Expired', w, 60, 1/2, 2/3, COLORS.RED);
DrawFormattedText(w,'Time Expired','center',DIMS.YCENTER+150,COLORS.RED);
Screen('PutImage', w, opponentPhoto, allRects.photorect);
% DrawFormattedText(w,'+','center','center',COLORS.WHITE);
%drawStatus(trial,'replay',w);
drawObserve(trial,'replay',w);
Screen('Flip', w);
%Biopac: Reset to 0 at end of math
outp(0);

if AllData.ReplayData.Observe(trial)==1  && w~=w2
    DrawFormattedText(w2,'Time Expired','center',DIMS.YCENTER+150,COLORS.RED);
    Screen('PutImage', w2, opponentPhoto, allRects.photorect);
    % DrawFormattedText(w,'+','center','center',COLORS.WHITE);
    %drawStatus(trial,'replay',w2);
    drawObserve(trial,'replay',w2);
    Screen('Flip', w2);
end


%determine how many correct answers
if num_answered==0;
    AllData.ReplayData.Score(trial)=0; %no equations answered
else
    AllData.ReplayData.Score(trial)=sum([AllData.ReplayData.EquationData.Accuracy{:,trial}]);
end


if AllData.ReplayData.ReplayChoice(trial)==1 %competition trial
    opponent_score=AllData.ReplayData.OpponentScore(trial);
    
    if AllData.ReplayData.Score(trial) > opponent_score || (AllData.ReplayData.Score(trial)==opponent_score && AllData.ReplayData.EquationData.TotalTime{trial}< AllData.ReplayData.OpponentTotalRT(trial))
        
        AllData.ReplayData.Replay_WinLose(trial)=1;
    else
        AllData.ReplayData.Replay_WinLose(trial)=0;
    end
end

end

%%% THESE FUNCTIONS ARE NOW THEIR OWN MFILES

% function drawStatus(trial)
% 
% global w DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1;
% 
% old_font_size=Screen('TextSize',w,45);
% 
% [path,~,~]=fileparts(which(mfilename));
% 
% one_star = imread([path filesep 'images' filesep '1_star.png']);
% [path filesep 'images' filesep '1_star.png']
% two_star = imread([path filesep 'images' filesep '2_star.png']);
% [path filesep 'images' filesep 'closed_eye_black.png']
% one_star_texture = Screen('MakeTexture',w,one_star);
% two_star_texture = Screen('MakeTexture',w,two_star);
% % eyeTexture = [openTexture closedTexture];
% % observesize=[268 182];
% status_size=[160 80];
% tempStatusRect=[0 0 status_size(1) status_size(2)];
% % observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
% statusRect=CenterRectOnPoint(tempStatusRect,allRects.status_coords(1),allRects.status_coords(2));
% [imgH, imgW, ~] = size(one_star);
% 
% if AllData.ReplayData.Higher(trial)==1
%     
%     Screen('DrawTexture',w,two_star_texture,[],statusRect); 
%     
% elseif AllData.ReplayData.Higher(trial)==0
%     
%     Screen('DrawTexture',w,one_star_texture,[],statusRect); 
%     
% end
% 
% % if AllData.ReplayData.Higher(trial)==1
% %     
% %     CenterTextOnPoint(w,'**',allRects.status_coords(1),allRects.status_coords(2),COLORS.YELLOW);
% %     
% % elseif AllData.ReplayData.Higher(trial)==0
% %     
% %     CenterTextOnPoint(w,'*',allRects.status_coords(1),allRects.status_coords(2),COLORS.YELLOW);
% %     
% % end
% 
% Screen('TextSize',w,old_font_size);
% 
% end
% 
% function drawObserve(trial)
% 
% global w DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1;
% 
% %% This is to preload the images for the observe stimuli
% 
% [path,~,~]=fileparts(which(mfilename));
% 
% open_eye = imread([path filesep 'images' filesep 'open_eyes_black.png']);
% [path filesep 'images' filesep 'open_eye_black.png']
% closed_eye = imread([path filesep 'images' filesep 'closed_eyes_black.png']);
% [path filesep 'images' filesep 'closed_eye_black.png']
% openTexture = Screen('MakeTexture',w,open_eye);
% closedTexture = Screen('MakeTexture',w,closed_eye);
% % eyeTexture = [openTexture closedTexture];
% % observesize=[268 182];
% observesize=[415 106];
% tempObserveRect=[0 0 observesize(1) observesize(2)];
% % observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
% observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
% [imgH, imgW, ~] = size(open_eye);
% 
% if AllData.ReplayData.Observe(trial)==1
%     
%     Screen('DrawTexture',w,openTexture,[],observeRect); 
%     
% elseif AllData.ReplayData.Observe(trial)==0
%     
%     Screen('DrawTexture',w,closedTexture,[],observeRect); 
%     
% end
% 
% end


