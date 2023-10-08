function [] =  plotSVM(points, w, b)
    if isempty(points)
        print("La llista de punts introduïda és buida.")
        return
    end

    % Classifica els punts
    [points_classes, class1, class2] = classifyPoints(w, b, points);

    % Plot the points with different colors for each class
    figure;
    if ~isempty(class1)
        scatter(class1(:, 1), class1(:, 2), 'r', 'filled', 'DisplayName', 'Classe 1');
    end
        hold on;
    if ~isempty(class2)
        scatter(class2(:, 1), class2(:, 2), 'b', 'filled', 'DisplayName', 'Classe 2');
    end

    xRange = [-0.1,1.1];
    x = (xRange(1)-1):0.1:(xRange(2)+1);
    y = (-w(1) * x - b) / w(2);
    plot(x, y, 'k', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
    
    for i=1:length(points)
        if abs(w * points(i,:)' +b -points_classes(i)) < 1e-5
            disp(i)
            c = -points(i,2)*w(2)-points(i,1)*w(1);
            y = (-w(1) * x - c) / w(2);
            plot(x, y, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
        end
    end

    xlim(xRange)
    ylim([-0.1,1.1])
    grid off;
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);

    hold off;