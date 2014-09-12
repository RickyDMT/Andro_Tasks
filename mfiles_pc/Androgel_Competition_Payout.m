 function Androgel_Competition_Payout()

%%% ALL OF THE ASPECTS REGARDING THE RANDOMLY CHOSEN REPLAY TRIAL HAVE BEEN
%%% COMMENTED OUT


%find the mfilesdir by figuring out where show_faces.m is kept
[mfilesdir,name,ext] = fileparts(which('Androgel_Competition_Payout.m'));

%get the parent directory, which is one level up from mfilesdir
[parentdir,~,~] =fileparts(mfilesdir);


%create the paths to the other directories, starting from the parent
%directory
resultsDir = [parentdir filesep 'Results' filesep];

cd(resultsDir);

idnum=input('Subject ID:  ');


dicethrow1=input('Throw the dice (1-16)! What did you get?  ');
dicethrow2=input('Throw the dice (1-16)! What did you get?  ');
dicethrow3=input('Throw the dice (1-16)! What did you get?  ');
dicethrow4=input('Throw the dice (1-12)! What did you get?  ');
if dicethrow4 > 12;
        dicethrow4 = input('Invalid number.\nPlease choose a number between 1 & 12.\n Throw the dice! What did you get?');
end
dicethrow5=input('Throw the dice (1-12)! What did you get?  ');
if dicethrow5 > 12;
        dicethrow5 = input('Invalid number.\nPlease choose a number between 1 & 12.\n Throw the dice (1-12)! What did you get?');
end


load(['AllData_' num2str(idnum) '.mat']);
load(['proDMT_' num2str(idnum) '.mat']);


choiceTrials=find(AllData.TrialType==1);
competeTrials=find(AllData.TrialType==2);
pieceTrials=find(AllData.TrialType==3);
publicDMT =find(proDMT.Var.Observe==1);
privateDMT =find(proDMT.Var.Observe==2);

%%

Did_Replay=find(AllData.ReplayData.Did_Replay==1);

randChoice=choiceTrials(dicethrow1);
randCompete=competeTrials(dicethrow2);
randPiece=pieceTrials(dicethrow3);
randPublic = publicDMT(dicethrow4);
randPriv = privateDMT(dicethrow5);


%initialize payouts to 0
Replay=0;
Choice=0;
ManPiece=0;
ManComp=0;
pubDMT = 0;
privDMT = 0;



%%SET PAYOUT VALUES HERE; THESE VALUES WILL CHANGE BASED ON WHERTHER IT IS
%%THE PILOT TASK OR THE FINAL ANDROGEL COMPETITION TASK
ppiece = 2; %a value of 1 will pay the subject $1 per correct answer on the random piece rate round selected
pwin = 4; %a value of 2 means the subject will be paid $2 per correct answer if they beat their opponent on the randomly chosen round
plose = 0; %a value of 0 means the subject will recieve nothing if they lose the randomly selected round

%for the replay
rwin = 4; %a value of 2 means the subject will be paid $2 per correct answer if they beat their opponent on the randomly chosen round
rlose = 0; %a value of zero means the subject recieves $0 per point if they lose the replay competition (outside the scanner)

if AllData.WinLose(randCompete) == 1;
    ManComp = AllData.Score(randCompete)*pwin;
else
    ManComp = AllData.Score(randCompete)*plose;
end


%%

ManPiece = AllData.Score(randPiece)*ppiece;


if AllData.Choice(randChoice)==1
    if AllData.WinLose(randChoice) == 1;
        ManComp = AllData.Score(randChoice)*pwin;
    else
        ManComp = AllData.Score(randChoice)*plose;
    end
else
    Choice = AllData.Score(randChoice)*ppiece;
end



% if randReplay>length(AllData.ReplayData.Score)
%    randReplay=length(AllData.ReplayData.Score);
% end



if AllData.ReplayData.ReplayChoice(Did_Replay)==1
    if AllData.ReplayData.Replay_WinLose(Did_Replay) == 1;
        Replay = AllData.ReplayData.Score(Did_Replay)*pwin;
        
    elseif isnan(AllData.ReplayData.Score(Did_Replay))
        Replay=0;    
        
    else
        Replay = AllData.ReplayData.Score(Did_Replay)*plose;
    end
else
    Replay = AllData.ReplayData.Score(Did_Replay)*ppiece;
end

%Public/Private Payouts
pubDMT = proDMT.Data.Amt_You(randPublic);
privDMT = proDMT.Data.Amt_You(randPriv);
pubDMT_donated = proDMT.Data.Amt_Char(randPublic);
privDMT_donated = proDMT.Data.Amt_Char(randPriv);


%%% This prevents any negative payout values
if Choice < 0  
    Choice =0;   
end

if ManComp < 0  
    ManComp =0;  
end

if ManPiece < 0  
    ManPiece =0;   
end

if Replay < 0  
    Replay =0;   
end



Choice
ManComp
ManPiece
Replay
pubDMT
privDMT

%% If we choose to include replay trials

totalpayout = Choice + ManComp + ManPiece + Replay + pubDMT + privDMT;
%totalpayout = Replay + Choice + ManPiece + ManComp;

%% Without replay trials

% totalpayout = Choice + ManPiece + ManComp;

fprintf('Total Payout is: $%.2f\n',totalpayout);

%% Save values of FFLC donations to "proDMT_donationlog"
%This needs testing. ELK 5/29
%Save public & private donations to a .mat in "Results" folder to keep
%running tally of how much we owe FfLC.

try 
    load('proDMT_donationlog.mat');
    nextline = size(proDMT_donationlog,1)+1;
    proDMT_donationlog(nextline,1:4)={datestr(now),idnum,pubDMT_donated,privDMT_donated};

    save([resultsDir 'proDMT_donationlog.mat'],'proDMT_donationlog');
catch %Think this may be wrong. Check out StopSigTask to see how they try/catch.
    fprintf('There was a problem loading or saving the proDMT log file. Saving new file instead.');
    proDMT_log_errname = sprintf('proDMT_donationlog_%d.mat',idnum);
    proDMT_log_err = {datestr(now),idnum,pubDMT_donated,privDMT_donated};
    save([resultsDir proDMT_log_errname],'proDMT_log_err');
end

%% Save total payout values because that seems like that would be a good idea. ELK 9/12
% Save each of 6 values (4 comp, 2 proDMT) to a .mat in "Results" folder

try
    load('Bonus_Payments.mat');
    nextline = size(Bonus_Payments,1)+1;
    Bonus_Payments(nextline,1:8)={datestr(now),idnum,Choice,ManComp,ManPiece,Replay,pubDMT,privDMT};

    save([resultsDir 'Bonus_Payments.mat'],'Bonus_Payments');
catch
    fprintf('There was a problem loading or saving the Bonus Payment file. Saving new file instead.');
    Bonus_Payment_errname = sprintf('Bonus_Payments_%d.mat',idnum);
    Bonus_Payment_err = {datestr(now),idnum,Choice,ManComp,ManPiece,Replay,pubDMT,privDMT};
    save([resultsDir Bonus_Payment_errname],'Bonus_Payment_err');
end
