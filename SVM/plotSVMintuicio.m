function [] =  plotSVMintuicio(points, w, b)
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
    % Plot the hyperplane as a line
    xRange = [-0.1,1.1];
    x = (xRange(1)-1):0.1:(xRange(2)+1);
    y = (-w(1) * x - b) / w(2);
    plot(x, y, 'k', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
    
    
    % Draw perp lines
    plot_points = [1,6];
    colors = ['r','b'];
    for it=1:length(plot_points)
        point1 = points(plot_points(it),:);
        point2 = projection(point1, w, b);
        if points_classes(plot_points(it)) == 1
            color = colors(1);
        else
            color = colors(2);
        end
        plot([point1(1), point2(1)], [point1(2), point2(2)], color, 'LineWidth', 1);
    end
    % Define the LaTeX-formatted text to display
     latexText = '$$x_a$$';    
     text(points(plot_points(1),1)+0.02, points(plot_points(1),2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');
     
     latexText = '$$x_b$$';    
     text(points(plot_points(2),1)+0.015, points(plot_points(2),2)-0.02, latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');

    xlim(xRange)
    ylim([-0.1,1.1])
    grid off;
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    hold off;