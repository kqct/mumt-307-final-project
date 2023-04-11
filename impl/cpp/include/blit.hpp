#include "pulse.hpp"

namespace sub_synth
{
  class blit
  {
    public:
      blit(double sample_rate, double frequency, double filter_slope, double harmonics_count, double overlap_count, pulse &pulse);

      double get_sample(double sample);

      ~blit();

    private:
      double sample_rate;
      double frequency;
      double filter_slope;
      int harmonics_count;
      int overlap_count;
      pulse &pulse; // defaults to hammerich rn
  };
} // end namespace sub_synth
