#include <cmath>
#include <numeric>
#include <vector>

#include "include/blit.hpp"
#include "include/hammerich.hpp"

namespace sub_synth
{
  class blit
  {
    blit(double sample_rate, double frequency, double filter_slope, double harmonics_count, int overlap_count, pulse &pulse)
      : sample_rate(sample_rate)
        , frequency(frequency)
        , filter_slope(filter_slope)
    {}
    
    double get_sample(double sample)
    {
      double s = sample_rate / frequency;
      double x = sample % s;
      
      std::vector<double> sample_pointers;
      for (int i = 1; i <= overlap_count; i++)
      {
        int ptr = i - round((overlap_count + 1) / 2);
        auto val = sample + ptr * s;
        if (val > overlap_count * s / 2)
        {
          val -= overlap_count * s;
        }
        sample_pointers.push_back(val);
      }

      double blit_val = std::accumulate(sample_pointers.begin(), sample_pointers.end(), 0.0, [](double current, double ptr){return current + blit::pulse->get_sample(ptr); /* multiply by window */});
      return blit_val;
    }
  };
} // end namespace sub_synth
