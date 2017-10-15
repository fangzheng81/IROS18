function [ time, x, y, z, r, p, h ] = ReadGTcsv( date )

if isunix 
    parent_path = 'data/NCLT-campus/pose/';
    full_path = strcat(parent_path, date, '/', 'groundtruth_', date(1:4), '-', date(5:6), '-', date(7:8), '.csv');
elseif ispc
    parent_path = 'data\\NCLT-campus\\pose\\';
    full_path = strcat(parent_path, date, '\\', 'groundtruth_', date(1:4), '-', date(5:6), '-', date(7:8), '.csv');
end








end



