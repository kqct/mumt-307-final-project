function y = triangle(x, cutoff, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount)
    s = rect(x, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount);
    y = leakyIntegrator(s, sampleRate, cutoff);
end