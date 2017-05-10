function addBrainRadioVisit()
%% This funciton finds raw data files and imports them into sysem
[settings, params] = getSettingsAndParams();
addpath(genpath(pwd));
%% Find large moodify data database
% all .xls files must have this naming convention:
% 'IMS*.xls'
% find IMS xls files:
skipthis = 0;
if ~skipthis
    fims = findFilesBVQX(settings.rootdir,'IMS*.xls');
    for i = 1:length(fims)
        [num,txt,raw] = xlsread(fims{i});
        % put data in one big structure
        for c = 1:size(raw,2)
            fieldname = genvarname(raw{1,c});
            imsdata.(fieldname) = raw(2:end,c);
        end
        imstable = struct2table(imsdata);
        dates = datetime(cell2mat(imstable.datlocal_ts),'ConvertFrom','posixtime');
        % subtract 8 hours
        datesMinus8 = dates - hours(8);
    end
end
% XXX concatenate imstable in the future
%% find empatica data 
settings.rawempaticFold
fe = findFilesBVQX(settings.rawempaticFold,'*.zip');
unzip(fe,settings.rawempaticFold); 
for z = 1:length(fe) 
    unzip(fe); 
end

%% Find visit
fv = findFilesBVQX(settings.rootdir,'20*',struct('dirs',1,'depth',1));

for v = 1:length(fv) % loop on visits
    ff = findFilesBVQX(fv{v},'*_MR*.txt'); % find raw txt files
    % find xls file
    fxls = findFilesBVQX(fv{v},'*.xlsm'); % find raw txt files
    if ~isempty(ff) % no text files
        for f = 1:length(ff)
            [pn,fn, ext] = fileparts(ff{f});
            visitdetail = parseXLSvisitDetail(fxls{1}, [fn '.xml']);
            xmldetail   = parseXML(fullfile(pn,[fn '.xml'] )); %
%             xmlstruc = parseXMLstruc(xmldetail); % XXX fix this so json
%             is more resable 
            %             Patients    = loadjson(fullfile(rootdir,patientJson),'SimplifyCell',1); % this is how to read the data back in.
            %% to do write a loop that will match the xml file, txt file and ims file
            %% write all of this to one json file
            dataToWriteJson.visitdetail = visitdetail;
            dataToWriteJson.xmldetail = xmldetail;
            
            jsonfn = sprintf('%s_session_details-^^^^-.json',fn);
            savejson('',dataToWriteJson,fullfile(pn, jsonfn));
            %% add ims data 
            dataToWriteJson.imsdata = []; % default empty 
            % find corret imsdata 
            %% find watch data 
        end
    end
end
