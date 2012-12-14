function dist = distance(a, b, type)

if strcmp(type, 'eucl') % euclidian distance
   dist = sqrt(sum((a-b).^2)); 
end