function [] =  plotSoftSVM(points,points_classes, class1, class2, w, b, xi)
    if isempty(points)
        print("La llista de punts introduïda és buida.")
        return
    end

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
    
    for i=1:length(class1)
        if abs(w * class1(i,:)' +b -1) < 1e-5
            c = -class1(i,2)*w(2)-class1(i,1)*w(1);
            y1 = (-w(1) * x - c) / w(2);
            plot(x, y1, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
        end
    end
    for i=1:length(class2)
        if abs(w * class2(i,:)' +b +1) < 1e-5
            c = -class2(i,2)*w(2)-class2(i,1)*w(1);
            y2 = (-w(1) * x - c) / w(2);
            plot(x, y2, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Hiperpla');
            latexText = '$$x_1$$';    
            text(class2(i,1)+0.02, class2(i,2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');
            break
        end
    end
    fill([x, fliplr(x)], [y1, fliplr(y2)], 'b', 'FaceAlpha', 0.06);
    
    i = 19;
    latexText = '$$x_2$$';    
    text(points(i,1)+0.02, points(i,2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');
    
    % Define the LaTeX-formatted text to display
    latexText = '$$x_3$$';    
    text(points(7,1)+0.02, points(7,2), latexText, 'Interpreter', 'latex', 'FontSize', 14, 'Color', 'black');


    xlim(xRange)
    ylim([-0.1,1.1])
    grid off;
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    %saveas(gcf, ['../', 'TFG latex documents/Figs','/SVMSoftVectors.png']);
    hold off;