function y = sincPulse(x, sampleRate, frequency, harmonicsCount)
    P = sampleRate / frequency;
    sincM = sin(pi * x) ./ (harmonicsCount * sin(pi * x / harmonicsCount));
    y = (harmonicsCount / P) * sincM;
end