function [w, b, xi] = trainSoftSVM(points, points_classes, C)
% points n x 2
% points_classes n x 1
    [n, d] = size(points);
    %
    H = zeros(n+d+1);
    H(1:d,1:d) = ones(d);
    %
    f = [zeros(1,d), C*ones(1,n), 0];
    %
    bpoints = points_classes .* [points ones(n,1)];
    bpoints = [bpoints eye(n)];
    B = -ones(n,1);
    A = -bpoints;
    lb = [-Inf * ones(1,d+1) zeros(1,n)];
    x = quadprog(H,f,A,B,[],[],lb);
    w = x(1:d)';
    b = x(d+1);
    xi = x(d+2:end)';
