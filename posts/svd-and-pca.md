---
title: "SVD and PCA"
date: 2019-05-27 19:00
has_math: true
---

This is a two-part post, with some notes I wrote while refreshing the concepts
of SVD and PCA.

- [Part 1 - SVD](#singular-value-decomposition)
- [Part 2 - PCA](#pca)


# Singular Value Decomposition

- Take any matrix $A$. Generally speaking, what it does to a vector $\vec{x}$ 
is stretch it and rotate it.

- Now let's consider what a matrix $A$ does to a unitary circle:

![](/images/matrix-multiplication.png){ width=80% }

- The orthonormal vectors $\vec{v_1}$ and $\vec{v_2}$ were rotated into
the orthonormal vectors $\vec{u_1}$ and $\vec{u_2}$ and scaled by some
constants, $\sigma_1$ and $\sigma_2$
- This is equivalent to saying $AV = U\Sigma$, where $V$ has the vectors 
$\vec{v}$ in its columns, and $U$ has the vectors $\vec{u}$ in its columns.

\begin{align*}
AV &= \hat{U}\hat{\Sigma} \\
A &= \hat{U}\hat{\Sigma} V^*
\end{align*}

(Becaue $V$ is orthonormal, its inverse is the same as its tranpose)

This is called the reduced Singular Value Decomposition. More visually:

$$
\underbrace{\begin{bmatrix}
& & \\
& A &\\
& & \\
\end{bmatrix}}_{(m\times n)}
\
\underbrace{\begin{bmatrix}
\vert & \vert & & \vert\\
\vec{v_1} & \vec{v_2} & ... & \vec{v_n}\\
\vert & \vert & & \vert\\
\end{bmatrix}}_{(n\times n)} =
\
\underbrace{\begin{bmatrix}
\vert & \vert & & \vert\\
\vec{u_1} & \vec{u_2} & ... & \vec{v_m}\\
\vert & \vert & & \vert\\
\end{bmatrix}}_{(m\times n)}
\
\underbrace{\begin{bmatrix}
\sigma_1 & & \\
& \ddots & \\
& & \sigma_n \\
\end{bmatrix}}_{(n\times n)}
$$

Equivalently:

$$
\underbrace{\begin{bmatrix}
& & \\
& & \\
& A &\\
& & \\
& & \\
\end{bmatrix}}_{(m\times n)} = 
\
\underbrace{\begin{bmatrix}
& & \\
& & \\
& \hat{U} &\\
& & \\
& & \\
\end{bmatrix}}_{(m\times n)}
\
\underbrace{\begin{bmatrix}
\ & & \\
\ & \hat{\Sigma} &\\
\ & & \\
\end{bmatrix}}_{(n\times n)}
\
\underbrace{\begin{bmatrix}
& & \\
& V^* &\\
& & \\
\end{bmatrix}}_{(n\times n)}
$$

Since $\hat{U}$ is underdetermined, normally we work with:

\begin{align*}
\underbrace{\begin{bmatrix}
& & \\
& & \\
& A &\\
& & \\
& & \\
\end{bmatrix}}_{(m\times n)} = 
\
\underbrace{
\left[
\begin{array}{c c c|c c}
& & & & \\
& & & & \\
& \hat{U} & & &\\
& & & & \\
& & & & \\
\end{array}
\right]
}_{\stackrel{\mathbf U}{(m\times m)}}
\
\underbrace{\begin{bmatrix}
\ & & \\
\ & \hat{\Sigma} &\\
\ & & \\
\hline
\ 0 & ...  & 0 \\
\ 0 & ... & 0 \\
\end{bmatrix}}_{\stackrel{\mathbf\Sigma}{(m\times n)}}
\
\underbrace{\begin{bmatrix}
& & \\
& V^* &\\
& & \\
\end{bmatrix}}_{(n\times n)}
\end{align*}

I.e., $U$ is obtained by adding $(m-n)$ orthonormal columns to $\hat U$, and
$\Sigma$ is obtained by adding $(m-n)$ rows of zeros to $\hat\Sigma$

Computing the SVD, boils down to finding the eigendecompositions of $AA^T$ and
$A^T A$. The eigenvectors of $AA^T$ are $U$, and the eigenvectors of $A^T A$ are
$V$. The eigenvalues of both $AA^T$ and $A^T A$ are the squares of the singular
values!
___

# PCA

Let $X$ be a (centered) $m \times n$ data matrix. Then $\frac{1}{n-1}XX^T$ is 
the corresponding covariance matrix.

If there are non-zero off-diagonal values in the covariance matrix, that means
that the coordinates we picked have some redundancy. Let this notion sink in.
There are many ways to think about this, but it all boils down to the fact that,
if there are non-zero off-diagonal values in the cov. matrix, then the
coordinates we're using are not orthogonal.

Why does this matter? Because if we have orthogonal coordinates, we know that
these are the directions of greates variation (hence "Principal Components"),
and in a lucky scenario, we might even find that we need less dimensions to
represent the data at hand. (For an excelent example of this, and a lecture
much better than my notes, check 
[this video](https://www.youtube.com/watch?v=a9jdQGybYmE) by Prof. J. Nathan
Kutz)

**PCA's goal**: Find a coordinate system where the covariance matrix is
diagonal.

### Approach 1

$XX^T$ is square and symmetric. It is possible to do eigendecomposition on it:

\begin{align*}
XX^T = S \Lambda S^{-1}
\end{align*}

Now take the following transformation: $Y = S^T X$. Recall that the columns of
$S$ are orthogonal, so $S^T = S^{-1}$. Then, the covariance matrix in the new 
space is:

\begin{align*}
\frac{1}{n-1} YY^T &=  \frac{1}{n-1} S^T XX^T S \\
&= \frac{1}{n-1} S^T S \Lambda S^{-1} S \\
&= \frac{1}{n-1} \Lambda
\end{align*}

And we know $\Lambda$ is diagonal, so we successfully found a coordinate
transform where off-diagonal values of the covariance matrix are 0, hence
minimizing redundancy.

Remember: to obtain $Y$, we hit $X$ with $S^T$. What's the interpretation of
this?

- If $Y = S^T X$, then $X = SY$, 
- which means that to "translate" from $Y$ to $X$ we use $S$ as our
change-of-basis matrix.
- Conversely, doing $Y = S^T X$,
translates $X$ into the column-space of $S$. 
- And the columns of $S$ are the eigenvectors of $XX^T$!

So, in summary, the coordinate system in which redundancy is minimized is 
precisely the one given by the eigenvectors of $XX^T$!

(Speaking of redundancy, this last chunk is a good example of that, but
writing it down like that does help consolidate things)

### Approach 2

Same setting, but let's use the two following points:

- $X = U\Sigma V^*$
- $Y = U^* X$

In this case, the covariance matrix in the $Y$ space is:

\begin{align*}
\frac{1}{n-1} YY^T &= \frac{1}{n-1} (U^* X)(U^* X)^T \\
&= \frac{1}{n-1} (U^* X)(X^* U)\\
&= \frac{1}{n-1} U^* (X)(X^*) U\\
&= \frac{1}{n-1} U^* (U\Sigma V^*)(V \Sigma^T U^*) U \\
&= \frac{1}{n-1} (U^*U) \Sigma (V^*V) \Sigma^T (U^* U) \\
&= \frac{1}{n-1} \Sigma\Sigma^T
\end{align*}

Where I've repeated some of the steps with the parenthesis in different
locations, to make things clearer. 

You can easily see that $\Sigma * \Sigma^T$ is diagonal (its last $(m-n)$
diagonal elements are going to be zero).

Again, what's the meaning of this? Following the same rationale, we're saying
that $U^*$ is a change-of-basis matrix that takes us to a space where the
covariance matrix is diagonal. If you paid attention, you'll notice that the
columns of $U$ are precisely the eigenvectors of $XX^T$ - the coordinate system
we arrived at, in the previous section. So there's the connection between the
two approaches. (You could have guessed it by the fact that we normally think
of computing the eigendecomposition of $XX^T$ and $X^T X$).

**TL;DR**: Given a data matrix $X$, the principal directions of variation in that
data are given by the eigenvectors of its covariance matrix, and the magnitude
of variation in each of those directions is given by the eigenvalues of the
covariance matrix.
