---
title: "Multi-resolution Dynamic Mode Decomposition"
date: 2019-05-28 01:00
has_math: true
---

This is a quick post, with the purpose of sharing the idea of Multi-resolution
Dynamic Mode Decomposition. It's a simple yet very clever extension of the
Vanilla Dynamic Mode Decomposition, about which I wrote 
[on another post](https://gpir.es/posts/notes-on-dynamic-mode-decomposition/)

I wrote it while learning about the topic, so it's mostly for myself. For a much
better explanation, please check:

- [This video abstract](https://www.youtube.com/watch?v=E1dNE02LaCE)
- [The original paper](https://arxiv.org/pdf/1506.00564.pdf)

___

DMD allows us to find the linear dynamical system that best describes the data
we have at hand. I.e., it finds a matrix $A$ that turns $\frac{dx}{dt} = Ax$
into a good approximation of the system where our data comes from.

This in turn allows us to write down our system as a combination of 
eigenfunctions and DMD modes:

\begin{align*}
x_t = \sum_{k=1}^{M} \phi_k e^{\omega_k t} b_k
\end{align*}

The idea of multi-resolution DMD starts with separating that sum into
"slow modes" and "fast modes". These are distinguished by their frequencies
$\omega_k$. So we rewrite the above as:

\begin{align*}
x_t = \underbrace{\sum_{k=1}^{m_1} \phi_k e^{\omega_k t} b_k
}_{\hbox{slow modes}} +
\underbrace{
\sum_{k=m_1+1}^{M} \phi_k e^{\omega_k t} b_k
}_{\hbox{fast modes}}
\end{align*}

The threshold for what is considered a slow mode versus a fast mode is obviously
tunable. One sensible thing to do is to look at the singular values and how
they distribute about the origin, define a maximum radius and divide the modes
according to what singular values lie inside or outside the radius.

After distinguishing the slow and fast modes, we subtract the slow modes from
the data and we split the data in 2. Now we apply the previous procedure on
each of the chunks. At the end we split each of the chunks in 2, and so on.

After going as deep as we want in this hierarchy, we can rewrite the system as:

\begin{align*}
x_t = \sum_{L}^{l=1}\sum_{J}^{j=1}\sum_{m_L}^{k=1}
f_{l,j}(t) b_k^{(l,j)}  \phi_k^{(l,j)}(\xi) \exp(\omega_k^{(l,j)} t)
\end{align*}

Where:

- $f_{l,j}(t)$ is a "switch" that is on when $t \in [t_j, t_{j+1}]$
- $l = 1,2,...,L$ is the decomposition level ($L$ is the deepest level)
- $j = 1,2,...,J$ is the number of subdivisions per decomposition level
($J = 2^{(l-1)}$ since we're always splitting in two)
- $k = 1,2,...,m_L$ is the mode index ($m_L$ is the max mode index at level $L$)
- $\xi$ are the spatial coordinates

This basically allows us to have a local system per $(l,j)$:
\begin{align*}
\frac{dx^{(l,j)}}{dt} = A^{(l,j)} x^{(l,j)}
\end{align*}
