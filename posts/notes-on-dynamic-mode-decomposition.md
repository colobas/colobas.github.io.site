<!--
.. title: Notes on Dynamic Mode Decomposition
.. slug: notes-on-dynamic-mode-decomposition
.. date: 2019-05-25 05:43:33 UTC+01:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
.. has_math: true
-->

## Intro

These are notes I made to sum up my learnings from watching these two videos about Dynamic Mode Decomposition, by Prof. J. Nathan Kutz:

- [Part I](https://www.youtube.com/watch?v=bYfGVQ1Sg98)
- [Part II](https://www.youtube.com/watch?v=KAau5TBU0Sc)

I highly recommend watching them!

---

## Important concepts

There are some key concepts you should be familiar with to understand DMD. I was a bit rusty on these, so I'm taking the chance to refresh the most important parts here too:

- [Linear Dynamical Systems](#Linear-Dynamical-Systems)
- [Singular Value Decomposition](#Singular-Value-Decomposition)

If you feel comfortable on those two topics, feel free to skip to

- [Dynamic Mode Decomposition](#Dynamic-Mode-Decomposition)


## Linear Dynamical Systems


Let $x(t)$ represent an observation at time $t$ of a system that evolves in continuous time, and $x_t$ represent an observation at time $t$ of a system that evolves in discrete time.

Then, a Linear Dynamical System is one where the following applies (respectively for continous and discrete time):

$$ \frac{d\vec{x(t)}}{dt} = A\vec{x(t)} $$

or

$$ \vec{x_{t+1}} = A\vec{x_t} $$


It can be shown that, the general solution to this differential equation is:

$$ \vec{x_t} = e^{tA}\vec{x_0} $$

Check [this link](http://ee263.stanford.edu/lectures/expm.pdf) from one of Prof. Stephen Boyd's courses, for a good explanation of this.


## Singular Value Decomposition


SVD is a way to factorize any (m x n) matrix into 3 matrices:

$$ A = U\Sigma V^T $$

The matrices have the following shapes:

- $A$ is (m x n)
- $U$ is (m x m) and orthonormal
- $\Sigma$ is (m x n) and diagonal
- $V^T$ is (n x n) and orthonormal

Here's a good reference from the [SVD Wikipedia page](https://en.wikipedia.org/wiki/Singular_value_decomposition) :

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Singular_value_decomposition_visualisation.svg/800px-Singular_value_decomposition_visualisation.svg.png" width="50%">

SVD lends itself to useful interpretations. Say A is a matrix of gene expressions for people, where each column represents the gene expression values for one person. 

Then the matrix U will contain the "eigenpeople": the main directions of variation in the "people"-space.

[Prof. Gilbert Strang's video](https://www.youtube.com/watch?v=mBcLRGuAFUk) is another great resource to understand SVD.

Also, for a quick hint on the relationship between SVD and PCA, check [this Math StackExchange answer](https://math.stackexchange.com/a/3871)


## Dynamic Mode Decomposition


DMD's goal is:

- Given observations of a dynamical system, obtain the matrix A that best describes it.

Let $X$ be a (n x m) matrix, of m observations with n dimensions, from time t=1 to time t=m-1. Let $X'$ be a (n x m) matrix, of m observations with n dimensions, from time t=2 to time t=m. 

We're trying to find A such that $X' = AX$


- Problem: X is possibly very high-dimensional.
- Solution (assumption): X and A have low-rank structure.

Taking this, we do:

- $U\Sigma V^T = SVD(X)$
- With the low-rank assumption, we can approximate: $X = U_r \Sigma_r {V_r}^T$, where the subscript $r$ means we're using only the $r$ most important components. (The assumption's corollary is that these are enough to represent the whole $X$). To choose this $r$, we look at the singular values in $\Sigma$ and decide based on their magnitudes - for instance, if the first 3 singular values are orders of magnitude bigger than the remaining ones, we would do $r=3$.


- $A = X' X^+$ which implies $A = X' V_r {\Sigma_r}^{-1} {U_r}^T$ (where $X^+$ is the pseudo-inverse of $X$)

- Now, rather than working with a big matrix A, we're interested in working with smaller matrices. For that we use a similarity transform. (Recall that similar matrices have the same eigenvalues):
    - $Ã = U^+ A U$
    - $Ã = U^+ X' V \Sigma^{-1} U^T U = U^+ X' V \Sigma^{-1}$

- We then find the eigenvalues and eigenvectors of $Ã$:
    - $ÃW = W\Lambda$, where $W$ has the eigenvectors of $Ã$ on its columns, and $\Lambda$ is diagonal with the eigenvalues of $Ã$ as its diagonal

- Finally, we want to bring the eigenvectors and eigenvalues of $Ã$ back into the original coordinate system:
    - $\Phi = X'V\Sigma^{-1} W$

- This allows us to rewrite our dynamical system as:
    - $\vec{x_t} = \sum_{k=1}^r \vec{\phi_k} e^{\omega_k t} b_k$
    - This formulation allows us to think of the dynamical system in terms of the DMD modes (the $\phi_k$) which I like to regard as "eigenslices", and their respective oscillatory profiles (the $e^{\omega_k t}$ terms), which explain the time dynamics of each DMD mode.
    - Important remark: in a true linear dynamical system, the $\omega_k$ would have no real part, just imaginary, i.e. they would be pure oscillators. However, since in general we're approximating a non-linear system with a linear one, the $\omega_k$ we obtain almost always have a real part, although a really small one, depending on the data. This means that we can't use DMD to describe the system in the long-term, since the real part of the $\omega_k$ will cause the approximated system to either dampen out (if the real part is negative) or blow up (if the real part is positive).


## Conclusion

This is it for now. I'll probably do some code to demo DMD in the future. Also, there's a Python package you can check out if you want to try DMD out: https://github.com/mathLab/PyDMD

