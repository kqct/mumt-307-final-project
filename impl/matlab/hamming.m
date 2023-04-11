function window = hamming(x, totalCount)
    % the hamming window starts from 0. we start from 1. solution: subtract
    window = 1 - (0.54 - 0.46 * cos((2 * pi * x) / totalCount));
end