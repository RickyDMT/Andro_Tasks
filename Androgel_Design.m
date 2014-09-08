function [AllData]=Androgel_Design(SUBID)

mfile_dir=fileparts(which(mfilename));

cd(mfile_dir);

load('OpponentPool.mat');

AllData=struct;

%%

men_higher=fieldnames(OpponentSubset.Men.Higher);
men_higher=cellfun(@(x) str2double(x(2:end)),men_higher);
men_higher_observe=randsample(men_higher,2)';

men_lower=fieldnames(OpponentSubset.Men.Lower);
men_lower=cellfun(@(x) str2double(x(2:end)),men_lower);
men_lower_observe=randsample(men_lower,2)';

women_higher=fieldnames(OpponentSubset.Women.Higher);
women_higher=cellfun(@(x) str2double(x(2:end)),women_higher);
women_higher_observe=randsample(women_higher,2)';

women_lower=fieldnames(OpponentSubset.Women.Lower);
women_lower=cellfun(@(x) str2double(x(2:end)),women_lower);
women_lower_observe=randsample(women_lower,2)';

observed_members=horzcat(men_higher_observe,men_lower_observe,women_higher_observe,women_lower_observe);



%%


%%% Men Voluntary Higher
[Run1,Mandatory1,TrialType1,Gender1,Higher1,Opponent1]=BalanceTrials(4,0,[1],[0],[1],[0],[1],men_higher);

%%% Men Voluntary Lower
[Run2,Mandatory2,TrialType2,Gender2,Higher2,Opponent2]=BalanceTrials(4,0,[1],[0],[1],[0],[0],men_lower);

%%% Men Mandatory Higher
[Run3,Mandatory3,TrialType3,Gender3,Higher3,Opponent3]=BalanceTrials(8,0,[1],[1],[2 3],[0],[1],men_higher);

%%% Men Mandatory Lower
[Run4,Mandatory4,TrialType4,Gender4,Higher4,Opponent4]=BalanceTrials(8,0,[1],[1],[2 3],[0],[0],men_lower);

%%% Women Voluntary Higher
[Run5,Mandatory5,TrialType5,Gender5,Higher5,Opponent5]=BalanceTrials(4,0,[1],[0],[1],[1],[1],women_higher);

%%% Women Voluntary Lower
[Run6,Mandatory6,TrialType6,Gender6,Higher6,Opponent6]=BalanceTrials(4,0,[1],[0],[1],[1],[0],women_lower);

%%% Women Mandatory Higher
[Run7,Mandatory7,TrialType7,Gender7,Higher7,Opponent7]=BalanceTrials(8,0,[1],[1],[2 3],[1],[1],women_higher);

%%% Women Mandatory Lower
[Run8,Mandatory8,TrialType8,Gender8,Higher8,Opponent8]=BalanceTrials(8,0,[1],[1],[2 3],[1],[0],women_lower);


% [mandatory,trialtype,gender,higher,opponent] =
% BalanceTrials(8,0,[1],[2,3],[0],[1],[101, 102, 103, 104]) %higher men,
% mandatory

AllData.SUBID=repmat(SUBID,48,1);
AllData.Trial=nan(48,1);
AllData.Run=vertcat(Run1,Run2,Run3,Run4,Run5,Run6,Run7,Run8);
AllData.Mandatory=vertcat(Mandatory1,Mandatory2,Mandatory3,Mandatory4,Mandatory5,Mandatory6,Mandatory7,Mandatory8);
AllData.TrialType=vertcat(TrialType1,TrialType2,TrialType3,TrialType4,TrialType5,TrialType6,TrialType7,TrialType8);
AllData.Gender=vertcat(Gender1,Gender2,Gender3,Gender4,Gender5,Gender6,Gender7,Gender8);
AllData.Higher=vertcat(Higher1,Higher2,Higher3,Higher4,Higher5,Higher6,Higher7,Higher8);
AllData.Observe=zeros(48,1);
AllData.Opponent=vertcat(Opponent1,Opponent2,Opponent3,Opponent4,Opponent5,Opponent6,Opponent7,Opponent8);
AllData.LongWait=zeros(48,1);
AllData.Response=nan(length(AllData.Opponent),1);
AllData.Choice=nan(length(AllData.Opponent),1);
AllData.Choice_RT=nan(length(AllData.Opponent),1);
AllData.Rating_RT=nan(length(AllData.Opponent),1);
AllData.Start_Equation_RT=nan(length(AllData.Opponent),1);
AllData.Rating=nan(length(AllData.Opponent),1);
AllData.WinLose=nan(length(AllData.Opponent),1);
AllData.Score=nan(length(AllData.Opponent),1);
AllData.Observe(ismember(AllData.Opponent,observed_members))=1;

rand_index = randperm(length(AllData.Opponent)); %shuffles integers from 1 to 48



allfields= fieldnames(AllData); %cell array of all field names

for i=1:length(allfields)
    
   current_field = allfields{i};
   
   current_col = AllData.(current_field);
   
   current_col = current_col(rand_index);
   
   AllData.(current_field) = current_col;
    
end

AllData.Trial(:,1)=1:48;


%Data for equation rounds
AllData.EquationData=struct;
AllData.EquationData.Equations=cell(1,1);
AllData.EquationData.TrueFalse=cell(1,1);
AllData.EquationData.RT=cell(1,1);
AllData.EquationData.Timestamps=cell(1,1);
AllData.EquationData.Response=cell(1,1);
AllData.EquationData.Accuracy=cell(1,1);

%set up columns for timing data
blank_col=nan(length(AllData.Opponent),1);
AllData.faceOnset= blank_col;
AllData.choicesOnset= blank_col;
AllData.choiceRespTime= blank_col;
AllData.ratingsOnset= blank_col;
AllData.rateRespTime= blank_col;
AllData.startEqnRespTime= blank_col;

%%% This is where all of the information about the opponents will be put
%%% into the structure (equations, score, etc.) It will be one random round
%%% per opponent.

AllData.OpponentPhoto=cell(length(AllData.Opponent),1);
AllData.OpponentEquation=cell(length(AllData.Opponent),1);
AllData.OpponentEquationTrue=cell(length(AllData.Opponent),1);
AllData.OpponentScore=nan(length(AllData.Opponent),1);
AllData.OpponentTotalRT=nan(length(AllData.Opponent),1);
AllData.OpponentRandomRound=nan(length(AllData.Opponent),1);

for i=1:length(AllData.Opponent)
    
    opponent_id=AllData.Opponent(i);
    sub = num2str(opponent_id);
    subfield=['s',sub];
    
    random_round = randsample(16,1)+4;
    
    if AllData.Gender(i)==0;
        
        gender='Men';
        
    else gender='Women';
        
    end
    
    if AllData.Higher(i)==1;
        
        level='Higher';
        
    else level='Lower';
        
    end
    
    AllData.OpponentPhoto{i}=OpponentSubset.(gender).(level).(subfield).SubjectPhoto;
    AllData.OpponentEquation{i}=OpponentSubset.(gender).(level).(subfield).Equation(:,random_round);
    AllData.OpponentEquationTrue{i}=OpponentSubset.(gender).(level).(subfield).True(:,random_round);
    AllData.OpponentScore(i)=OpponentSubset.(gender).(level).(subfield).Score(random_round);
    AllData.OpponentTotalRT(i)=OpponentSubset.(gender).(level).(subfield).TotalResponseTime(random_round);
    AllData.OpponentRandomRound(i)=random_round;
    
    
end


% CheckStructure=struct2dataset(AllData);

end