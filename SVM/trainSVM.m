function [w, b] = trainSVM(points, points_classes)
% points n x 2
% points_classes n x 1
    [n, d] = size(points);
    H = eye(d+1);
    H(end,end) = 0;
    f = zeros(1,d+1);
    bpoints = [points ones(n,1)];
    B = -ones(n,1);
    A = -bpoints .* points_classes;
    options = optimoptions('quadprog','Display','off');
    x = quadprog(H,f,A,B,[],[],[],[],[],options);
    w = x(1:d)';
    b = x(end);


