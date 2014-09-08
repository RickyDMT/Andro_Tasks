function drawChoices(trial,choice1,choice2,varargin)

global w w2 allRects Phase2 KEYS COLORS;




% Screen('TextFont', w2, 'Arial');
% Screen('TextStyle', w2, 1);
% oldTextSize=Screen('TextSize',w2,60);


colorLeft=COLORS.WHITE;
colorRight=COLORS.WHITE;

if ~isempty(varargin{1}) && nargin >=4
    response=varargin{1};
    if response(KEYS.LEFT)
        colorLeft=COLORS.GREEN;
    elseif response(KEYS.RIGHT)
        colorRight=COLORS.GREEN;
    end
end

if nargin >= 5
    
    window=varargin{2};
    
else
    
    window=w;
    
end

Screen('TextFont', window, 'Arial');
Screen('TextStyle', window, 1);
oldTextSize=Screen('TextSize',window,45);


Screen('FrameRect', window, colorLeft, allRects.leftchoicerect,1);
Screen('FrameRect', window, colorRight, allRects.rightchoicerect,1);

CenterTextOnPoint(window,choice1,allRects.leftchoice_coords(1),allRects.leftchoice_coords(2),colorLeft);
CenterTextOnPoint(window,choice2,allRects.rightchoice_coords(1),allRects.rightchoice_coords(2),colorRight);

Screen('TextSize',window,oldTextSize);

% Screen('FrameRect', w2, colorLeft, allRects.leftchoicerect,1);
% Screen('FrameRect', w2, colorRight, allRects.rightchoicerect,1);
% 
% CenterTextOnPoint(w2,choice1,allRects.leftchoice_coords(1),allRects.leftchoice_coords(2),colorLeft);
% CenterTextOnPoint(w2,choice2,allRects.rightchoice_coords(1),allRects.rightchoice_coords(2),colorRight);
% 
% Screen('TextSize',w2,oldTextSize);

end