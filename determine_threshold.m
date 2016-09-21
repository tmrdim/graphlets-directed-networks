load('./data/effective/effective_all.mat');

wanted = zeros(40,1);
k=1;
for i=1:size(effective,1)
    display(i)
   
   for j=0:0.01:1
    temp = threshold_proportional(reshape(effective(i,:,:), 116,116), j);
    temp(temp>0)=1;
    temp = sum(temp);
    
    if (sum(temp==0)<=1 && sum(temp>=10)==116)
        wanted(i) = j;
        eff(i,:,:)=threshold_proportional(reshape(effective(i,:,:), 116,116), j);
        break;
    end
   end
end

