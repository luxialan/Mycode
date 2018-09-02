A cancer dataset has been deidentified, recoded, and contained in “recoded data.txt”.
Consider for example the first row: [1,] 4.103  2.177 NA 0.808
[1,] is apparently useless; the first variable (4.103) is the response variable and continuously distributed; the rest three (2.177 NA 0.808) are covariates and potentially associated with the response variable. Among the three covariates, the first and third are continuously distributed, and the second is binary and may contain missing values.
