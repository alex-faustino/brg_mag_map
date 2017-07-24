function [ index ] = find_closest_index( L_t, t )
%   Input:
%           L_t: a list of time
%            t  : time to be find
%   Output:
%           index: the index in L_t which is the closest to t

[~, index] = min(abs(L_t - t));


end

