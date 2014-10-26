### Programming Assignment 2 - Solution

This repository contains my solution to the seconf programming exercise for 
the Coursera, ["R Programming" course](https://class.coursera.org/rprog-008) by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD - 

The solution can be found in [cachematrix.R](./cachematrix.R)

### Testing the cached matrix
The first function, `makeCacheMatrix` creates a special "matrix", which is
really a list containing a function to

1.  set the value of the matrix
2.  get the value of the matrix
3.  set the value of the inverse
4.  get the value of the inverse

<!-- -->

    > source("cachematrix.R")
    > somematrix<-matrix(c(1,2,3,2,3,2,3,2,1),nrow=3)
    > mat<-makeCacheMatrix(somematrix)
    > cacheSolve(mat)

which should give output like:

           [,1] [,2]   [,3]
    [1,]  0.125 -0.5  0.625
    [2,] -0.500  1.0 -0.500
    [3,]  0.625 -0.5  0.125

running the cacheSolve line again:

    > cacheSolve(mat)
    
will give the same result but also show a message stating that the cached value was used:

    getting cached inverse
           [,1] [,2]   [,3]
    [1,]  0.125 -0.5  0.625
    [2,] -0.500  1.0 -0.500
    [3,]  0.625 -0.5  0.125
