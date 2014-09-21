set.seed(13435)

X <- data.frame("var1" = sample(1:5),
                "var2" = sample(6:10),
                "var3" = sample(11:15))
X <- X[sample(1:5), ]
X$var2[c(1,3)] = NA

## Subset rows with var1 <=3 AND var3 > 11
X[(X$var1 <= 3 & X$var3 > 11), ]

## Subset rows where var2 > 8 and omit NAs
X[which(X$var2 > 8), ] ## Compare to X[(X$var2 > 8), ]

## Sort var2 column, descending order and put NAs last
sort(X$var2, na.last = T, decreasing = T)

## Sort X by order of var1 and var3
X[order(X$var1, X$var3), ]


library(plyr)

## Sort X by order of var1 with PLYR
arrange(X, var1)
arrange(X, desc(var1))

## Add a column named var4
X$var4 <- rnorm(5)

## Do the same with cbind and save into a new data frame
Y <- cbind(X, rnorm(5))

