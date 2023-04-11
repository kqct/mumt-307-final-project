#include <cmath>
#include <exception>
#include <numbers>
#include <stdexcept>

#include "include/hammerich.hpp"

namespace sub_synth
{
  class hammerich : public pulse
  {
    hammerich(double sample_rate, double frequency, double filter_slope, int harmonics_count)
      : pulse(sample_rate, frequency)
        , filter_slope(filter_slope)
        , harmonics_count(harmonics_count)
    {}
  
    double get_sample(double sample) override
    {
      if (sample < 0) throw std::invalid_argument("Sample must be non-negative integer!");
      double omega = 2 * std::number::pi * (frequency / sample_rate);
      return filter_slope * sin(harmonics_count * omega * sample) / (sinh(filter_slope * harmonics_count * omega * sample) + std::numeric_limits<double>::epsilon());
    }

    void set_filter_slope(double new_slope)
    {
      this->filter_slope = new_slope;
    }
  
    void set_harmonics_count(double new_count)
    {
      this->harmonics_count = new_count;
    }
  };
} // end namespace sub_synth
