#include <exception>

#include "include/pulse.hpp"

namespace sub_synth
{
  class pulse
  {
    public:
      pulse(double sample_rate, double frequency)
        : sample_rate(sample_rate)
          , frequency(frequency)
      {}

      void set_sample_rate(double new_rate)
      {
        if (sample_rate <= 0) throw std::invalid_argument("sample rate must be non-negative");
        this->sample_rate = new_rate;
      }

      void set_frequency(double new_frequency);
      {
        if (sample_rate <= 0) throw std::invalid_argument("frequency must be non-negative");
        this->frequency = new_frequency;
      }
  };
} // end namespace sub_synth
