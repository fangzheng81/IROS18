function [ isovist ] = ComputeIsovistFromPie( ptcloud_in_pie )

if(isempty(ptcloud_in_pie))
    isovist = 100; % for test 
else
    %% ver 20171008: (for Test) Maximum distance on xy plane 
    x_far = max( abs(ptcloud_in_pie.XLimits(1)), abs(ptcloud_in_pie.XLimits(2)));
    y_far = max( abs(ptcloud_in_pie.YLimits(1)), abs(ptcloud_in_pie.YLimits(2)));    
    isovist = sqrt(x_far^2 + y_far^2);
    if(isovist > 80)
        isovist = 80;
    end       
    %% ver 20171011 (prof said): w+h 
    
    
    
    
    
    %% ver 201710:
    
    
    
    
    
    %% TBA ...

    
end

end

