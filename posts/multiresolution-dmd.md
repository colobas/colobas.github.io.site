---
title: "Multi-resolution Dynamic Mode Decomposition"
date: 2019-05-28 01:00
has_math: true
---

This is a quick post, with the purpose of sharing the idea of Multi-resolution
Dynamic Mode Decomposition. It's a simple yet very clever extension of the
Vanilla Dynamic Mode Decomposition, about which I wrote 
[on another post](https://gpir.es/posts/notes-on-dynamic-mode-decomposition/)

DMD allows us to find the linear dynamical system that best describes the data
we have at hand. I.e., it finds a matrix $A$ that turns $\frac{dx}{dt} = Ax$
into a good approximation of the system where our data comes from.

This in turn allows us to write down our system as a combination of 
eigenfunctions and DMD modes:

\begin{align*}
x_t = \sum_{k=1}^{\infty} \phi_k e^{\omega_k t} b_k
\end{align*}
