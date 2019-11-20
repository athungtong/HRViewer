function Results = checkRRinfo(Results,filename)


    %Check if RRinfo exist, ask if user like to open RRinfo file
    hasRtime=0;
    if isfield(Results,'RRinfo')
        if isfield(Results.RRinfo,'R_time')
            if isvector(Results.RRinfo.R_time) && isnumeric(Results.RRinfo.R_time)
                if sum(diff(Results.RRinfo.R_time)<0)==0
                    hasRtime = 1;
                end
            end
        end
    end
    
    
    if ~hasRtime %do not has R time field
         needfile=checkloadRR(filename); %ask if need to open R time file
        if needfile
            %open file dlg to load RR time
            [FileName,PathName] = uigetfile('.txt','Select R time series file');
            handles.inputfullfile=fullfile(PathName,FileName);
            handles=loadRfile(handles);
            
            if ~isempty(handles.R_time) 
                Results.RRinfo.R_time = handles.R_time;
                Results.RRinfo.RR_interval=diff(Results.RRinfo.R_time);
                Results.RRinfo.R_time(end)=[];            
            end
        else
            Results.RRinfo.R_time = [];
            Results.RRinfo.RR_interval = [];

            Results.hrv.time = (1:size(Results.hrv.Value,1))';
        end
    else
        hasRRinterval=0;
        if isfield(Results.RRinfo,'RR_interval')
            if isvector(Results.RRinfo.RR_interval) && isnumeric(Results.RRinfo.RR_interval)
                if length(Results.RRinfo.RR_interval)==length(Results.RRinfo.R_time)
                    hasRRinterval = 1;
                end
            end
        end
        
        if ~hasRRinterval
            Results.RRinfo.RR_interval=diff(Results.RRinfo.R_time);
            Results.RRinfo.R_time(end)=[]; 
        end
    end
    
    % manage segmentlength and hrv.time which are corresponding to R_time 
    if ~isempty(Results.RRinfo.R_time)
        Results.RRinfo.segmentlength=(Results.RRinfo.R_time(end)-Results.RRinfo.R_time(1))/size(Results.hrv.Value,1)/60;
        Results.hrv.time = Results.RRinfo.R_time(1)+(0:size(Results.hrv.Value,1)-1)'*Results.RRinfo.segmentlength*60;
    else
        Results.RRinfo.segmentlength=1;
        Results.hrv.time =(1:size(Results.hrv.Value,1))';
    end
  
    
    
  