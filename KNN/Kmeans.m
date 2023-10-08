function [clusters, cluster_means] = Kmeans(points, K) 
    % points: N x 2
    N = length(points);

    % Define the ranges for the x and y coordinates
    A = min(points(:,1));
    B = max(points(:,1));
    C = min(points(:,2));
    D = max(points(:,2));
    
    % Generate random x and y coordinates within the specified ranges
    x = (B - A) * rand(K, 1) + A;
    y = (D - C) * rand(K, 1) + C;
    
    % Create a matrix of the generated points
    cluster_means = [x, y];
    clusters = zeros(N,1);

    for i=1:1000
        for j=1:N
            [~,index] = min(vecnorm(points(j,:)-cluster_means,2,2));
            clusters(j) = index;
        end
        upd_cluster_means = zeros(K,2);
        for k=1:K
            kpoints = points(clusters==k,:);
            if ~isempty(kpoints)
                upd_cluster_means(k,:) = mean(kpoints);
            else
                upd_cluster_means(k,:) = [0,0];
            end
        end

        if norm(upd_cluster_means-cluster_means) < 1e-6
            break
        end
        cluster_means = upd_cluster_means;
    end
    
    
