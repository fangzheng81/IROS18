function [ ] = SaveBinsCrspdGrid( parent_dir, grid_xy )

%% test as a script
% grid_xy = [-310, -455];
grid_xy = [-45, -250];

% Dont change this line (or replace of your path)
parent_dir = '/media/gskim/Data/NCLT';

%% start 
grid_x = grid_xy(1);
grid_y = grid_xy(2);

%% 1 Load All Paths 
[dates, bin_paths, pose_paths] = ParsePathOfAllDays(parent_dir);
the_num_days = length(pose_paths);

%% 2 Search for all days
for ith_date=1:the_num_days
    
    %% 2-1 Save the Times corresponding to the given grid   
    cur_day_pose = pose_paths{ith_date};
    
    GT_table = csvread(cur_day_pose);
    GT_time = int64(GT_table(:,1));
    GT_X = GT_table(:,2);
    GT_Y = GT_table(:,3);
    GT_Z = GT_table(:,4);
    GT_r = GT_table(:,5);
    GT_p = GT_table(:,6);
    GT_h = GT_table(:,7);

    test_info = [];
    test_info_where = [];
    table_size = length(GT_table);
    
    
    for ith_pose=1:table_size

        tmp_info = GT_time(ith_pose);
        x = GT_X(ith_pose);
        y = GT_Y(ith_pose);

        alpha = 1.5; % Acceptable near boundary (m)
        if( (x < grid_x + alpha) && (x > grid_x - alpha))
            if( (y < grid_y + alpha) && (y > grid_y - alpha))
                test_info = [test_info ; tmp_info];
                test_info_where = [test_info_where; ith_pose];
            end
        end

    end
    
    if( ~isempty(test_info) )
        %% 2-2 Find bins correspoding to the time at test_info
        search_time = test_info(1); % just simply take first one.
        found_bins = [];

        bin_list = strsplit(ls(bin_paths{ith_date}));

        len_bin_list = length(bin_list);
        thres = 500000; % 0.5 sec

        for ith_bin=1:len_bin_list

            query_name = bin_list{ith_bin};
            len_name = length(query_name);
            if(len_name > 16)    
                query_time = int64(str2double(query_name(1:16)));
                if( abs(query_time - search_time) < thres)
                    found_bins = [found_bins; query_name];
                end
            end    
        end

        if( ~isempty(found_bins) ) 
            %% 2-3 Save corresponding bins 
            % Set Path name 
            grid_name = strcat('[', int2str(grid_x), ',', int2str(grid_y), ']');
            day = dates{ith_date}; 
            save_training_full_path = strcat(parent_dir, '/', 'training/', grid_name, '/', day);

            % mkdir 
            if(~exist(save_training_full_path))
                mkdir(save_training_full_path);
            end

            % Save Nearest Bin 
            int64_bin_with_times = int64(str2num(found_bins(:,1:16)));
            search_time_vec = repmat(search_time, length(int64_bin_with_times),1);
            [c index] = min(abs(int64_bin_with_times - search_time_vec));
            name_saved_bin = strcat(bin_paths{ith_date},'/', found_bins(index,:));
            copyfile(name_saved_bin, save_training_full_path);
            
            % Save transformation information (body to global) 
            x_rot = GT_r(test_info_where(1)); % just simply take first one.
            y_rot = GT_p(test_info_where(1)); % just simply take first one.
            z_rot = GT_h(test_info_where(1)); % just simply take first one.
            tform = affine3d(makeTransformMarix(0, 0, 0, x_rot, y_rot, z_rot));

            save( strcat(save_training_full_path, '/tform.mat') , 'tform');
            
            
        end
    end
end
   
%%

end