---
title: "Singular Value Decomposition"
date: 2019-05-27 19:00
has_math: true
---

# Singular Value Decomposition

- Take any matrix $A$. Generally speaking, what it does to a vector $\vec{x}$ 
is stretch it and rotate it.

- Now let's consider that a matrix A does to a unitary circle:

![matrix multiplication](images/matrix-multiplication.png){ width=80% }

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
}_{U\to (m\times m)}
\
\underbrace{\begin{bmatrix}
\ & & \\
\ & \hat{\Sigma} &\\
\ & & \\
\hline
\ 0 & ...  & 0 \\
\ 0 & ... & 0 \\
\end{bmatrix}}_{\Sigma\to (m\times n)}
\
\underbrace{\begin{bmatrix}
& & \\
& V^* &\\
& & \\
\end{bmatrix}}_{(n\times n)}
\end{align*}


___

# PCA

Let $X$ be a (centered) $m \times n$ data matrix. Then $\frac{1}{n-1}XX^T$ is 
the corresponding covariance matrix.

If there are non-zero off-diagonal values in the covariance matrix, that means
that the coordinates we picked have some redundancy.

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

And we now $\Lambda$ is diagonal, so we successfully found a coordinate
transform where off-diagonal values of the covariance matrix are 0, hence
minimizing redundancy. Remember, to obtain $Y$, we hit $X$ with $S^T$


