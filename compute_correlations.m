%% compute significat correlations between subjects
for i=1:size(eff,1)
    disp(i);
    A = reshape(eff(i,:,:), 116,116);
    
    [scores, scores2, degrees] = actor_char_all_unnormalized(A);
    [agg_scores, agg_scores2] = aggregate_wedges_triangles(scores, scores2);
        
    agg_matrix = [degrees, agg_scores2, agg_scores];
    corr_matrix = corr(agg_matrix, 'type', 'Pearson');

    correlation = corr_matrix;
    correlation(correlation<0.7)=0;
    anti_correlation = corr_matrix;
    anti_correlation(anti_correlation>-0.7)=0;
    
    wanted = correlation+anti_correlation;
    corr_matrix_all(i,:,:)=wanted(:,:);
    agg_matrix_all(i,:,:)=agg_matrix(:,:);
%     agg_matrix_norm_all(i,:,:)=agg_matrix_norm(:,:);
%     
%     wanted=wanted';
    names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'win+', 'wout+', 'wrec', 'acyclic', 'cycles', 'out+', 'cycles+', 'in+', 'cycles++', 'rec' };
    HeatMap(wanted, 'ColumnLabels', names, 'RowLabels', names, 'ColorMap', redbluecmap);
    
end

save('corr_matrix_all.mat');
save('agg_matrix_all.mat');
%% normalize degrees
for i=1:40
    agg_matrix=reshape(agg_matrix_all(i,:,:), 116,16);
    
    triangles=agg_matrix(:,1:7);
    wedges=agg_matrix(:,8:13);
    deg=agg_matrix(:,14:16);
    feature_vector(i,:,:)=[deg, wedges, triangles];
    
    for j=1:116
       triangles(j,:)=triangles(j,:)/sum(triangles(j,:));
       wedges(j,:)=wedges(j,:)/sum(wedges(j,:));
       deg(j,:)=deg(j,:)/sum(deg(j,:));
    end
    norm_feature_vector(i,:,:)=[deg, wedges, triangles];
    
end

save('feature_vector.mat');
save('norm_feature_vector.mat');


%% check belonging to same cluster

regions = zeros(116,116);
for i=1:40
   A = reshape(norm_feature_vector(i,:,:),116,16);
   Y = pdist(A);
   Z = linkage(Y,'ward'); 
%    T = cluster(Z,'cutoff',1.2,'criterion','distance');
   T = cluster(Z,'maxclust',3)
   clusters(i)=max(T);
   for j=1:116
       for k=j:116
        if (T(j) == T(k)) 
            regions(j,k) = regions(j,k) + 1;
        end
       end
   end
   
end
regions(regions<24)=0;
HeatMap(regions, 'ColumnLabels', [1:1:116], 'RowLabels', [1:1:116], 'ColorMap', redbluecmap);

%% draw correlation matrix for all subjects
c = corr_matrix_all;
c(c < 0) = -1;
c(c > 0) = 1;
c(isnan(c)) = 0; 
func_corr_subjects = reshape(sum(c)/39,16,16);
names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'winplus', 'woutplus', 'wrec', 'acyclic', 'cycles', 'outplus', 'cyclesplus', 'inplus', 'cycles2plus', 'recip'};
n=fliplr(names)
bb=rot90(func_corr_subjects);
HeatMap(bb, 'ColumnLabels', names, 'RowLabels', n, 'ColorMap', redbluecmap);

Dpos = corr_matrix_all;

%% draw only positive correlation matrix for all subjects
Dpos(Dpos > 0) = 1;
Dpos(Dpos < 0) = 0;
Dpos(isnan(Dpos)) = 0;
func_corr_subjects = reshape(sum(Dpos),16,16);
names = { 'acyclic', 'cycles', 'outplus', 'cyclesplus', 'inplus', 'cycles2plus', 'recip', 'wpath', 'win', 'wout', 'winplus', 'woutplus', 'wrec', 'd+', 'd-', 'do'};
HeatMap(func_corr_subjects, 'ColumnLabels', names, 'RowLabels', names, 'ColorMap', redbluecmap);

%% draw only negative correlation matrix for all subjects
Dneg = corr_matrix_all;
Dneg(Dneg < 0) = -1;
Dneg(Dneg > 0) = 0;
Dneg(isnan(Dneg)) = 0;
func_corr_subjects = reshape(sum(Dneg),16,16);
names = { 'acyclic', 'cycles', 'outplus', 'cyclesplus', 'inplus', 'cycles2plus', 'recip', 'wpath', 'win', 'wout', 'winplus', 'woutplus', 'wrec', 'd1', 'd2', 'd3'};
HeatMap(func_corr_subjects, 'ColumnLabels', names, 'RowLabels', names, 'ColorMap', redbluecmap);

%%
for i=31:40
    corr=reshape(corr_matrix_all(i,:,:),16,16);
    names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'win+', 'wout+', 'wrec', 'acyclic', 'cycles', 'out+', 'cycles+', 'in+', 'cycles++', 'rec'};
    n=fliplr(names)
    bb=rot90(corr);
    HeatMap(bb, 'ColumnLabels', names, 'RowLabels', n, 'ColorMap', redbluecmap);
end
 corr=reshape(corr_matrix_all(1,:,:),16,16);
    names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'win+', 'wout+', 'wrec', 'acyclic', 'cycles', 'out+', 'cycles+', 'in+', 'cycles++', 'rec'};
    n=fliplr(names)
    bb=rot90(corr);
    HeatMap(bb, 'ColumnLabels', names, 'RowLabels', n, 'ColorMap', redbluecmap);
