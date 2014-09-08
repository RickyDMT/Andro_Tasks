function drawEquation(displayeqn,varargin)

global w w2 allRects COLORS DIMS;

leftcolor=COLORS.WHITE;
rightcolor=COLORS.WHITE;

if ~isempty(varargin{1}) && nargin >= 2
   choice=varargin{1};
   
   if strcmp(choice,'false');
       leftcolor=COLORS.RED;
   elseif strcmp(choice,'true');
       rightcolor=COLORS.RED;
   end
    
end

if nargin >= 3
    
    window=varargin{2};
    
else
    
    window=w;
    
end

oldTextSize=Screen('TextSize',window,45);
CenterTextOnPoint(window,'FALSE',allRects.resprectleft_coords(1),allRects.resprectleft_coords(2),leftcolor);
CenterTextOnPoint(window,'TRUE',allRects.resprectright_coords(1),allRects.resprectright_coords(2),rightcolor);
CenterTextOnPoint(window,displayeqn,allRects.eq_coords(1),allRects.eq_coords(2),COLORS.WHITE);
Screen('FrameRect', window, COLORS.WHITE, allRects.eqrect);
Screen('FrameRect', window, leftcolor, allRects.falseRect_left);
Screen('FrameRect', window, rightcolor, allRects.trueRect_right);

Screen('TextSize',window,oldTextSize);

% oldTextSize=Screen('TextSize',w2,60);
% CenterTextOnPoint(w2,'FALSE',allRects.resprectleft_coords(1),allRects.resprectleft_coords(2),leftcolor);
% CenterTextOnPoint(w2,'TRUE',allRects.resprectright_coords(1),allRects.resprectright_coords(2),rightcolor);
% CenterTextOnPoint(w2,displayeqn,allRects.eq_coords(1),allRects.eq_coords(2),COLORS.WHITE);
% Screen('FrameRect', w2, COLORS.WHITE, allRects.eqrect);
% Screen('FrameRect', w2, leftcolor, allRects.falseRect_left);
% Screen('FrameRect', w2, rightcolor, allRects.trueRect_right);
% 
% Screen('TextSize',w2,oldTextSize);


end