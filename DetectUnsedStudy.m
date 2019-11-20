clear all
clc

load SleepTimes


Files = dir(['*Results.mat']);


NumberEpoch = [];
CounterNotEDF = 0;

for i=1:length(Files)
    
    Name = Files(i).name;
    Name([-11:0]+end)=[];
    FileName = [Name '_Result.txt'];
    
    
    
    Temp = dir([Name '.edf']);
    if isempty(Temp)
        CounterNotEDF = CounterNotEDF + 1;
        FilesNotFound{CounterNotEDF,1}=Name;
    end
    
end