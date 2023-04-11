#include "pulse.hpp"

namespace sub_synth
{
  class hammerich : public pulse
  {
    public:
      hammerich(double sample_rate, double frequency, double filter_slope, double harmonics_count);

      double get_sample(int sample) override;
  
      void set_filter_slope(double new_slope);
  
      void set_harmonics_count(double new_count);
  
      ~hammerich();
    private:
      double filter_slope;
      int harmonics_count;
  };
} // end namespace sub_synth
