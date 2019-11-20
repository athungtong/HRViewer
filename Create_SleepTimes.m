FileName = '/Users/FarhadMac/Desktop/Dropbox/matlab/Reena/edf viewer/Data/bi0001.edf'

Info = EdfInfo(FileName);
Info.FileInfo
Info.FileInfo.NumberDataRecord/3600

%%

clear all
fid=fopen('sleep_times.txt');
Counter = 0;
while 1
    Text = fgetl(fid);
    if ~ischar(Text)
        break
    end
    
    Counter = Counter + 1;
    Index = strfind(Text,9);
    
    SleepTimes.FileNames{Counter,1} = Text(1:Index(1)-1);
    SleepTimes.STDATEP{Counter,1} = Text(Index(1)+1:Index(2)-1);
    SleepTimes.STLOUTP{Counter,1} = Text(Index(2)+1:Index(3)-1);
    SleepTimes.STONSETP{Counter,1} = Text(Index(3)+1:Index(4)-1);
    SleepTimes.STLONP{Counter,1} = Text(Index(4)+1:end-1);
    
    disp(Text)
end
fclose('all');


%%

datenum(,'MM/DD/YY')

