function y = rect(x, cutoff, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount)
    s = cancelledBlit(x, 2, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount);
    y = leakyIntegrator(s, sampleRate, cutoff);
end