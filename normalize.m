function normMatrix = normalize(matrix)

dimensions = length(size(matrix));
sumMatrix = matrix;
for i=1:dimensions
    sumMatrix = sum(sumMatrix);
end

normMatrix = matrix./sumMatrix;