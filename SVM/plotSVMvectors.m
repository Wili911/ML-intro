function [] =  plotSVMvectors(points, w, b)
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
    % Plot the hyperplane as a line
    xRange = [-0.1,1.1];
    x = (xRange(1)-1):0.1:(xRange(2)+1);
    y = (-w(1) * x - b) / w(2);
    plot(x, y, 'k', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
    
    [~,i] = min(abs((w*class1' + b)/norm(w)));
    c = -class1(i,2)*w(2)-class1(i,1)*w(1);
    y = (-w(1) * x - c) / w(2);
    plot(x, y, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
    % Define the LaTeX-formatted text to display
    latexText = '$$x_a$$';    
    text(class1(i,1)+0.02, class1(i,2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');

    [~,i] = min(abs((w*class2' + b)/norm(w)));
    c = -class2(i,2)*w(2)-class2(i,1)*w(1);
    y = (-w(1) * x - c) / w(2);
    plot(x, y, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
    
    latexText = '$$x_b$$';    
    text(class2(8,1)+0.02, class2(8,2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');


    xlim(xRange)
    ylim([-0.1,1.1])
    grid off;
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []),
    hold off;