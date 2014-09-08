function drawRatings(varargin)

global w w2 allRects Phase2 KEYS COLORS;




colors=repmat(COLORS.WHITE',1,4);
rects=horzcat(allRects.rate1rect',allRects.rate2rect',allRects.rate3rect',allRects.rate4rect');


if nargin >= 1 && ~isempty(varargin{1})
    response=varargin{1};
    
    key=find(response);
    if length(key)>1
        key=key(1);
    end;
    
    switch key
        
        case {KEYS.ONE}
            choice=1;
        case {KEYS.TWO}
            choice=2;
        case {KEYS.THREE}
            choice=3;
        case {KEYS.FOUR}
            choice=4;
    end
    
    if exist('choice','var')
        
        
        colors(:,choice)=COLORS.GREEN';
        
    end
end

if nargin>=2
    
    window=varargin{2};
    
else
    
    window=w;
    
end
   

Screen('TextFont', window, 'Arial');
Screen('TextStyle', window, 1)
oldSize = Screen('TextSize',window,45);

% Screen('TextFont', w2, 'Arial');
% Screen('TextStyle', w2, 1)
% Screen('TextSize',w2,60);



%draw all the squares
Screen('FrameRect',window,colors,rects,1);


% Screen('FrameRect',w2,colors,rects,1);


%draw the text (1-4)
CenterTextOnPoint(window,'1',allRects.rate1_coords(1),allRects.rate1_coords(2),colors(:,1));
CenterTextOnPoint(window,'2',allRects.rate2_coords(1),allRects.rate2_coords(2),colors(:,2));
CenterTextOnPoint(window,'3',allRects.rate3_coords(1),allRects.rate3_coords(2),colors(:,3));
CenterTextOnPoint(window,'4',allRects.rate4_coords(1),allRects.rate4_coords(2),colors(:,4));

% CenterTextOnPoint(w2,'1',allRects.rate1_coords(1),allRects.rate1_coords(2),colors(:,1));
% CenterTextOnPoint(w2,'2',allRects.rate2_coords(1),allRects.rate2_coords(2),colors(:,2));
% CenterTextOnPoint(w2,'3',allRects.rate3_coords(1),allRects.rate3_coords(2),colors(:,3));
% CenterTextOnPoint(w2,'4',allRects.rate4_coords(1),allRects.rate4_coords(2),colors(:,4));

Screen('TextSize',window,oldSize);

end