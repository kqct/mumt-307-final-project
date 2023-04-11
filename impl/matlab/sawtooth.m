function y = sawtooth(x, cutoff, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount)
    s = blit(x, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount);
    y = leakyIntegrator(s, sampleRate, cutoff);
end