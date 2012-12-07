function coefficient = bhattCoef(histA, histB)

coefficient = sum(sum(sum(sqrt(histA.*histB))));