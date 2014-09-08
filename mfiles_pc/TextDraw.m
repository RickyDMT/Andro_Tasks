function TextDraw(text, window, textsize, x, y, color)

%x and y must be between 0 and 1, they specify where text should be
%centered.  For example, x = 1/2, y = 1/2 would center the text in the
%middle of the screen.

screennumber = max(Screen('Screens'));
[xdim, ydim] = Screen('WindowSize', screennumber);


oldTextSize=Screen('TextSize', window, textsize);
TextBounds = Screen('TextBounds', window, text);
XCoord = x*xdim - TextBounds(3)/2;
YCoord = y*ydim - TextBounds(4)/2;

Screen('DrawText', window, text, XCoord, YCoord, color);

Screen('TextSize',window,oldTextSize);


