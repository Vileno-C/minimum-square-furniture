function coef = MovingLeastSquares(X,Y,sigma,n_intervals,method,fig_x,fig_y,z)
  if length(method) == 0
    error ("Insert a valid method value")
  endif
  # the x coordinate of data points, aka, x_input will be the center
  # of gaussian weight

  # Generating the interval of x values

  size_intervals = idivide(int8(length(X)), int8(n_intervals), "round");
  X_intervals = [];
  Y_intervals = [];
  X_choice = [];

  c = 0;

  for i = 1:n_intervals
    if (c == 0)
       X_intervals = [X_intervals,[X(i+c:(i+c+size_intervals-1))]];
       Y_intervals = [Y_intervals,[Y(i+c:(i+c+size_intervals-1))]];
       c += size_intervals;
    endif
    if (0 < (i + c - 1) && (i + c + size_intervals-2) <= length(X))

      X_intervals = [X_intervals,[X(i+c-1:(i+c+size_intervals-2))]];
      Y_intervals = [Y_intervals,[Y(i+c-1:(i+c+size_intervals-2))]];
      c += size_intervals;
    else

       fim = length(X) - c;

       if (fim >= size_intervals)

         dif = (fim - size_intervals)+1;

         X_intervals = [X_intervals,[X(c:c+fim-dif)]];
         Y_intervals = [Y_intervals,[Y(c:c+fim-dif)]];

       endif
     endif
     middle = min(X_intervals(:,i)) + (max(X_intervals(:,i)) - min(X_intervals(:,i)))/2;
     X_choice = [X_choice,[middle]];

  endfor

  X_intervals;
  Y_intervals;
  X_choice;

  X_v = vander(X);
  n = length(X);
  coef = [];

   if strncmp(method,'linear',length(method))
      k = 1; # a + bx
      X_v = X_v(:,n-k:n);

      for i = 1:length(X_choice)
        W = GaussianMatrix(X, X_choice(i), sigma);

        M = X_v'*W;
        A = M*X_v;
        B = M*Y;

        coef = [coef,[A\B]];
      endfor

   elseif strncmp(method,'quadratic',length(method))
      k = 2; # a + bx + cx^2
      X_v = X_v(:,n-k:n);

      for i = 1:length(X_choice)
        W = GaussianMatrix(X, X_choice(i), sigma);

        M = X_v'*W;
        A = M*X_v;
        B = M*Y;

        coef = [coef,[A\B]];
      endfor

   elseif strncmp(method,'cubic',length(method))
      k = 3; # a + bx + cx^2 + dx^3
      X_v = X_v(:,n-k:n);

      for i = 1:length(X_choice)
        W = GaussianMatrix(X, X_choice(i), sigma);

        M = X_v'*W;
        A = M*X_v;
        B = M*Y;

        coef = [coef,[A\B]];
      endfor

   else
      error ("Insert a valid type of function")
   endif


   # Graphics

   title_1 = cstrcat('MLS approximation with sigma: ',num2str(sigma));
   title_2 = cstrcat('and number of intervals: ',num2str(n_intervals));

   aux = figure(z + (fig_x + fig_y))

   scatter(X,Y)

   title({title_1;title_2})

   hold on

   for j = 1:length(X_choice)

     V = vander(X_intervals(:,j));
     n = length(X_intervals(:,j));
     V = V(:,n-k:n);


     y = V*coef(:,j);

     plot(X_intervals(:,j),y)

     hold on

   endfor

   hold off

   fname = cstrcat('Figura_', num2str(z + (fig_x + fig_y)), '_sigma_',num2str(sigma),'_n_intervals_', num2str(n_intervals));
   fname = cstrcat(fname,'.jpg')

   saveas(aux, fname, 'jpg');

endfunction
