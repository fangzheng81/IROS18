function [ date_list, bin_path_list, pose_path_list ] = ParsePathOfAllDays( parent_dir )


% parent_dir= '/media/gskim/Data/NCLT';
ls_cell = strsplit(ls(parent_dir)); %ex: '/media/gskim/Data/NCLT'

ls
bin_path_list = {}; 
pose_path_list = {}; 

insert_index = 1;

for i=1:length(ls_cell)
    
    tmp_date = ls_cell{i};

    if(~isempty(tmp_date))
        if( strcmp('2012', tmp_date(1:4)) || strcmp('2013', tmp_date(1:4))) % only for bin directories (2012~)
            tmp_bin_full = strcat(tmp_date, '/velodyne_sync');   
            tmp_pose_full = strcat(tmp_date, '/groundtruth_', tmp_date, '.csv');

            bin_path_list{insert_index} = strcat(parent_dir, '/', tmp_bin_full);
            pose_path_list{insert_index} = strcat(parent_dir, '/', tmp_pose_full);
            date_list{insert_index} = tmp_date;
            
            insert_index = insert_index+1;
        end
    end    
end

end

