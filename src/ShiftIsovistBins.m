function [ reordered_isovist ] = ShiftIsovistBins( isovist, N )

len = length(isovist);

reordered_isovist = isovist;

for i=1:len
    shift = mod(i+N, len);
    if (shift == 0)
        shift = len;
    end
%     disp(i)
    reordered_isovist(shift) = isovist(i);
end

end

