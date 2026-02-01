function w = GaussianWeight(x,center,sigma)
  t = (abs(x-center)/sigma)^2;
  w = exp(-t);
 endfunction
