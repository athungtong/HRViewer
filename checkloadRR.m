function needfile=checkloadRR(filename)
%%
    [selectedButton ] = uigetpref(...
        'needfile',...             % Group
        'alwaysunload',...           % Preference
        'load RR time series?',...                    % Window title
        {'We could not find RR interval information in:'
         ''
         filename
         ''
         'Do you have RR interval information saved in another file (text file containing column vector of R time series)?'},...
        {'Yes, select a file','No, I do not have file'},...        % Values and button strings
         'DefaultButton','No, I do not have file',...             % Default choice
         'CheckboxString','Apply this answer for the next file');           
%%
    needfile=0;
    switch selectedButton
        case 'yes, select a file'  % Open a Save dialog (without testing if saved before)
            needfile=1;
        case 'no thank you'                % Close the figure without saving it
           needfile=0;           
    end

