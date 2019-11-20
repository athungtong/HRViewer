

Path = 'G:\MrOS1\MrOS_Arrythmia_Scoring\Somte_scored';

ResultPath = 'E:\RPT_ART';

Folders = dir(Path);

for i=3:length(Folders)
    i
    tic
    if Folders(i).isdir
           FileName = Folders(i).name(1:6);
           
           Data = mdbRead([Path '\' Folders(i).name '\EVENTS.mdb'],'ECG');
           
           R_Index = [];
           Art_Index = [];
           Counter  = 1;
           
           for j=1:size(Data,1)
               R_Index(j)=Data{j,1};
               if Data{j,9}~=1
                   Counter = Counter + 1;
                   Art_Index(Counter) = Data{j,1};
               end
           end
           
           dlmwrite([ResultPath '\' FileName '.rpt'],R_Index','delimiter','\t', 'newline', 'pc',...
            'precision', '%.0f');
           dlmwrite([ResultPath '\' FileName '.art'],Art_Index','delimiter','\t', 'newline', 'pc',...
            'precision', '%.0f');
    end
    toc
end



%%

% export R wave as well as type together

Path = 'G:\MrOS1\MrOS_Arrythmia_Scoring\Somte_scored';

ResultPath = 'C:\Documents and Settings\Farhad\Desktop\Dropbox\RTP';

Folders = dir(Path);

for i=3:length(Folders)
    i
    tic
    if Folders(i).isdir
           FileName = Folders(i).name(1:6);
           
           Data = mdbRead([Path '\' Folders(i).name '\EVENTS.mdb'],'ECG');
           
           R_Index = [];
           Counter  = 0;
           Type = [];
           
           for j=1:size(Data,1)
               R_Index(j)=Data{j,1};
               Type(j) = Data{j,9};
           end
           
           dlmwrite([ResultPath '\' FileName '.rtp'],[R_Index' Type'],'delimiter','\t', 'newline', 'pc',...
            'precision', '%.0f');
           
    end
    toc
end
