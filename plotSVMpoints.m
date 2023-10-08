function [] =  plotSVMpoints(points, w, b)
    if isempty(points)
        print("La llista de punts introduïda és buida.")
        return
    end

    % Classifica els punts
    [~, class1, class2] = classifyPoints(w, b, points);

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
    xlim(xRange)
    ylim([-0.1,1.1])
    grid off;
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    hold off;