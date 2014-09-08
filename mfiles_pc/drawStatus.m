function drawStatus(trial,varargin)

global w w2 DIMS COLORS allRects loaddir1 TIME_BASELINE xkeys select macbook KEYS Phase2 Phase1 AllData;



[path,~,~]=fileparts(which(mfilename));

one_star = imread([path filesep 'images' filesep '1_star.png']);
[path filesep 'images' filesep '1_star.png'];
two_star = imread([path filesep 'images' filesep '2_star.png']);
[path filesep 'images' filesep 'closed_eye_black.png'];

% one_star_texture2 = Screen('MakeTexture',w2,one_star);
% two_star_texture2 = Screen('MakeTexture',w2,two_star);
% eyeTexture = [openTexture closedTexture];
% observesize=[268 182];
status_size=[160 80];
tempStatusRect=[0 0 status_size(1) status_size(2)];
% observeRect=CenterRectOnPoint(tempObserveRect,allRects.observe_coords(1),allRects.observe_coords(2));
statusRect=CenterRectOnPoint(tempStatusRect,allRects.status_coords(1),allRects.status_coords(2));
[imgH, imgW, ~] = size(one_star);

replay_trial=0; %by default, NOT an replay trial

if ~isempty(varargin{1}) && nargin >=2 %if we were given an optional argument
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

old_font_size=Screen('TextSize',window,45);
one_star_texture = Screen('MakeTexture',window,one_star);
two_star_texture = Screen('MakeTexture',window,two_star);


if replay_trial==0;
    
    if AllData.Higher(trial)==1
        
        Screen('DrawTexture',window,two_star_texture,[],statusRect);
        
%         Screen('DrawTexture',w2,two_star_texture,[],statusRect);
        
    elseif AllData.Higher(trial)==0
        
        Screen('DrawTexture',window,one_star_texture,[],statusRect);
        
%         Screen('DrawTexture',w2,one_star_texture,[],statusRect);
        
    end
    
end

if replay_trial==1;
    
    if AllData.ReplayData.Higher(trial)==1
        
        Screen('DrawTexture',window,two_star_texture,[],statusRect);
        
%         Screen('DrawTexture',w2,two_star_texture,[],statusRect);
        
    elseif AllData.ReplayData.Higher(trial)==0
        
        Screen('DrawTexture',window,one_star_texture,[],statusRect);
        
%         Screen('DrawTexture',w2,one_star_texture,[],statusRect);
        
    end
    
end

% if AllData.Higher(trial)==1
%     
%     CenterTextOnPoint(w,'**',allRects.status_coords(1),allRects.status_coords(2),COLORS.YELLOW);
%     
% elseif AllData.Higher(trial)==0
%     
%     CenterTextOnPoint(w,'*',allRects.status_coords(1),allRects.status_coords(2),COLORS.YELLOW);
%     
% end
% 
% Screen('TextSize',w,old_font_size);

end