so! inputs sample #, frequency, sample rate, overlapCount
outputs n, which is the local time of the pulse (-windowSize/2 to windowSize/2)

sampleLength = 1 sample is 1/sampleRate sec
T0 (the inter-pulse distance) is 1/frequency sec
the total distance a pulse affects is overlapCount * T0
there are s samples in T0, that's s = (1/frequency)/(1/sampleRate) = sampleRate/frequency
this means there are t = overlapCount * s samples total

n = x * sampleLength UNTIL x == t / 2
THEN n = (x - t) * sampleLength until x == t

x must be mod t
so x is constrained to the range \[[0, t)

n(x) = ((x + t/2) % t - t/2) * sampleLength


