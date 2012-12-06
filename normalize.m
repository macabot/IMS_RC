% Richard Rozeboom (6173292) and Michael Cabot (6047262)

function normMatrix = normalize(matrix)
sumMatrix = sum(matrix(:)); % sum all elements
normMatrix = matrix./sumMatrix;