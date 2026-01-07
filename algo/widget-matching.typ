#import "@preview/modern-sjtu-thesis:0.5.1": *

#algox(
  caption: [Widget Matching Algorithm $f(.)$],
  label: <alg:widget-matching>,
  pseudocode-list(line-gap: 1em)[
    - *Input:* Mock-up screen widget set $bold(W)_1 = \{bold(w)_i | bold(w)_i = (x_i, y_i, w_i, h_i, t_i)}$, and the implementation screen widget set $bold(W)_2 = {bold(w)_j | bold(w)_j = (x_j, y_j, w_j, h_j, t_j)\}$.
    - *Output:* Matched pairs between two widget sets $bold(W)_1^{m}$, $bold(W)_2^{m}$

    + $bold(W)_1^{m} <- emptyset, bold(W)_2^{m} <- emptyset$

    + _Step 1: Sort widgets by partial ordering_
    + Sort $bold(W)_1$ such that $(y_i, x_i) <= (y_{i'}, x_{i'}), forall i<i'$
    + Sort $bold(W)_2$ such that $(y_j, x_j) <= (y_{j'}, x_{j'}), forall j<j'$

    + _Step 2: Compute the similarity matrix_
    + Initialize similarity matrix $A <- bold(0)_{|bold(W)_1| times |bold(W)_2|}$
    + *for* $bold(w)_i in bold(W)_1, bold(w)_j in bold(W)_2$ *do*
      + $"sim"_(pos) = min(1/(alpha(|x_i - x_j| + |y_i - y_j|) + |w_i - w_j| + |h_i - h_j|), 1)$
      + $"sim"_(area) = (min ( w_i h_i, w_j h_j )) / (max ( w_i h_i, w_j h_j ))$
      + $"sim"_(shape) = (min ( w_i/h_i, w_j/h_j )) / (max ( w_i/h_i, w_j/h_j ))$
      + $"sim"_(type) = bold(1)(t_i = t_j) + delta bold(1)(t_i != t_j), "where " 0 < delta < 1$
      + $A_{i,j} <- "sim"_(pos) * "sim"_(area) * "sim"_(shape) * "sim"_(type)$
    + *end*

    + _Step 3: LCS-based matching_
    + Initialize the matching matrix $M <- bold(0)_{(|bold(W)_1|+1) \times (|bold(W)_2|+1)}$
    + *for* $i=2, ...|bold(W)_1|, j=2, ...|bold(W)_2|$ *do*
      + $M_{i j} <- max \{ M_{i, j-1}, M_{i-1, j}, M_{i-1, j-1} + A_{i-1, j-1} \}$
    + *end*

    + _Backtrace the matched pairs_
    + $i <- |bold(W)_1|, j <- |bold(W)_2|$
    + *while* $i>1$ *and* $j>1$ *do*
      + *if* $M_{i j} = M_{i-1, j-1} + A_{i-1, j-1}$ *then*
        + $bold(W)_1^{m} <- bold(W)_1^{m} union bold(w)_{i-1}$
        + $bold(W)_2^{m} <- bold(W)_2^{m} union bold(w)_{j-1}$
      + *else if* $M_{i j} = M_{i-1, j}$ *then*
        + $i <- i - 1$
      + *else*
        + $j <- j - 1$
      + *end*
    + *end*
    
    + *return* $bold(W)_1^{m}, bold(W)_2^{m}$
  ]
)
