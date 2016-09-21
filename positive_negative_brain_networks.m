for i=1:size(effective,1)
   display(i)
   A=reshape(effective(i,:,:), 116,116);
   
   %negative parts
   Aneg=A;
   Aneg(Aneg>0)=0; 
    
   for j=0:0.01:1
    temp = threshold_proportional(Aneg, j);
    temp(temp<0)=1;
    temp = sum(temp);
    
    if (sum(temp==0)<=1 && sum(temp>=10)==116)
        Aneg_threshold=threshold_proportional(Aneg, j);
        break;
    end
   end

   [scores, scores2, degrees] = actor_char_all_unnormalized(Aneg_threshold);
   [agg_scores, agg_scores2] = aggregate_wedges_triangles(scores, scores2);
        
   agg_matrix = [degrees, agg_scores2, agg_scores];
   corr_matrix = corr(agg_matrix, 'type', 'Pearson');

   correlation = corr_matrix;
   correlation(correlation<0.7)=0;
   anti_correlation = corr_matrix;
   anti_correlation(anti_correlation>-0.7)=0;
    
   wanted = correlation+anti_correlation;
   corr_matrix_all_neg(i,:,:)=wanted(:,:);
   agg_matrix_all_neg(i,:,:)=agg_matrix(:,:);
   save('corr_matrix_all_neg.mat');
   save('agg_matrix_all_neg.mat');
   
   %positive parts
   Apos=A;
   Apos(Apos<0)=0;
   
   for j=0:0.01:1
    temp = threshold_proportional(Apos, j);
    temp(temp>0)=1;
    temp = sum(temp);
    
    if (sum(temp==0)<=1 && sum(temp>=10)==116)
        Apos_threshold=threshold_proportional(Apos, j);
        break;
    end
   end

   [scores, scores2, degrees] = actor_char_all_unnormalized(Apos_threshold);
   [agg_scores, agg_scores2] = aggregate_wedges_triangles(scores, scores2);
        
   agg_matrix = [degrees, agg_scores2, agg_scores];
   corr_matrix = corr(agg_matrix, 'type', 'Pearson');

   correlation = corr_matrix;
   correlation(correlation<0.7)=0;
   anti_correlation = corr_matrix;
   anti_correlation(anti_correlation>-0.7)=0;
    
   wanted = correlation+anti_correlation;
   corr_matrix_all_pos(i,:,:)=wanted(:,:);
   agg_matrix_all_pos(i,:,:)=agg_matrix(:,:);
   save('corr_matrix_all_pos.mat');
   save('agg_matrix_all_pos.mat');
end

% negative parts
c = corr_matrix_all_neg;
c(c < 0) = -1;
c(c > 0) = 1;
c(isnan(c)) = 0; 
func_corr_subjects = reshape(sum(c)/40,16,16);
names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'win+', 'wout+', 'wrec', 'acyclic', 'cycles', 'out+', 'cycles+', 'in+', 'cycles++', 'rec'};
n=fliplr(names)
bb=rot90(func_corr_subjects);
HeatMap(bb, 'ColumnLabels', names, 'RowLabels', n, 'ColorMap', redbluecmap);

%positive parts
c = corr_matrix_all_pos;
c(c < 0) = -1;
c(c > 0) = 1;
c(isnan(c)) = 0; 
func_corr_subjects = reshape(sum(c)/40,16,16);
names = { 'd+', 'd-', 'do', 'wpath', 'win', 'wout', 'win+', 'wout+', 'wrec', 'acyclic', 'cycles', 'out+', 'cycles+', 'in+', 'cycles++', 'rec'};
n=fliplr(names);
bb=rot90(func_corr_subjects);
HeatMap(bb, 'ColumnLabels', names, 'RowLabels', n, 'ColorMap', redbluecmap);


