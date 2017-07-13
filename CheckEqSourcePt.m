function [errmsg] = CheckEqSourcePt(x, xg)
%CHECKEQSOURCEPT Summary of this function goes here
%   Detailed explanation goes here
% Flatten grid xg
xf = cell(1,0);
for i=1:numel(xg)
    temp = xg{i};
    if iscell(x)
        xf = [xf, temp];
    else
        xf = [xf,{temp}];
    end
end

% Check for equal source points along dimensions
p = numel(xf);
Dg = zeros(p,1);
ng = zeros(p,1);

for j=1:p
    [ng(j), Dg(j)] = size(xf{j});
end

for k=1:p
    xt = xf{i};
    it = find(abs(xt(2,:)-xt(1,:)));
    [s, ord] = sort(xt(:,it));
    ds = diff(s);
    if min(ds)<1e-10
        errmsg = 'Some source points are equal.';
        return
    end
end

errmsg = [];
end

