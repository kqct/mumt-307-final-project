% hammerichPulse gets a Hammerich pulse value at a point.
% n is the input time
% harmonicsCount is the number of harmonics before the filter starts
% rolling off
% filterSlope controls how fast the filter falls off, larger values falling
% slower (0.05 is fast, 1.0 is slow)
% frequency is the fundamental frequency of the produced wave
% sampleRate is self-explanatory, in Hz
function h_H = hammerichPulse(n, harmonicsCount, filterSlope, frequency, sampleRate)
    omegaN = 2 * pi * (frequency / sampleRate) * n;
    h_H = (filterSlope * sin(harmonicsCount * omegaN)) ./ sinh(filterSlope * harmonicsCount * omegaN);
end