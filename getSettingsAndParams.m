function [settings, params] = getSettingsAndParams()
%settings: (where is the data) 
settings.rootdir        = '/Volumes/pstarr_shared/ECOG data/PCS PFC/petersen/';
settings.rawempaticFold = fullfile(settings.rootdir,'RawEmpatica');
% settings.rootdir = fullfile('..','data'); 

%params: (data analysis 
params = []; 
end