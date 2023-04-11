function H_I = leakyIntegrator(z, sampleRate, cutoffFrequency)
    % from the other paper
    c = 0.9992;
    c = exp(-2 * pi * cutoffFrequency / sampleRate);
    k = (1 + c) / 2;
    b = pi * k * [1 -1];
    a = [1 -2*c c^2];
    %gamma = exp(2 * pi * cutoffFrequency / sampleRate);
    % todo: manually implement this
    H_I = filter(b, a, z);
end