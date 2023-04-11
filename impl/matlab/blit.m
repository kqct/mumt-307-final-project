% blit gets the next tick of a Hammerich-based BLIT.
% x is the sample number
% sampleRate is self explanatory
% so is frequency
% filterSlope controls how fast the filter falls off, larger values falling
% slower (0.05 is fast, 1.0 is slow)
% harmonicsCount defines the cutoff frequency – it's the number of
% harmonics we want to allow in the final signal
% overlapCount is a measure of resolution, of sorts - how many pulse
% functions do we wantto calculate at once? a higher number gives greater
% accuracy at the expense of computational power
% windowType defines the window type of each individual pulse. currently
% locked to Hamming
function y = blit(x, sampleRate, frequency, filterSlope, harmonicsCount, overlapCount) % windowType
    % find the number of samples in the inter-pulse distance
    s = sampleRate / frequency;
    t = overlapCount * s;
    % make sure x is in the range 1:IPD; we don't need to calculate more
    % than that
    x = mod(x, s);
    % generate our array of sample pointers, one for each overlapping pulse
    ptrs = (1:overlapCount) - round((overlapCount + 1) / 2);
    ptrs = ptrs(:);
    samplePointers = x + (ptrs * s);
    % make sure they're in the right range
    samplePointers(samplePointers > t/2) = samplePointers(samplePointers > t/2) - t;
    % get the value of the pulse at that value
    pulses = hammerichPulse(samplePointers, sampleRate, frequency, filterSlope, harmonicsCount);
    % apply the windowing function to it (currently hardcoded Hamming)
    pulses = pulses .* hamming(samplePointers, overlapCount * s - 1);
    y = sum(pulses, 1);
    % scale so highest value is 1
    largest = max(y);
    y = y .* 1/largest;
end