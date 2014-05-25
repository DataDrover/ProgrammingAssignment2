### Introduction

This code is based on a fork from:
 https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)

makeCacheMatrix and cacheSolve exploit R function closures to cache results
of matrix inversion. Inversion is performed by feeding a matrix as the 
## sole argument to solve(). Solve 

Usage:  1 Create a special matrix by feeding an ordinary matrix to makeCacheMatrix.
        2 Call cacheSolve on the result of 1.
        3  Subsequent calls to cacheSolve will return a cached result

User note:
    These funcions are not vectorized. That means that they only work with a single
    matrix argumemt.

Assumptions:
    1  The initial argument is an invertable matrix. Otherwise,
         behaviour is undefined.
    2  cacheSolve does not check whether the special matrix created by
        makeCacheMatrix has been changed externally (eg by a call on the set method).
         This is unlikely in normal use, but if there is a risk of it happening, 
         check with all(sm.get() == a) before calling cachSolve. If all returns FALSE,
         create a new special array with makeCacheMatrix.

Simple testing:
     The integrity of the output can be tested by reinverting it and comparing the
     result with the original matrix. eg: all(a == c).
     Check that repeat calls use the cached result.


### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

