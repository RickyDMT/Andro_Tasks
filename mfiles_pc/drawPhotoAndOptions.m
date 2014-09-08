function drawPhotoAndOptions(photo,varargin)

global allRects w w2 DIMS COLORS;





colortop=COLORS.WHITE;
colorbottom=COLORS.WHITE;


if ~isempty(varargin{1}) && nargin >=2
    if strcmp(varargin{1},'top')
        colortop=COLORS.GREEN;
    elseif strcmp(varargin{1},'bottom')
        colorbottom=COLORS.GREEN;
    end
end


if nargin<3
    
    window=w;
    
else 
    
    window=varargin{2};
    
end

%oldTextSize=
Screen('TextSize',window,35);

% oldTextSize2=Screen('TextSize',w2,45);

%response feedback (highlights in green for .25s)
Screen('PutImage', window, photo, allRects.photorect);
CenterTextOnPoint(window,'Compete',allRects.option1_coords(1),allRects.option1_coords(2),colortop);
CenterTextOnPoint(window,'Piece Rate',allRects.option2_coords(1),allRects.option2_coords(2),colorbottom);
%Screen('TextSize',window,oldTextSize);

% Screen('PutImage', w2, photo, allRects.photorect);
% CenterTextOnPoint(w2,'Compete',allRects.option1_coords(1),allRects.option1_coords(2),colortop);
% CenterTextOnPoint(w2,'Piece Rate',allRects.option2_coords(1),allRects.option2_coords(2),colorbottom);
% Screen('TextSize',w2,oldTextSize2);


end