% Set the seed value
seed = 14;
% Set the random number generator seed
rng(seed);

folderPath = 'Datasets/';

% Define the file names
file = 'a3.txt';
file2 = 'a3-ga.txt';

% Create the full file paths
filePath = fullfile(folderPath, file);
filePath2 = fullfile(folderPath, file2);

% Open the file for reading
fileID = fopen(filePath, 'r');

% Read the data using fscanf with appropriate format specifiers
data = fscanf(fileID, '%d %d', [2, Inf])';

[N,d]=size(data);

% Close the file
fclose(fileID);

% Open the file for reading
fileID2 = fopen(filePath2, 'r');

% Read the data using fscanf with appropriate format specifiers
data_classes = fscanf(fileID2, '%d', [1, Inf]);

% Close the file
fclose(fileID2);

% Extract the data into separate variables
x = data(:, 1);
y = data(:, 2);

K = 50;
error10 = Inf;
clusters = zeros(7500,1);
cluster_means = zeros(K,d);
for i=1:10
    [clusters10, cluster_means10] = KmeansPlus(data, K);
    error = KmeansError(data, clusters10, cluster_means10);
    if error < error10
        error10 = error;
        clusters = clusters10;
        cluster_means = cluster_means10;
    end
end


figure
hold on;
for k=1:K
    scatter(x(data_classes==k), y(data_classes==k),'b', 'filled', 'MarkerFaceColor', rand(1, 3));
end
 
box on
ax = gca;
ax.BoxStyle = 'full';
% exportgraphics(ax,['../', PATH_FIGURES,'/KmeansTrue.png'],'BackgroundColor','none');

figure
hold on;
for k=1:K
    scatter(x(clusters==k), y(clusters==k),'b', 'filled', 'MarkerFaceColor', rand(1, 3));
end
for k=1:K
    scatter(cluster_means(k,1), cluster_means(k,2), 100,'b', 'filled', 'MarkerFaceColor', "black", "Marker","pentagram");
end
box on
ax = gca;
ax.BoxStyle = 'full';
% exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans.png'],'BackgroundColor','none');

KmeansStats(clusters, data_classes)


klist = 2:75;
scores = zeros(length(klist),1);
errors = zeros(length(klist),1);
dist = get_distance_matrix(data);
for k=1:length(klist)
     [clusters, cluster_means] = KmeansPlus(data, klist(k));
     scores(k) = simp_silhouette_coefficient(data, clusters, cluster_means);
     errors(k) = KmeansError(data, clusters, cluster_means);
end
figure(2)
plot(klist, scores)
xlabel('K');
ylabel('Coeficient de silueta mitjà aproximat');
box on
ax = gca;
ax.BoxStyle = 'full';
hold off;
%exportgraphics(ax,['../', PATH_FIGURES,'/KNNsil.png'],'BackgroundColor','none');
 
figure(3)
plot(klist, errors)
xlabel('K');
ylabel('Cost');
box on
ax = gca;
ax.BoxStyle = 'full';
hold off;
% exportgraphics(ax,['../', PATH_FIGURES,'/KNNerrors.png'],'BackgroundColor','none');

 
% KmeansStats(clusters, data_classes)