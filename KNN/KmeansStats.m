function [] = KmeansStats(pclasses,classes)
    N = length(pclasses);
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    for i=1:N-1
        for j=i+1:N
            positive = pclasses(i)==pclasses(j);
            isTrue = classes(i)==classes(j);
            if positive
                if isTrue
                    TP = TP + 1;
                else
                    FP = FP + 1;
                end
            else
                if isTrue
                    TN = TN + 1;
                else
                    FN = FN + 1;
                end
            end
        end
    end
    fprintf('-----------------\n');
    fprintf('| T | F |       |\n');
    fprintf('-----------------\n');
    fprintf('| P | %2d | %2d  |\n', TP, FP);
    fprintf('| N | %2d | %2d  |\n', TN, FN);
    fprintf('-----------------\n');
    RI = (TP + TN) / (N*(N-1)/2);
    fprintf('RI = %2d\n',RI)
    P = TP / (TP + FP);
    fprintf('Precissió = %2d\n',P)
    R = TP / (TP + FN);
    fprintf('Reclam = %2d\n',R)
    
    values = [TP, FP; TN, FN];

    % Normalize the data to range [0, 1] for colormap intensity
    normalizedValues = 1 - log(values) / (N*(N-1)/2);
        
    % Create a heatmap-like visualization using imagesc with transparency
    figure(2);
    imshow(normalizedValues, [])
    % Set axis labels and title
    axis on
    ax = gca;
    ax.FontSize = 30; 
    xticks([1, 2]);
    yticks([1, 2]);
    xticklabels({'T', 'F'});
    yticklabels({'P', 'N'});
    
    % Add text annotations with actual values in each cell
    for i = 1:size(values, 1)
        for j = 1:size(values, 2)
            text(j, i, num2str(values(i, j)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 20, 'FontWeight', 'bold', 'Color', 'red');
        end
    end

    
    
    
    

