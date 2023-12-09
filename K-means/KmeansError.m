function [error] = KmeansError(points, clusters, cluster_means)
    error = 0;    
    for i=1:length(points)
        error = error + (vecnorm(points(i,:)-cluster_means(clusters(i),:),2,2));
    end
    error = error / length(points);