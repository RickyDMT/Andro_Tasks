function Androgel_Practice

global KEYS w w2 Phase2 Phase1 select allRects COLORS loaddir1 DIMS TIME_BASELINE xkeys macbook AllData;


%%
%to list devices, use this command:
[keyboardIndices, productNames, allInfos] = GetKeyboardIndices

isxkeys=strcmp(productNames,'Xkeys')

xkeys=keyboardIndices(isxkeys)

macbook = keyboardIndices(strcmp(productNames,'Apple Keyboard'))


KEYS.xkeys=xkeys;
KEYS.macbook=macbook;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%find the mfilesdir by figuring out where show_faces.m is kept
[mfilesdir,name,ext] = fileparts(which('Androgel_Practice.m'));

%get the parent directory, which is one level up from mfilesdir
% [parentdir,~,~] =fileparts(mfilesdir);

%create the paths to the other directories, starting from the parent
%directory
% loaddir1 = [parentdir filesep 'Results/Phase1_AllFiles/'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

cd(mfilesdir);
load('Androgel_Practice_Data.mat');


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
KEYS.ONE=one;
KEYS.TWO=two;
KEYS.THREE=three;
KEYS.FOUR=four;


%Set colors
black = [0 0 0];
white = [255 255 255];
red = [255 0 0];
blue = [0 0 255];
green = [0 255 0];


COLORS.BLACK = [0 0 0];
COLORS.WHITE = [255 255 255];
COLORS.RED = [255 0 0];
COLORS.BLUE = [0 0 255];
COLORS.GREEN = [0 255 0];

%% BioPac Setup
%This readies the BioPac unit which, although unused in the practice
%trials, is required due to Biopac coding in the DoCompeteTrial.m function.
%Uses io64 mex file from http://apps.usd.edu/coglab/psyc770/IO64.html with
%"address" hard coded into outp.m file (i.e., 8224 for room 133, 12320 for
%room 135). For other computers, find the parallel port address and input
%that hex value as a dec into the outp.m file.

%Trigger pulses coded in doCompeteTrial.m
config_io;
outp(0);

%%
%commandwindow
% 
% %Open Screen Window and set preferences
% screennumber =max(Screen('Screens')); %gets screen number
% screennumber2 =min(Screen('Screens'));

Screen('Preference', 'SkipSyncTests', 1 );
%Open Screen Window and set preferences
screennumber =1; %min(Screen('Screens')); %gets screen number
screennumber2 = 2; %max(Screen('Screens'));


%change screen resolution
%Screen('Resolution',screennumber,1024,768,[],32);

% if screennumber~=screennumber2
%     Screen('Resolution',screennumber2,1024,768,[],32);
% end


[w, wrect] = Screen('OpenWindow', screennumber);
[xdim, ydim] = Screen('WindowSize', screennumber);
% Screen('Preference', 'VisualDebugLevel', 3);
% Screen('Preference', 'SuppressAllWarnings', 1);
Screen('TextFont', w, 'Arial');
Screen('TextStyle', w, 1);
Screen('TextSize',w,35);



if screennumber~=screennumber2
    
    [w2, wrect2] = Screen('OpenWindow', screennumber2);
    Screen('TextFont', w2, 'Arial');
    Screen('TextStyle', w2, 1);
    Screen('TextSize',w2,35);
    
end


if screennumber==screennumber2
    
    w2=w;
    
end

DIMS=struct;
DIMS.xdim=xdim;
DIMS.ydim=ydim;
DIMS.XCENTER=fix(xdim/2);
DIMS.YCENTER=fix(ydim/2);


Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'Practice trials.\n\nPress any key to continue.','center','center',COLORS.WHITE);
Screen('Flip',w);
% KbWait;

Screen('FillRect',w2,COLORS.BLACK);
DrawFormattedText(w2,'Practice trials.\n\nPress any key to continue.','center','center',COLORS.WHITE);
Screen('Flip',w2);
KbWait;

Screen('FillRect', w, black); %%% added ian
DrawFormattedText(w,'+','center','center',white);
%time baseline
TIME_BASELINE=Screen('Flip', w);

Screen('FillRect', w2, black); %%% added ian
DrawFormattedText(w2,'+','center','center',white);
%time baseline
TIME_BASELINE=Screen('Flip', w2);

%Set up rectangles that will be used later
allRects=setUpRectangles();

%randomize the location of the choices
randomized_positions=CoinFlip(length(AllData.Opponent),.5);

%number of practice trials to do
numPracticeTrials=4;

WaitSecs(1);

%Display pictures and decisions
for  trial = 1:numPracticeTrials 
 
    position=randomized_positions(trial);
    doCompeteTrial(trial,position);
    
    
end   

Screen('FillRect',w,COLORS.BLACK);
DrawFormattedText(w,'Practice Complete.','center','center',COLORS.WHITE);
Screen('Flip',w);
Screen('FillRect',w2,COLORS.BLACK);
DrawFormattedText(w2,'Practice Complete.','center','center',COLORS.WHITE);
Screen('Flip',w2);
WaitSecs(4.0);
%ELK: Prevents crashing of other scripts? 7/21/14
outp(0); %Reset BioPac to 0.
clearvars
clearvars -global

Screen('CloseAll');