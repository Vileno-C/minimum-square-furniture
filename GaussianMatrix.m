function diagW = GaussianMatrix(x_input, x_mesh, sigma)

  n = length(x_input);
  W = zeros(n,n);
  S = 0;
  # We will evaluete W
  for i = 1:n
    for j = 1:n
      S += GaussianWeight(x_input(i), x_mesh, sigma);
    endfor
    W(i,i) = S;
    S = 0;
  endfor

  diagW = W;

endfunction
