function drawObserve(trial,varargin)

global w w2 DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1 AllData;

%% This is to preload the images for the observe stimuli

[path,~,~]=fileparts(which(mfilename));

open_eye = imread([path filesep 'images' filesep 'open_eyes_black.png']);
[path filesep 'images' filesep 'open_eye_black.png'];
closed_eye = imread([path filesep 'images' filesep 'closed_eyes_black.png']);
[path filesep 'images' filesep 'closed_eye_black.png'];
% openTexture = Screen('MakeTexture',w,open_eye);
% closedTexture = Screen('MakeTexture',w,closed_eye);
% openTexture = Screen('MakeTexture',w2,open_eye);
% closedTexture = Screen('MakeTexture',w2,closed_eye);
% eyeTexture = [openTexture closedTexture];
% observesize=[268 182];
observesize=[415 106];
tempObserveRect=[0 0 observesize(1) observesize(2)];
% observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
[imgH, imgW, ~] = size(open_eye);

replay_trial=0; %by default, NOT an replay trial

if ~isempty(varargin{1}) && nargin >=2%if we were given an optional argument
     replay_arg=varargin{1}; %this should be a string, 'replay'
     
     if strcmp(replay_arg,'replay') 
         replay_trial=1;
     end
end

if nargin >= 3
    
    window=varargin{2};
    
else
    
    window=w;
    
end

openTexture = Screen('MakeTexture',window,open_eye);
closedTexture = Screen('MakeTexture',window,closed_eye);



if replay_trial==0;
    
    if AllData.Observe(trial)==1
        
        Screen('DrawTexture',window,openTexture,[],observeRect);
        
        CenterTextOnPoint(window,'PUBLIC',allRects.observe_coords(1),allRects.observe_coords(2)+65,COLORS.WHITE);
%         
%          Screen('DrawTexture',w2,openTexture,[],observeRect);
%         
%         CenterTextOnPoint(w2,'PUBLIC',allRects.observe_coords(1),allRects.observe_coords(2)+65,COLORS.WHITE);
        
    elseif AllData.Observe(trial)==0
        
        Screen('DrawTexture',window,closedTexture,[],observeRect);
        
        CenterTextOnPoint(window,'PRIVATE',allRects.observe_coords(1),allRects.observe_coords(2)+65,COLORS.WHITE);
        
    end
    
end

if replay_trial==1;
    
    if AllData.ReplayData.Observe(trial)==1
        
        Screen('DrawTexture',window,openTexture,[],observeRect);
        
        CenterTextOnPoint(window,'PUBLIC',allRects.observe_coords(1),allRects.observe_coords(2)+65,COLORS.WHITE);
        
    elseif AllData.ReplayData.Observe(trial)==0
        
        Screen('DrawTexture',window,closedTexture,[],observeRect);
        
        CenterTextOnPoint(window,'PRIVATE',allRects.observe_coords(1),allRects.observe_coords(2)+65,COLORS.WHITE);
        
    end
    
end
    
end