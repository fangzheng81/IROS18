%% Start
clear; clc; 
addpath('cfg'); addpath('src');  
tic

% Current configuration
cfg_171007;

%% Main

% set path of the Grid  
test_path = '/media/gskim/Data/NCLT/training/[-310,-455]';

% parsing 
bins_from_different_days = strsplit(ls(test_path));
bins_from_different_days = bins_from_different_days(~cellfun('isempty',bins_from_different_days)); % remove empty cell

num_days = length(bins_from_different_days);
set_of_isovist = zeros(num_days, Num_pies); % row convention 

for i= 1:num_days
    
    % set the path of the bin of the day 
    tmp_bin = ls(strcat(test_path, '/', bins_from_different_days{i}));
    tmp_bin = strsplit(tmp_bin);
    tmp_bin = tmp_bin(~cellfun('isempty',tmp_bin)); % remove empty cell
    
    for j=1:length(tmp_bin)
        file = tmp_bin{j};
        if( ~isempty(file))
            if( file(end-2:end) == 'bin')
                tmp_bin_name = file;
            end
        end
    end
    
    tmp_path = strcat(test_path, '/', bins_from_different_days{i}, '/', tmp_bin_name);
    
    %% Main    
    
    % load 
    ptcloud = SavePointcloudFromBin(tmp_path, color_flag);

    % Split into N pies 
    ptcloud_pies = SplitPointcloudIntoPies(ptcloud, Num_pies, color_flag);

    % Comput Isovist
    isovist = zeros(1, Num_pies);
    for j = 1:Num_pies
       pie = ptcloud_pies{j};
       isovist(j) = ComputeIsovistFromPie(pie); % Detail Algorithm should be improved.
    end

    set_of_isovist(i,:) = isovist;

end

%% Draw 
fig1 = figure(1);
x = linspace(1, Num_pies, Num_pies);

for ith_pie = 1:num_days
    plot(x, set_of_isovist(ith_pie,:));
    hold on;
end

set(gcf,'pos',[50 250 1700 450]);

%% Draw only two
% fig3 = figure(3);
% x = linspace(1, Num_pies, Num_pies);
% 
% iso = set_of_isovist(6,:);
% set_of_isovist(6,:) = ShiftIsovistBins(iso, 6);
% 
% 
% for ith_pie = 5:6
%     plot(x, set_of_isovist(ith_pie,:));
%     hold on;
% end
% 
% set(gcf,'pos',[20 250 1900 450]);
% 
% 
