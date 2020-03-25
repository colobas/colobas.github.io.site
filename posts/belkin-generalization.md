---
title: "Paper summary: Reconciling moder machine-learning with the bias-variance trade-off"
date: 2019-07-06 17:00
has_math: true
---

In this post I'll do an ultra quick skim over Prof. Mikhail Belkin's awesome
paper "Reconciling moder machine-learning with the bias-variance trade-off".
**All images in this post where taken from the paper.**

For a complete explanation of these ideas:

- Read [the paper](https://arxiv.org/pdf/1812.11118.pdf)
- Watch [this video lecture](http://www.fields.utoronto.ca/video-archive/static/2018/11/2509-19885/mergedvideo.ogv)

This paper is a step in the direction of understanding why Deep Learning... works.

The classical way in which a modeller picks the complexity of the model (s)he
will fit is by bearing the following plot in mind:
![](/images/u-shaped-curve.png){ max-width=80% }

Here it's easy to see that there's a point from which on increasing complexity
translates to degrading test performance. In the classical scenario, model
complexity is tuned to be close to the minimum of this U-shaped curve: the
sweet-spot between having enough expressiveness to fit closely enough to the
training data, and not being too expressive so as to not simply memorize
the training data (what's commonly called **overfitting**).

However, in the era of Deep Learning, the case is, more often than not, that we
have extremely complex models - where the number of parameters is much larger
than the number of training samples - which are almost perfectly fitted to
training data, reaching very low training error, and are still able to generalize.
This contradicts the classical view, and still requires a complete theoretical
explanation. Prof. Belkin's work is a very interesting step in the direction
of that explanation.

The paper's central idea is that there is another regime, classically not considered,
after the interpolation threshold of model complexity (for many models this
just means having at least as many parameters as data points). From this point
on, models are able to perfectly fit the training data, but their test risk
starts decreasing again, which creates what the paper describes as a "double
descent curve":
![](/images/double-descent-curve.png){ max-width=80% }

But why would this happen? The first thing to notice is that, after the
interpolation threshold, the training error basically drops to zero, regardless
of the number of parameters: so clearly Empirical Risk Minimization stops being
a proxy for the true performance. According to the paper, the answer lies in
the appropriate definition of the inductive bias associated with each problem.
They suggest that a function-space norm (i.e., a norm defined over a space of
functions - e.g., the $l_2$-norm of the parameter vector of a parametric family)
can be an appropriate proxy for the inductive bias. The punchline is that
a vector with more elements can have a smaller norm than a vector with fewer
elements, so if that norm is an actual measure of the simplicity (regularity)
of the learned function, it's possible that we can access simpler (more regular)
learned functions with more complex model families. The paper claims that using
such a norm in this manner constitutes a form of Occam's razor.

The paper presents empiricial evidence for these claims using a parametric
model. They fit the model in the classical regime, and in the "modern" regime,
varying the number of parameters $n$. For each $n$, given solutions which yield
the same training error, they choose the one with the smallest $l_2$-norm. Doing
so they obtain the predicted "double descent curve". Moreover, they plot the
value of the solution's $l_2$-norm for each $n$, and it decreases as predicted
after the interpolation threshold:
![](/images/rff-belkin.png){ max-width=80% }

I found these ideas extremely interesting, and invite everyone to read the paper.

