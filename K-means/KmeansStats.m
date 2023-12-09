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
                    FN = FN + 1;
                else
                    TN = TN + 1;
                end
            end
        end
    end
    fprintf('-----------------\n');
    fprintf('| P | %2d | %2d  |\n', TP, FP);
    fprintf('| N | %2d | %2d  |\n', FN, TN);
    RI = (TP + TN) / (N*(N-1)/2);
    fprintf('RI = %2d\n',RI)
    P = TP / (TP + FP);
    fprintf('Precissió = %2d\n',P)
    R = TP / (TP + FN);
    fprintf('Reclam = %2d\n',R)
    
    values = [TP, FN; FP, TN];

    % Normalize the data to range [0, 1] for colormap intensity
    disp(values)
    % Create a heatmap-like visualization using imagesc with transparency
    clf
    figure(1)
    h = heatmap(values);
    h.ColorScaling = 'log';
    h.XDisplayLabels([1,2]) = {''}; % replace rejected tick labels with empties    %imshow(normalizedValues, cmap)
    h.YDisplayLabels([1,2]) = {''}; % replace rejected tick labels with empties    %imshow(normalizedValues, cmap)
    ax = gca;
    ax.FontSize = 16;
    % exportgraphics(ax,['../', PATH_FIGURES,'/KmeansConfus.png']);

    
    
    

