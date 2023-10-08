function [clusters, cluster_means] = KmeansPlus(points, K) 
    % points: N x 2
    N = length(points);


    % Generate random x and y coordinates within the specified ranges
    cluster_means = points(randi([1, N]),:);
    clusters = zeros(N,1);

    for i=2:K
        % Build probabilities
        dist_map = zeros(N,1);
        for j=1:N
            [dist,index] = min(vecnorm(points(j,:)-cluster_means,2,2));
            dist_map(j) = dist;
            if clusters(j) ~= index
                clusters(j) = index;
            end
        end
        % Compute distribution
        dist_map = dist_map.^2;
        dist_map = dist_map / sum(dist_map);
        index = find(rand <= cumsum(dist_map), 1, 'first');
        cluster_means = [cluster_means; points(index,1:2)];
    end

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
            end
        end
        if norm(upd_cluster_means-cluster_means) < 1e-6
            break
        end
        cluster_means = upd_cluster_means;
    end
    