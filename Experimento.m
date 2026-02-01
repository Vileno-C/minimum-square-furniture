function Experimento(X,Y,sigmas,intervalos)

  n_sigmas = length(sigmas)
  n_intervalos = length(intervalos)

  for i = 1:n_sigmas
    for j = 1:n_intervalos
      MovingLeastSquares(X,Y,sigmas(i),intervalos(j), method = 'linear', i, j,w = i*10)
      MovingLeastSquares(X,Y,sigmas(i),intervalos(j), method = 'quadratic', i, j,w = i*100)
      MovingLeastSquares(X,Y,sigmas(i),intervalos(j), method = 'cubic', i, j,w = i*1000)
    endfor
  endfor


endfunction
