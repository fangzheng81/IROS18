function [ raw_data ] = ReadSingleBin( path )

%% for test 
% path = '/media/gskim/Data/NCLT/training/[-310,-455]/2012-01-15/1326655085179636.bin';

%% main 
fid = fopen(path, 'r');
raw_data = fread(fid, '*uint16', 'ieee-le'); % for NCLT dastaset
fclose(fid);

end

