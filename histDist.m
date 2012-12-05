% histA and histB should be normalized

function dist = histDist(histA, histB, type)
dist = -1;
if strcmp(type, 'eucl')
   dist = sqrt(sum(sum(sum( (histA - histB).^2 ))));
elseif strcmp(type, 'batt')
   coefficient = sum(sum(sum(sqrt(histA.*histB))));
   dist = sqrt(1-coefficient);
end