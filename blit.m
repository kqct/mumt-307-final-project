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
    % make sure x is in the range 1:IPD; we don't need to calculate more
    % than that
    x = mod(x - 1, s);
    % generate our array of sample pointers, one for each overlapping pulse
    samplePointers = zeros(overlapCount, 1);
    for i = 1:overlapCount
        % calculate the current pointer value, which is x - (index * IPD)
        ptr = x - ((i - 1) * s);
        % make sure we have a pointer value within the window (-overlap *
        % IPD:overlap * IPD)
        while (ptr < (-overlapCount * s))
            ptr = ptr + (overlapCount * s);
        end
        % assign to array value
        samplePointers(i) = round(ptr);
    end

    % prep for summation
    y = 0;
    % add the influence of each pointer value
    for j = 1:overlapCount
        % convert pointer to time, using formula
        t = overlapCount * s;
        n = (mod(samplePointers(j) + t/2, t) - t/2) / sampleRate;
        % get the value of the pulse at that value
        curVal = hammerichPulse(n, harmonicsCount, filterSlope, frequency, sampleRate);
        % apply the windowing function to it (currently hardcoded Hamming)
        curVal = curVal * (0.54 - 0.46 * cos(2 * pi * n / (t - 1)));
        % add to the total value
        y = y + curVal;
    end
end