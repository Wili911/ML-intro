% Set the seed value
seed = 14;
% Set the random number generator seed
rng(seed);

folderPath = 'Datasets/';

% Define the file names
file = 'mall_customers.csv';

% Create the full file paths
filePath = fullfile(folderPath, file);

% Read the data using fscanf with appropriate format specifiers
data = readtable(filePath);

% Extract the data into separate variables
data = table2array(data(:,{'age','annual_income', 'spending_score'}));

% labels = {'age','annual_income', 'spending_score'};
x = data(:,1);
y = data(:,2);
z = data(:,3);

% klist = 2:10;
% scores = zeros(length(klist),1);
% errors = zeros(length(klist),1);
% dist = get_distance_matrix(data);
%  for k=1:length(klist)
%     [clusters, cluster_means] = KmeansPlus(data, klist(k));
%     scores(k) = silhouette_coefficient(data, clusters, dist);
%     errors(k) = KmeansError(data, clusters, cluster_means);
% end
% figure(1)
% plot(klist, scores)
% xlabel('K');
% ylabel('Coeficient de silueta mitjà');
% box on
% ax = gca;
% ax.BoxStyle = 'full';
% hold off;
% exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans_mallsil.png'],'BackgroundColor','none');
% 
% figure(2)
% plot(klist, errors)
% xlabel('K');
% ylabel('Cost');
% box on
% ax = gca;
% ax.BoxStyle = 'full';
% hold off;
% exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans_mallscore.png'],'BackgroundColor','none');
% 


% Find best of 10 inicializations for K
K = 5;
error10 = Inf;
clusters = zeros(7500,1);
cluster_means = zeros(K,3);
for i=1:100
    [clusters10, cluster_means10] = KmeansPlus(data, K);
    error = KmeansError(data, clusters10, cluster_means10);
    if error < error10
        error10 = error;
        clusters = clusters10;
        cluster_means = cluster_means10;
    end
end

colors = rand(K, 3);
clf
figure(3)
hold on;
for k=1:K
    scatter(x(clusters==k), z(clusters==k),50,'b', 'MarkerFaceColor', colors(k,:));
end
for k=1:K
    scatter(cluster_means(k,1), cluster_means(k,3),150,'b','filled', 'MarkerFaceColor', 'black', 'Marker', 'pentagram');
end
box on
ax = gca;
ax.BoxStyle = 'full';

xlabel('Edat')
ylabel('Puntuació de despeses')
exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans_mallG1.png'],'BackgroundColor', 'none');


figure(4)
hold on;
for k=1:K
    scatter(y(clusters==k), z(clusters==k),50,'b', 'MarkerFaceColor', colors(k,:));
end
for k=1:K
    scatter(cluster_means(k,2), cluster_means(k,3), 150,'b', 'filled', 'MarkerFaceColor', "black", 'Marker', 'pentagram');
end
box on
ax = gca;
ax.BoxStyle = 'full';
xlabel('Ingressos anuals')
ylabel('Puntuació de despeses')
exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans_mallG2.png'],'BackgroundColor','none');

figure(5)
hold on;
for k=1:K
    scatter(x(clusters==k), y(clusters==k),50,'b', 'MarkerFaceColor', colors(k,:));
end
for k=1:K
    scatter(cluster_means(k,1), cluster_means(k,2), 150,'b', 'filled', 'MarkerFaceColor', "black", 'Marker', 'pentagram');
end
box on
ax = gca;
ax.BoxStyle = 'full';
xlabel('Edat')
ylabel('Ingressos anuals')
exportgraphics(ax,['../', PATH_FIGURES,'/Kmeans_mallG3.png'],'BackgroundColor','none');

