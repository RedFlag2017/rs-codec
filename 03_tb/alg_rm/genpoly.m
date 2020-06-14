% Find the Reed-Solomon generating polynomial g(x), by the way this is the
% same as the rsgenpoly function on matlab
function g = genpoly(k, n, alpha)
    g = 1;
    % A multiplication on the galois field is just a convolution
    for k = mod(1 : n-k, n)
        g = conv(g, [1 alpha .^ (k)]);
    end
end