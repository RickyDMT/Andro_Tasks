function allRects=setUpRectangles()
global DIMS;

%dims is a struct with fields wRect, DIMS.xdim, and DIMS.ydim
%photo is an image to be presented on screen


% photosize = size(photo);
% allRects.photosize=photosize;
% allRects.Part1PhotoRect1 = [DIMS.xdim/5 - photosize(2)/2, DIMS.ydim/2 - photosize(1)/2, DIMS.xdim/5 + photosize(2)/2, DIMS.ydim/2 + photosize(1)/2]; %left rect
% allRects.Part1PhotoRect2 = [4*DIMS.xdim/5 - photosize(2)/2, DIMS.ydim/2 - photosize(1)/2, 4*DIMS.xdim/5 + photosize(2)/2, DIMS.ydim/2 + photosize(1)/2]; %right rect
% % photorect = [DIMS.xdim/3 - photosize(2)/2, DIMS.ydim/2 - photosize(1)/2, DIMS.xdim/3 + photosize(2)/2, DIMS.ydim/2 + photosize(1)/2]; %photosize from earlier photo box creation
% allRects.photorect = [DIMS.xdim/2 - photosize(2)/2, DIMS.ydim/4 - photosize(1)/2, DIMS.xdim/2 + photosize(2)/2, DIMS.ydim/4 + photosize(1)/2];
% 
% allRects.Rate1 = [DIMS.xdim*(2.5/16),DIMS.ydim*(7/10),DIMS.xdim*((2.5/16)+(1/8)),DIMS.ydim*(8/10)];
% allRects.Rate2 = [DIMS.xdim*((2.5/16)+(3/16)),DIMS.ydim*(7/10),DIMS.xdim*((2.5/16)+(1/8)+(3/16)),DIMS.ydim*(8/10)];
% allRects.Rate3 = [DIMS.xdim*((2.5/16)+(6/16)),DIMS.ydim*(7/10),DIMS.xdim*((2.5/16)+(1/8)+(6/16)),DIMS.ydim*(8/10)];
% allRects.Rate4 = [DIMS.xdim*((2.5/16)+(9/16)),DIMS.ydim*(7/10),DIMS.xdim*((2.5/16)+(1/8)+(9/16)),DIMS.ydim*(8/10)];
% allRects.num1 = allRects.Rate1+(DIMS.xdim*1/16);
% allRects.num2 = allRects.Rate2+(DIMS.xdim*1/16);
% allRects.num3 = allRects.Rate3+(DIMS.xdim*1/16);
% allRects.num4 = allRects.Rate4+(DIMS.xdim*1/16);
% 
% %Set Text Coordinates.  Still need to use textbounds to set the
% %rectangles
% Screen('TextSize', w, 60);
% Part1TextBoundMatrix(1,:) = Screen('TextBounds', w, '1+2+3+4=5'); %use to generate box of proper size
% Part1TextCoordMatrix(1,1) = DIMS.xdim/2 - (Part1TextBoundMatrix(1,3)/2);
% Part1TextCoordMatrix(1,2) = 2*DIMS.ydim/3 - Part1TextBoundMatrix(1,4)/2;
% 
% Part1TextBoundMatrix(2,:) = Screen('TextBounds', w, 'FALSE');
% Part1TextCoordMatrix(2,1) = DIMS.xdim/3 - (Part1TextBoundMatrix(2,3)/2);
% Part1TextCoordMatrix(2,2) = 2.5*DIMS.ydim/3 - Part1TextBoundMatrix(2,4)/2;%move down for netbook
% 
% Part1TextBoundMatrix(3,:) = Screen('TextBounds', w, 'TRUE');
% Part1TextCoordMatrix(3,1) = 2*DIMS.xdim /3 - (Part1TextBoundMatrix(3,3)/2);
% Part1TextCoordMatrix(3,2) = 2.5*DIMS.ydim/3 - Part1TextBoundMatrix(3,4)/2;%move down for netbook
% 
% Part1TextBoundMatrix(4,:) = Screen('TextBounds', w, 'Time Expired!');
% Part1TextCoordMatrix(4,1) = DIMS.xdim/2 - Part1TextBoundMatrix(4,3)/2;
% Part1TextCoordMatrix(4,2) = DIMS.ydim/2 - Part1TextBoundMatrix(4,4)/2;
% 
% Part1TextBoundMatrix(5,:) = Screen('TextBounds', w, 'Invalid Key');
% Part1TextCoordMatrix(5,1) = DIMS.xdim/3 - Part1TextBoundMatrix(5,3)/2;
% Part1TextCoordMatrix(5,2) = 2*DIMS.ydim/3 - Part1TextBoundMatrix(5,4)/2;
% 
% Part1TextBoundMatrix(6,:) = Screen('TextBounds', w, 'Invalid Key');
% Part1TextCoordMatrix(6,1) = 2*DIMS.xdim/3 - Part1TextBoundMatrix(6,3)/2;
% Part1TextCoordMatrix(6,2) = 2*DIMS.ydim/3 - Part1TextBoundMatrix(6,4)/2;
% % keyrect1 = [DIMS.xdim/3 - (Part1TextBoundMatrix(5,3)/2), 8*DIMS.ydim/12 - (Part1TextBoundMatrix(5,4)/2), DIMS.xdim/3 + (Part1TextBoundMatrix(5,3)/2),7*DIMS.ydim/12 + (Part1TextBoundMatrix(5,4)/2)];
% % keyrect2 = [2*DIMS.xdim/3 - (Part1TextBoundMatrix(5,3)/2), 8*DIMS.ydim/12 - (Part1TextBoundMatrix(5,4)/2), 2*DIMS.xdim/3 + (Part1TextBoundMatrix(5,3)/2),7*DIMS.ydim/12 + (Part1TextBoundMatrix(5,4)/2)];
% 
% 
% %rectangles for equation and true false
% allRects.mainrect = [Part1TextCoordMatrix(1,1) - 20, Part1TextCoordMatrix(1,2) - 20, Part1TextCoordMatrix(1,1) + Part1TextBoundMatrix(1,3) + 20, Part1TextCoordMatrix(1,2) + Part1TextBoundMatrix(1,4) + 20]; %for equation
% allRects.leftrect = [DIMS.xdim/3 - ( Part1TextBoundMatrix(2,3) + 20 ) / 2, Part1TextCoordMatrix(2,2) - 10 , DIMS.xdim/3 + ( Part1TextBoundMatrix(2,3) + 20 ) / 2, Part1TextCoordMatrix(2,2) + Part1TextBoundMatrix(2,4) + 10]; %false
% allRects.rightrect = [2*DIMS.xdim/3 - ( Part1TextBoundMatrix(3,3) + 20 ) / 2, Part1TextCoordMatrix(3,2) - 10 , 2*DIMS.xdim/3 + ( Part1TextBoundMatrix(3,3) + 20 ) / 2, Part1TextCoordMatrix(3,2) + Part1TextBoundMatrix(3,4) + 10]; %true
% allRects.leftrect2 = [DIMS.xdim/3 - ( Part1TextBoundMatrix(5,3) + 20 ) / 2, Part1TextCoordMatrix(5,2) - 10 , DIMS.xdim/3 + ( Part1TextBoundMatrix(5,3) + 20 ) / 2, Part1TextCoordMatrix(5,2) + Part1TextBoundMatrix(5,4) + 10]; %false
% allRects.rightrect2 = [2*DIMS.xdim/3 - ( Part1TextBoundMatrix(6,3) + 20 ) / 2, Part1TextCoordMatrix(6,2) - 10 , 2*DIMS.xdim/3 + ( Part1TextBoundMatrix(6,3) + 20 ) / 2, Part1TextCoordMatrix(6,2) + Part1TextBoundMatrix(6,4) + 10]; %true
% 
% 
% %rectangles for ratings
% allRects.crect1 = [100 600 280 700];
% allRects.crect2 = [305 600 485 700];
% allRects.crect3 = [519 600 699 700];
% allRects.crect4 = [734 600 914 700];

%%

XCENTER=DIMS.XCENTER;
YCENTER=DIMS.YCENTER;
yshift=180;

% photosize=size(photo);
photosize=[225 216];

allRects.photo_coords=[XCENTER,(photosize(2)/2)+40+yshift];


% This is where the status information will be drawn
allRects.status_coords=[XCENTER,(photosize(2)/2)-85+yshift-40];

% This is where the observe stimulus will be drawn
% allRects.observe_coords=[134,91];
allRects.observe_coords=[XCENTER,(photosize(2)/2)-75];




ratings_spacing=150;
ratings_width=100;
ratings_height=70;

allRects.rate1_coords=[XCENTER-fix(1.5*ratings_spacing),YCENTER+90+yshift];
allRects.rate2_coords=[XCENTER-fix(.5*ratings_spacing),YCENTER+90+yshift];
allRects.rate3_coords=[XCENTER+fix(.5*ratings_spacing),YCENTER+90+yshift];
allRects.rate4_coords=[XCENTER+fix(1.5*ratings_spacing),YCENTER+90+yshift];

raterect=[0 0 ratings_width ratings_height];
allRects.rate1rect=CenterRectOnPoint(raterect,allRects.rate1_coords(1),allRects.rate1_coords(2));
allRects.rate2rect=CenterRectOnPoint(raterect,allRects.rate2_coords(1),allRects.rate2_coords(2));
allRects.rate3rect=CenterRectOnPoint(raterect,allRects.rate3_coords(1),allRects.rate3_coords(2));
allRects.rate4rect=CenterRectOnPoint(raterect,allRects.rate4_coords(1),allRects.rate4_coords(2));

photorect=[0 0 photosize(2) photosize(1)];
allRects.photorect=CenterRectOnPoint(photorect,allRects.photo_coords(1),allRects.photo_coords(2));

options_linespacing=40;
options_width=225;

allRects.option1_coords=[XCENTER, allRects.photorect(4)+20];
allRects.option2_coords=[XCENTER, allRects.photorect(4)+20+options_linespacing];


option1rect=[0 0 options_width options_linespacing];
allRects.option1rect=CenterRectOnPoint(option1rect,allRects.option1_coords(1),allRects.option1_coords(2));
option2rect=[0 0 options_width options_linespacing];
allRects.option2rect=CenterRectOnPoint(option2rect,allRects.option2_coords(1),allRects.option2_coords(2));


choices_width=325;
choices_height=75;
choices_spacing=10;

allRects.leftchoice_coords=[XCENTER-fix(choices_width/2)-choices_spacing, allRects.option2_coords(2)+choices_height+10];
allRects.rightchoice_coords=[XCENTER+fix(choices_width/2)+choices_spacing,allRects.option2_coords(2)+choices_height+10];


leftchoicerect=[0 0 choices_width choices_height];
allRects.leftchoicerect=CenterRectOnPoint(leftchoicerect,allRects.leftchoice_coords(1),allRects.leftchoice_coords(2));

rightchoicerect=[0 0 choices_width choices_height];
allRects.rightchoicerect=CenterRectOnPoint(rightchoicerect,allRects.rightchoice_coords(1),allRects.rightchoice_coords(2));


eq_width=250;
eq_height=100;
allRects.eq_coords=[XCENTER YCENTER+20+yshift];

eqRect=[0 0 eq_width eq_height];
allRects.eqrect=CenterRectOnPoint(eqRect,allRects.eq_coords(1),allRects.eq_coords(2));

resprect_width=200;
resprect_height=80;
resprect_spacing=100;

allRects.resprectleft_coords=[XCENTER-(resprect_width/2)-(resprect_spacing/2),allRects.eq_coords(2)+(eq_width/2)+15];
allRects.resprectright_coords=[XCENTER+(resprect_width/2)+(resprect_spacing/2),allRects.eq_coords(2)+(eq_width/2)+15];


resprect=[0 0 resprect_width resprect_height];
allRects.falseRect_left=CenterRectOnPoint(resprect,allRects.resprectleft_coords(1),allRects.resprectleft_coords(2));
allRects.trueRect_right=CenterRectOnPoint(resprect,allRects.resprectright_coords(1),allRects.resprectright_coords(2));



end