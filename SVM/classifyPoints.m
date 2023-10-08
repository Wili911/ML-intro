function [points_class, class1, class2] = classifyPoints(w, b, points)
    % Initialize empty lists
    points_class = [];
    class1 = [];
    class2 = [];

    % Iterate through each point in the input list
    for i = 1:size(points, 1)
        point = points(i, :);
        
        % Calculate the value of the hyperplane equation for the point
        hyperplane_value = w * point' + b;
        
        % Classify the point into one of the two classes
        if hyperplane_value >= 0
            class1 = [class1; point];
            points_class = [points_class; 1];
        else
            class2 = [class2; point];
            points_class = [points_class; -1];
        end
    end
end
