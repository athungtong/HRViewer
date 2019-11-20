function Results=loadtxtfile(handles,i)

    % load HRV data from any txt or xls file 
    noheader=0;
    if strcmp(xlsfinfo(handles.newfname{i}),'Microsoft Excel Spreadsheet')
        if ismac
            errdlg('Cannot import excel file in mac machine');
            Results.hrv.Value=[];
            return;
        end
        [Results.hrv.Value Results.hrv.Labels]=xlsread(handles.newfname{i});
        if isempty(Results.hrv.Labels)
            noheader=1;
        end
    else        
        [temp dim] = importdata(handles.newfname{i});
        if isstruct(temp) % if file contain header
            Results.hrv.Value=temp.data;
            
            if isfield(temp,'colheaders')
                Results.hrv.Labels=temp.colheaders;
            else
                indx=strfind(char(temp.textdata),dim);
                if ~isempty(indx)
                    text=char(temp.textdata);
                    Results.hrv.Labels={text(1: indx(1)-1)};
                    for j=1:length(indx)-1
                        Results.hrv.Labels=[Results.hrv.Labels text((indx(j)+1):(indx(j+1)-1))];
                    end 
                else
                    noheader=1;
                end
            end
            
        else
            Results.hrv.Value=temp;
            noheader=1;
        end
    end
    
    %check if data is numeric array
    if ~isnumeric(Results.hrv.Value)
        errordlg({['Error loading file ' handles.newfname{i}],'HRV values must be a numeric array.'},'Incompattible data format!');
        Results.hrv.Value=[];
        return;
    end
    
    
     if noheader % no header, no time vector
        Results.hrv.Labels={};
        for j=1:size(Results.hrv.Value,2)
            Results.hrv.Labels{j}=['Untitled ' num2str(j)];
        end 
     end
    
%     %test header and time vector
%     if sum(diff(Results.hrv.Value(:,1))<=0)>0 
%         Results.hrv.time=(1:size(Results.hrv.Value,1))'*5*60; % assume 5 minutes epoch
%         if noheader % no header, no time vector
%             Results.hrv.Labels={};
%             for j=1:size(Results.hrv.Value,2)
%                 Results.hrv.Labels{j}=['Unknown HRV ' num2str(j)];
%             end 
%         end
%     else
%         Results.hrv.time=Results.hrv.Value(:,1); %assign first row to be time vec
%         Results.hrv.Value(:,1)=[];    %delete first row, left only hrv data      
%         if noheader  % no header, has time vector
%             Results.hrv.Labels={};
%             for j=1:size(Results.hrv.Value,2)
%                 Results.hrv.Labels{j}=['Unknown HRV ' num2str(j)];
%             end
%         end
%     end
    
        
            
%     Results.Events.R_time = [];
%     Results.Events.RR_interval = [];
% 
%     Results.rawfilename = handles.newfname{i};
% 
%     Results.set=[];
%     if length(Results.hrv.time)>1
%         Results.param.hrv.epochsize = round(Results.hrv.time(2)-Results.hrv.time(1));
%     end

